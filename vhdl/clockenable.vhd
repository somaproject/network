library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clockenable is
    Port ( CLK : in std_logic;
           RESET : in std_logic;
           CLKSLEN : out std_logic;
           TXF : in std_logic;
           TXFSR : out std_logic;
           RXF : in std_logic;
           RXFSR : out std_logic;
           TXFIFOWERR : in std_logic;
           TXFIFOWERRSR : out std_logic;
			  RXFIFOWERR : in std_logic;
			  RXFIFOWERRSR : out std_logic; 
           RXPHYERR : in std_logic;
           RXPHYERRSR : out std_logic;
           RXOFERR : in std_logic;
           RXOFERRSR : out std_logic;
           RXCRCERR : in std_logic;
           RXCRCERRSR : out std_logic);
end clockenable;

architecture Behavioral of clockenable is
-- CLOCKENABLE.VHD -- generates the slower clock-enable and registers
-- the various counter signals

	signal clkcnt : integer range 0 to 7 := 0; 
	signal clken, lclken : std_logic := '0';

	signal txfl, rxfl, txfifowerrl, rxfifowerrl, rxphyerrl,
			 rxoferrl, rxcrcerrl : std_logic := '0';

begin
	clock: process(CLK) is
	begin
		if rising_edge(CLK) then
			if clkcnt = 7 then
				clkcnt <= 0;
			else
				clkcnt <= clkcnt + 1; 
			end if; 

			if clkcnt = 0 then
				lclken <= '1';
			else
				lclken <= '0';
			end if; 
			clken <= lclken; 
		end if; 
	end process clock; 
		
	CLKSLEN <= clken; 


	setreset: process(CLK) is
	begin
		if rising_edge(CLK) then
			if TXF = '1' then
				txfl <= '1';
			else
				if clken = '1' then
					txfl <= '0';
				end if; 
			end if; 

			if RXF = '1' then
				rxfl <= '1';
			else
				if clken = '1' then
					rxfl <= '0';
				end if; 
			end if; 

			if TXFIFOWERR = '1' then
				txfifowerrl <= '1';
			else
				if clken = '1' then
					txfifowerrl <= '0';
				end if; 
			end if; 

			if RXFIFOWERR = '1' then
				rxfifowerrl <= '1';
			else
				if clken = '1' then
					rxfifowerrl <= '0';
				end if; 
			end if; 	

			if RXPHYERR = '1' then
				rxphyerrl  <= '1';
			else
				if clken = '1' then
					rxphyerrl <= '0';
				end if; 
			end if; 


			if RXCRCERR = '1' then
				rxcrcerrl  <= '1';
			else
				if clken = '1' then
					rxcrcerrl <= '0';
				end if; 
			end if; 

			if RXOFERR = '1' then
				rxoferrl   <= '1';
			else
				if clken = '1' then
					rxoferrl  <= '0';
				end if; 
			end if; 

			if clken = '1' then
				TXFSR <= txfl;
				RXFSR <= rxfl;
				TXFIFOWERRSR <= txfifowerrl;
				RXFIFOWERRSR <= rxfifowerrl;
				RXPHYERRSR <= rxphyerrl;
				RXOFERRSR <= rxoferrl;
				RXCRCERRSR <= rxcrcerrl; 
			end if; 

		end if; 
	end process setreset; 

end Behavioral;
