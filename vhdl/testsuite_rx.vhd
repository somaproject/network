library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity testsuite_rx is
    Port ( CLK : in std_logic;
	 		  RX_CLK : in std_logic;
			  RX_DV : in std_logic;
			  RXD : in std_logic_vector(7 downto 0) ;  
			  RESET : in std_logic;  
           MACADDR : in std_logic_vector(7 downto 0);
           MACDATA : out std_logic_vector(15 downto 0);
			  NEXTF : in std_logic;
			  TESTOUT : out std_logic);
end testsuite_rx;

architecture Behavioral of testsuite_rx is

	signal macaddrl : std_logic_vector(7 downto 0) := (others => '0');
	signal lmacdata : std_logic_vector(15 downto 0) := (others => '0'); 

	type ramstates is (none, writeframe, doneframe, waitnext);
	signal cs, ns : ramstates := none; 
	signal nextfl : std_logic := '0' ; 

   -- for ram input
	signal rx_dvl, rx_dvll, ramwe : std_logic := '0';
	signal rxdl, rxdll : std_logic_vector(7 downto 0) := (others => '0');
	signal addr : std_logic_vector(7 downto 0) := (others => '0'); 
	signal ramaddrin : std_logic_vector(8 downto 0) := (others => '0'); 

	component RAMB4_S8_S16
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

	  port (DIA    : in STD_LOGIC_VECTOR (7 downto 0);
	        DIB    : in STD_LOGIC_VECTOR (15 downto 0);
	        ENA    : in STD_logic;
	        ENB    : in STD_logic;
	        WEA    : in STD_logic;
	        WEB    : in STD_logic;
	        RSTA   : in STD_logic;
	        RSTB   : in STD_logic;
	        CLKA   : in STD_logic;
	        CLKB   : in STD_logic;
	        ADDRA  : in STD_LOGIC_VECTOR (8 downto 0);
	        ADDRB  : in STD_LOGIC_VECTOR (7 downto 0);
	        DOA    : out STD_LOGIC_VECTOR (7 downto 0);
	        DOB    : out STD_LOGIC_VECTOR (15 downto 0)); 
	end component;


begin

   -- RAM INTERFACE -------------------------------------------------
	tempram : RAMB4_S8_S16 generic map (
	       INIT_00 => X"00000000000000000000000000000000000000000000000000fedcba87654321",
	       INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0a => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0b => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0c => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0d => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0e => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0f => X"0000000000000000000000000000000000000000000000000000000000000000")
			port map (
				DIA => rxdll,
				DIB => X"0000", 
				ENA => '1',
				ENB => '1',
				WEA => ramwe,
				WEB => '0',
				RSTA => RESET,
				RSTB => RESET,
				CLKA => RX_CLK,
				CLKB => CLK,
				ADDRA => ramaddrin,
				ADDRB => macaddrl,
				DOA => open,
				DOB => lmacdata); 
	macaddrread : process(CLK, RESET) is
	begin
		if rising_edge(CLK) then
			macaddrl <= MACADDR;
			MACDATA <= lmacdata; 
		end if; 
	end process macaddrread; 

	ramaddrin <= '0' & addr; 
	ramclk: process(RX_CLK, RESET) is
	begin
		--if RESET = '1' then
		--	cs <= none;
		--else
			if rising_edge(RX_CLK) then
				cs <= ns; 

				rx_dvl <= RX_DV;
				rxdl <= RXD;
				rxdll <= rxdl; 

				if cs = writeframe then
					addr <= addr + 1; 
				elsif cs = none then
					addr <= (others => '0');
				end if; 


				nextfl <= NEXTF; 
				TESTOUT <= RX_DV; 
			end if; 
		--end if; 
	end process ramclk; 


	ramfsm : process(cs, addr, rx_dvl, nextfl ) is
	begin 
		case cs is
			when none => 
				ramwe <= '0';
				if rx_dvl = '1' then
					ns <= writeframe; 
				else
					ns <= none; 
				end if; 
			when writeframe =>
				ramwe <= '1';
				if rx_dvl = '0' or addr = X"FF" then
					ns <= doneframe; 
				else
					ns <= writeframe;
				end if;
			when doneframe => 
				ramwe <= '0';
				if nextfl <= '0' then
					ns <= doneframe;
				else
					ns <= none; 
				end if; 
			when others =>
				ramwe <= '0';
				ns <= none;  
		end case; 

	end process; 
end Behavioral;
