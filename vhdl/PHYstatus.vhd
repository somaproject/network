library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PHYstatus is
    Port ( CLK : in std_logic;
           PHYDIN : in std_logic_vector(15 downto 0);
           PHYDOUT : out std_logic_vector(15 downto 0);
           PHYADDRSTATUS : out std_logic;
           PHYADDR : in std_logic_vector(5 downto 0);
           PHYADDRR : in std_logic;
           PHYADDRW : in std_logic;
           PHYSTAT : out std_logic_vector(31 downto 0);
           RESET : in std_logic;
			  MDIO : inout std_logic;
			  MDC : out std_logic );
end PHYstatus;

architecture Behavioral of PHYstatus is
-- PHYSTATUS.VHD -- controls the MII serial interface as well as handling
-- the challenging parts of the MAC serial interface. 

   -- signals for phy inputs:
	signal addrl, miiaddr : std_logic_vector(4 downto 0) := (others => '0');
	signal rwl, miirw : std_logic := '0';

	signal din, dout : std_logic_vector(15 downto 0) := (others => '0');

	signal phyaddrdone, phyaddrws : std_logic := '0';

	type states is (read1k, read1kw, readlink, readlinkw, phyl, miiio,
						 miiiow, miiio_done);

	signal cs, ns : states := read1k; 

	signal start, done : std_logic := '0';

	signal miisel : integer := 0; 

	component MII is
    Port ( CLK : in std_logic;
    		  RESET : in std_logic; 
           MDIO : inout std_logic;
		     MDC : out std_logic; 
           DIN : in std_logic_vector(15 downto 0);
           DOUT : out std_logic_vector(15 downto 0);
           ADDR : in std_logic_vector(4 downto 0);
           START : in std_logic;
		     RW : in std_logic; 
           DONE : out std_logic);
   end component;

begin

   MII_Interface: MII port map (
			 CLK => CLK,
			 RESET => RESET,
			 MDIO => MDIO,
			 MDC => MDC, 
			 DIN => din,
			 DOUT => dout,
			 ADDR => miiaddr,
			 START => start,
			 RW => miirw,
			 DONE => done);



	clock : process(CLK, RESET) is
	begin
		if RESET = '1' then
			cs <= read1k;
		else
			if rising_edge(CLK) then
				cs <= ns;

				-- phyaddr latches
				if cs = phyl then
					addrl <= PHYADDR(4 downto 0);
					rwl <= PHYADDR(5);
				end if;

				-- din and dout latches
				if cs = phyl then
					din <= PHYDIN;
					PHYDOUT <= dout; 
				end if; 

				-- phy addr write set				
				if phyaddrdone = '1' then
					phyaddrws <= '0';
				else
					if phyaddrw = '1' then
						phyaddrws <= '1';
					end if;
				end if; 

				-- phy addr done
				if PHYADDRR = '1' then
					phyaddrstatus <= '0'; 
				else
					if phyaddrdone = '1' then
						phyaddrstatus <= '1';
					end if; 
				end if; 		

				if done = '1' and miisel = 0 then
					PHYSTAT(15 downto 0) <= dout;
				end if;
				
				if done='1' and miisel = 1 then
					PHYSTAT(31 downto 16) <= dout; 
				end if;  

				if cs = phyl then 
					PHYDOUT <= dout;
				end if; 



		
				

			end if;
		end if; 
	end process clock; 


	miiaddr <= "10001" when miisel = 0 else
				  "01111" when miisel = 1 else
				  addrl;
	miirw <= '0' when miisel = 0 else
				  '0' when miisel = 1 else
				  rwl;


	fsm : process(cs, ns, done, phyaddrws) is
	begin
		case cs is 
			when read1k =>
				start <= '1';
				miisel <= 0;
				phyaddrdone <= '0';
				ns <= read1kw;
			when read1kw =>
				start <= '0';
				miisel <= 0;
				phyaddrdone <= '0';
				if done = '1' then
					ns <= readlink;
				else
					ns <= read1kw;
				end if; 
			when readlink =>
				start <= '1';
				miisel <= 1;
				phyaddrdone <= '0';
				ns <= readlinkw;
			when readlinkw =>
				start <= '0';
				miisel <= 1;
				phyaddrdone <= '0';
				if done = '1' then
					ns <= phyl;
				else
					ns <= readlinkw;
				end if; 
			when phyl =>
				start <= '0';
				miisel <= 2;
				phyaddrdone <= '0';
				if phyaddrws = '1' then
					ns <= miiio;
				else
					ns <= read1k;
				end if; 
			when miiio =>
				start <= '1';
				miisel <= 2;
				phyaddrdone <= '0';
				ns <= miiiow;
			when miiiow =>
				start <= '0';
				miisel <= 2;
				phyaddrdone <= '0';
				if done = '1' then
					ns <= miiio_done;
				else
					ns <= miiiow;
				end if; 
			when miiio_done =>
				start <= '0';
				miisel <= 0;
				phyaddrdone <= '1';
				ns <= read1k;
			when others => 
				start <= '0';
				miisel <= 0;
				phyaddrdone <= '0';
				ns <= read1k;
 		end case;
	end process fsm; 

end Behavioral;
