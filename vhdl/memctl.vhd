library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity memctl is
    Port ( CLK : in std_logic;
           CLK4X : in std_logic;
           CLK1 : in std_logic;
           CLK2 : in std_logic;
           CLK3 : in std_logic;
           CLK4 : in std_logic;
			  MEMCLK: out std_logic; 
			  CLKNUM : in std_logic_vector(1 downto 0); 
           ADDR1 : in std_logic_vector(21 downto 0);
           ADDR2 : in std_logic_vector(21 downto 0);
           ADDR3 : in std_logic_vector(21 downto 0);
           ADDR4 : in std_logic_vector(21 downto 0);
           WE1 : in std_logic;
           WE2 : in std_logic;
           WE3 : in std_logic;
           WE4 : in std_logic;
           D1 : in std_logic_vector(31 downto 0);
           D2 : in std_logic_vector(31 downto 0);
           D3 : in std_logic_vector(31 downto 0);
           D4 : in std_logic_vector(31 downto 0);
           Q1 : out std_logic_vector(31 downto 0);
           Q2 : out std_logic_vector(31 downto 0);
           Q3 : out std_logic_vector(31 downto 0);
           Q4 : out std_logic_vector(31 downto 0);
           ADDR : out std_logic_vector(21 downto 0);
           WE : out std_logic;
           DQ : inout std_logic_vector(31 downto 0));
end memctl;

architecture Behavioral of memctl is
--	 MEMCTL : memory controller. Designed to provide pseudo-four-port behavior
--  from a single pipelined ZBT sync SRAM.

	 signal ADDRn : std_logic_vector(21 downto 0);
	 signal WEn, OE, OEL, TS: std_logic;
	 signal Dn, DnL1, DnL2, DnOut, QOut, Qn : std_logic_vector(31 downto 0); 
	 	
	 component IOBUF
      port (I, T: in std_logic; 
            O: out std_logic; 
            IO: inout std_logic);
	  end component;   


begin

	MEMCLK <= CLK4X; 
	-- tri-state output buffers
	tristate_output: for index in 0 to 31 generate
	begin
		TB: IOBUF port map (
				I => DnOut(index),
				T => TS,
				O => Qout(index),
				IO =>	DQ(index));
	end generate tristate_output;
	
	
	main: process(CLK, CLK4X, ADDRn, WEn, OEL, DnL2, Qout, OE, Dn, DnL1, CLK1, CLK2, CLK3, CLK4) is
	begin
		if rising_edge(CLK4X) then
			-- registered IO : 
				ADDR <= ADDRn;
				WE <= WEn;
				TS <= OEL;
				DnOUT <= DnL2;
				Qn <= Qout;

			
			
			-- tristate pipeline registers
				OE <=  WEn;
				OEL <= OE;
			
				DnL1 <= Dn;
				DnL2 <= DnL1;
		  -- outputs

				if CLK1 = '1' then
					Q1 <= Qn;
				end if;
																		
				if CLK2 = '1' then
					Q2 <= Qn;
				end if;
																		
				if CLK3 = '1' then
					Q3 <= Qn;
				end if;
																		
				if CLK4 = '1' then
					Q4 <= Qn;
				end if;
		end if; 
					
	end process main; 

		
		-- combinational multiplexers
		
		ADDRmux:	ADDRn <= ADDR1 when CLKNUM = "00" else
								ADDR2 when CLKNUM = "01" else
								ADDR3 when CLKNUM = "10" else
								ADDR4;

		WEMux: WEn <= WE1 when CLKNUM = "00" else
								WE2 when CLKNUM = "01" else
								WE3 when CLKNUM = "10" else
								WE4;

		DATAmux: Dn <= D1 when CLKNUM = "00" else
								D2 when CLKNUM = "01" else
								D3 when CLKNUM = "10" else
								D4;

end Behavioral;
