library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXinput_GMII is
    Port ( RX_CLK : in std_logic;
           RX_DV : in std_logic;
           RX_ER : in std_logic;
           RXD : in std_logic_vector(7 downto 0);
           INCE : out std_logic;
           ENDFIN : out std_logic;
           FIFOIN : out std_logic_vector(7 downto 0);
           RX_NEARF : in std_logic);
end RXinput_GMII;

architecture Behavioral of RXinput_GMII is
-- RXINPUT_GMII.VHD -- the GMII side of the gigabit interface, 
-- all based on the RX_CLK gigabit clock. This should be connected
-- to the async fifo. 

   -- latched signals
   signal rx_dvl, rx_dvll, rx_erl : std_logic := '0';
   signal rxdl, lfifoin : std_logic_vector(7 downto 0) := (others => '0');

   signal lendfin, lince, rx_of : std_logic := '0';

   -- internal signals
   signal dvdelta, endf, ro : std_logic := '0';



begin

   clock: process(RX_CLK) is
   begin
   	if rising_edge(RX_CLK) then
		rx_dvl <= RX_DV;
		rx_erl <= RX_ER;
		rxdl <= RXD; 

		rx_dvll <= rx_dvl;

		-- io registers
		rx_of <= RX_NEARF;
		ENDFIN <= lendfin; 
		INCE <= lince; 
		FIFOIN <= lfifoin; 

		-- the set-reset register
		if endf = '1' then
			ro <= '0';
		else
			if dvdelta = '1' then
				ro <= '1';
			else
				ro <= ro;
			end if;
		end if;
    end if;
   end process clock;


   -- generic combinational signals

   dvdelta <= (not rx_dvll) and rx_dvl;
   lince <= ro or dvdelta; 
   endf <= (not rx_dvl) or rx_erl or RX_OF;
   lendfin <= endf; 

   fifo : process(rx_dvl, rx_erl, rx_of, rxdl) is
   begin
   	  if rx_erl = '1' and rx_of = '1' then
	  	lfifoin <= X"07";
       elsif rx_erl = '0' and rx_of = '1' then
	  	lfifoin <= X"06";
       elsif rx_erl = '1' and rx_of = '0' then
	  	lfifoin <= X"05";
	  else
	  	if rx_dvl = '1' then
			lfifoin <= rxdl;
		else
			lfifoin <= X"00";
		end if;
	  end if;
   end process fifo;  


end Behavioral;
