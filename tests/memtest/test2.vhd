library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test2 is
    Generic ( startdata : in std_logic_vector(31 downto 0) := X"ABCDEF98";	
    		    startaddr : in std_logic_vector(14 downto 0) := (others => '0'));
    Port ( CLK : in std_logic;
           CE : in std_logic;
           WE : out std_logic;
           D : out std_logic_vector(31 downto 0);
           Q : in std_logic_vector(31 downto 0);
           ADDR : out std_logic_vector(14 downto 0);
		 err : out std_logic; 
		 RESET : in std_logic);
end test2;

architecture Behavioral of test2 is
-- TEST2.VHD -- basic memory test, uses LFSRs to check memory
-- workings


   signal addrcnt: std_logic_vector(14 downto 0) := (others =>'0'); 
   signal datacnt : std_logic_vector(31 downto 0) := (others => '0'); 

   signal cyclecnt: integer range 0 to 31 := 0; 

begin
	
	ADDR <= addrcnt; 
	D <= datacnt; 

	main: process (CLK, RESET) is
	begin
		if rising_edge(clk) then
			if RESET = '1' then
				addrcnt <= startaddr;
				datacnt <= startdata;
				cyclecnt <= 0; 
			else
				if cyclecnt = 0 then
					if CE = '1' then
						cyclecnt <= 1;
					else
						cyclecnt <= 0;
					end if;
				
				else	
					if cyclecnt = 10 then
						cyclecnt <= 0;
					else
						cyclecnt <= cyclecnt + 1;
					end if;  
				end if;

				if cyclecnt = 9 then
					if Q(31 downto 0) = datacnt(31 downto 0)  then
						err <= '0';
					else	
						err <= '1';
					end if; 
				end if; 
				if cyclecnt = 10 then
					err <= '0';			   
					addrcnt <= addrcnt(13 downto 0) & 
					(addrcnt(13) xnor addrcnt(14));

					datacnt <= datacnt(30 downto 0) & 
					(datacnt(31) xnor datacnt(22) xnor
					datacnt(2) xnor datacnt(1));  
					 
				end if; 
			end if; 
		end if; 
	end process main;
	
	WE <= '1' when cyclecnt = 0 else '0'; 
	
	 
end Behavioral;
