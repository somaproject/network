library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity outping is
    Port ( CLKIN : in std_logic;
	 		  IFCLK : in std_logic; 
	 		  RESET : in std_logic; 
           CLKOUT : out std_logic;
           NEXTFRAME : out std_logic;
           DOUT : out std_logic_vector(15 downto 0);
           NEWFRAME : out std_logic;
			  SCLK : out std_logic; 
			  SIN : out std_logic; 
			  SOUT : in std_logic; 
			  SCS : out std_logic;
			  DATA : inout std_logic_vector(15 downto 0); 
			  ADDR : in std_logic_vector(7 downto 0); 
			  RW : in std_logic; 
			  CMD : in std_logic;
			  SAMPLE : out std_logic;  
			  DONE : out std_logic
			  );
end outping;

architecture Behavioral of outping is
-- OUTPING.VHD -- designed to simply output pings via the expected interface. 

 
	-- clocking
	signal clk, clk_to_bufg, clksl, clksl_to_bufg : std_logic := '0'; 

	signal starttx : std_logic := '0'; 
	signal ramaddr : std_logic_vector(7 downto 0) := (others => '0');
	signal ramdata : std_logic_vector(15 downto 0) := (others => '0');
	signal lnewframe : std_logic := '0';


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
				  DONE : out std_logic;
			  	  SETBIT : out std_logic);
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
			INIT_00 => X"0100A8C058B8014000400000540000450008E38B18E90700FFFFFFFFFFFF0016",
			INIT_01 => X"0E0D0C0B0A0908000756AF3FB2A2791D2048265EE40008FF00A8C0131211100F",
			INIT_02 => X"333231302F2E2D2C2B2A292827262524232221201F1E1D1C1B1A191817161514",
			INIT_03 => X"0000000000000000000000000000000000000000000000000000000037363534",
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
				CLK => clksl,
				ADDR => ramaddr,
				DO => ramdata); 

	CLKOUT <= clksl; 

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
			DONE => DONE,
			SETBIT => starttx); 

	 clk_DLL : CLKDLL generic map (
	 		CLKDV_DIVIDE => 2.5)
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

	clock : process(clksl) is
	begin
		if rising_edge(clksl) then
			
			DOUT <= ramdata; 

			if starttx = '1' then
				ramaddr <= X"FF";
			else
				if not(ramaddr = X"FE") then
					ramaddr <= ramaddr + 1;
				end if; 
			end if; 

			if ramaddr = X"00" then
				lnewframe <= '1';
			elsif ramaddr = X"32" then
				lnewframe <= '0'; 
			end if; 

			NEWFRAME <= lnewframe; 

		end if; 
	end process clock; 

						
end Behavioral;
