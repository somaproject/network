library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity outping is
    Port (CLKIN : in std_logic;  
    		IFCLK : in std_logic; 
	 	RESET : in std_logic; 
           CLKOUT : out std_logic;
           DOUT : out std_logic_vector(15 downto 0);
           NEWFRAME : out std_logic;
           DIN : in std_logic_vector(15 downto 0);
           DINEN : in std_logic;
           NEXTFRAME : out std_logic;
		  SCLK : out std_logic; 
		  SIN : out std_logic; 
		  SOUT : in std_logic; 
		  SCS : out std_logic;
		  DATA : inout std_logic_vector(15 downto 0); 
		  ADDR : in std_logic_vector(7 downto 0); 
		  RW : in std_logic; 
		  CMD : in std_logic;
		  SAMPLE : out std_logic;  
		  DONE : out std_logic;
		  STARTTX : in std_logic;
		  LEDS : out std_logic_vector(1 downto 0);
		  LENOUT : out std_logic_vector(7 downto 0)	);
end outping;

architecture Behavioral of outping is
-- OUTPING.VHD -- designed to simply output pings via the expected interface. 
 
	signal clk, clk_to_bufg, clksl, clksl_to_bufg : std_logic := '0'; 
	signal ramaddr : std_logic_vector(7 downto 0) := (others => '0');
	signal ramdata : std_logic_vector(15 downto 0) := (others => '0');
	signal lnewframe, gotx, cnten : std_logic := '0'; 
	signal cnt, incnt : integer range 0 to 2**26-1 := 0; 

	type states is (none, getlen, donef, waitlen);
	signal cs, ns : states := none; 
	signal lnextframe, dinenl : std_logic := '0'; 
	signal waitcnt, dinencnt : integer range 0 to 200 := 0;
	signal dinl : std_logic_vector(15 downto 0) := (others => '0');  

	component NICserial is
	    Port ( IFCLK : in std_logic;
		 		  RESET : in std_logic; 
	           SCLK : out std_logic;
	           SCS : out std_logic;
	           SIN : out std_logic;
	           SOUT : in std_logic;
				  DATA : inout std_logic_vector(15 downto 0); 
				  ADDR : in std_logic_vector(7 downto 0); 
				  RW : in std_logic; 
				  CMD : in std_logic;
				  SAMPLE : out std_logic;  
				  DONE : out std_logic);
	end component;

	component CLKDLL
			generic (CLKDV_DIVIDE : in real := 4.0); 
	      port (CLKIN, CLKFB, RST : in STD_LOGIC;
	      CLK0, CLK90, CLK180, CLK270, CLK2X, CLKDV, LOCKED : out std_logic);
	end component;
	component RAMB4_S16
	  generic (
	       INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"); 
	  port (DI     : in STD_LOGIC_VECTOR (15 downto 0);
	        EN     : in STD_logic;
	        WE     : in STD_logic;
	        RST    : in STD_logic;
	        CLK    : in STD_logic;
	        ADDR   : in STD_LOGIC_VECTOR (7 downto 0);
	        DO     : out STD_LOGIC_VECTOR (15 downto 0)); 
	end component;

begin

	rom : RAMB4_S16 generic map (
			INIT_00 => X"0100A8C0de59014000400000540000450008E38B18E90700FFFFFFFFFFFF00FE",
			INIT_01 => X"0E0D0C0B0A0908000756AF3FB2A2791D2048265EE40008FF4f3dC0081211100F",
			INIT_02 => X"333231302F2E2D2C2B2A292827262524232221201F1E1D1C1B1A191817161514",
			INIT_03 => X"0000000000000000000000000000000000000000000000000000000037363534",
			--INIT_00 => X"0000000000000000000000000000080786050403020101234567765432102000",
			--INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
			--INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
			--INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000")
			port map (
				DI => X"0000",
				EN => '1',
				WE => '0',
				RST => RESET,
				CLK => clk,
				ADDR => ramaddr,
				DO => ramdata); 

	CLKOUT <=  not clk;
	serialio: NICserial port map (	
			IFCLK => IFCLK,
			RESET => RESET,
			SCLK => SCLK,
			SCS => SCS,
			SIN => SIN,
			SOUT => SOUT,
			DATA => DATA,
			ADDR => ADDR,
			RW => RW,
			CMD => CMD,
			SAMPLE => SAMPLE,
			DONE => DONE); 

	 clk_DLL : CLKDLL generic map (
	 		CLKDV_DIVIDE => 2.0)
			port map (
			CLKIN => CLKIN,
			RST => RESET,
			CLKFB => clk,
			CLK0 => clk_to_bufg,
			CLKDV => clksl_to_bufg); 

	clk_bufg : BUFG port map (
			I => clk_to_bufg,
			O => clk); 
	clksl_bufg : BUFG port map (
			I => clksl_to_bufg,
			O => clksl); 

	clock : process(clk) is
	begin
		if rising_edge(clk) then
			
			DOUT <= ramdata; 

			if starttx = '1' then
				cnten <= '1';
			end if; 

			if cnten = '1' then
				if cnt = 180 then
					cnt <= 0;
				else
					cnt <= cnt + 1; 
				end if; 
			end if; 

			if cnt  = 1 then
				ramaddr <= X"FF";

			else
				if not(ramaddr = X"FE") then
					ramaddr <= ramaddr + 1;
				end if; 
			end if; 

			if ramaddr = X"00" then
				lnewframe <= '1';
			elsif ramaddr = X"83" then
				lnewframe <= '0'; 
			end if; 

			NEWFRAME <= lnewframe; 


			
		end if; 
	end process clock; 
	
     -- test input
	inputtest: process(RESET, CLK) is
	begin
		if RESET = '1' then
			cs <= none;
		else
			if rising_edge(CLK) then
			    cs <= ns; 
			    NEXTFRAME <= lnextframe; 

			    dinenl <= DINEN;
			    dinl <= DIN;   
			    if cs = getlen and dinenl = '1' then
			    	  lenout <= dinl(7 downto 0);
			    end if; 

			    if  dinenl = '1' then
			    	  LEDS(0) <= '1';
				else
				  LEDS(0) <= '0';
 	              end if; 

			   
			   if cs = getlen then 
			   	waitcnt <= 100;
			   else 
			   	  if cs = waitlen then
				  	waitcnt <= waitcnt - 1;
				  end if; 
			   end if; 
			   
			   if cs = none then 
			   	dinencnt <= 0;
			   else
			   	if dinenl = '1' then
					dinencnt <= dinencnt + 1;
				end if;
			   end if;
			   
			   
			   -- byte checks
			   if dinenl = '1' then
			   	if dinencnt = 0 then
					if dinl = X"0062" then
						LEDS(1) <= '1';
					else 
						LEDS(1) <= '0';
					end if; 
				end if; 
			   	if dinencnt = 1 then
					if dinl = X"FFFF" then
						LEDS(1) <= '1';
					else 
						LEDS(1) <= '0';
					end if; 
				end if; 
			   	if dinencnt = 2 then
					if dinl = X"FFFF" then
						LEDS(1) <= '1';
					else 
						LEDS(1) <= '0';
					end if; 
				end if; 
			   	if dinencnt = 3 then
					if dinl = X"FFFF" then
						LEDS(1) <= '1';
					else 
						LEDS(1) <= '0';
					end if; 
				end if; 
			   	if dinencnt = 4 then
					if dinl = X"0700" then
						LEDS(1) <= '1';
					else 
						LEDS(1) <= '0';
					end if; 
				end if; 
			   	if dinencnt = 5 then
					if dinl = X"18E9" then
						LEDS(1) <= '1';
					else 
						LEDS(1) <= '0';
					end if; 
				end if;
				if dinencnt = 6 then
					LEDS (1) <= '0';
				end if;  
					 
			  end if;  	

			end if;
		end if; 
					 
	end process; 

	inputfsm : process(cs) is
	begin
		case cs is
			when none =>
				lnextframe <= '0';
				ns <= getlen; 
			when getlen => 
				lnextframe <= '1'; 
				if dinenl = '1' then 
					ns <= waitlen;
				else
					ns <= getlen;
				end if; 
			when waitlen =>
				lnextframe <= '1';  
				if waitcnt = 0 then
					ns <= donef; 
				else
					ns <= waitlen;
				end if; 
			when donef => 
				lnextframe <= '0';
				ns <= none;
			when others =>
				lnextframe <= '0';
				ns <= none;
		end case; 
	end process inputfsm; 

					
end Behavioral;
