library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXinput is
    Port ( RX_CLK : in std_logic;
           CLK : in std_logic;
           RESET : in std_logic;
           RX_DV : in std_logic;
           RX_ER : in std_logic;
           RXD : in std_logic_vector(7 downto 0);
           MD : out std_logic_vector(31 downto 0);
           MA : out std_logic_vector(15 downto 0);
           BPOUT : out std_logic_vector(15 downto 0);
           CRCERR : out std_logic;
           OFERR : out std_logic;
           PHYERR : out std_logic;
           RXF : out std_logic);
end RXinput;

architecture Behavioral of RXinput is
-- RXINPUT.VHD -- the pre-memory input side of the receive section,
-- with its own 256x16 fifo to handle the two different clock
-- domains. Should require extensive testing. Since Xilinx apparently
-- has a patent on the gray-code FIFO implementation, we're 
-- using a FIFO from their CoreGen IP, such that only someone
-- with the ISE tools will be able to compile the project. 

   -- rc_clock signals
   signal ince, endfin, rx_of : std_logic := '0';
   signal fifoin: std_logic_vector(7 downto 0) := (others => '0');

   -- mmio signals
   signal ceout, endf, empty : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');

   -- data signals
   signal fifodin, fifodout : std_logic_vector(15 downto 0) :=
   			(others => '0');

	component RXinput_GMII is
	    Port ( RX_CLK : in std_logic;
	           RX_DV : in std_logic;
	           RX_ER : in std_logic;
	           RXD : in std_logic_vector(7 downto 0);
	           INCE : out std_logic;
	           ENDFIN : out std_logic;
	           FIFOIN : out std_logic_vector(7 downto 0);
	           RX_OF : in std_logic);
	end component;

	component RXinput_memio is
	    Port ( CLK : in std_logic;
	    		 RESET : in std_logic;
	           CEOUT : out std_logic;
	           ENDF : in std_logic;
	           EMPTY : in std_logic;
	           DATA : in std_logic_vector(7 downto 0);
	           MA : out std_logic_vector(15 downto 0);
			 MD : out std_logic_vector(31 downto 0); 
	           BPOUT : out std_logic_vector(15 downto 0);
	           CRCERR : out std_logic;
	           OFERR : out std_logic;
	           PHYERR : out std_logic;
	           RXF : out std_logic);
	end component;
	component async_fifo IS
		port (
		din: IN std_logic_VECTOR(15 downto 0);
		wr_en: IN std_logic;
		wr_clk: IN std_logic;
		rd_en: IN std_logic;
		rd_clk: IN std_logic;
		ainit: IN std_logic;
		dout: OUT std_logic_VECTOR(15 downto 0);
		full: OUT std_logic;
		empty: OUT std_logic;
		almost_full: OUT std_logic);
	END component;

begin
   GMII : RXinput_GMII port map (
   		RX_CLK => RX_CLK,
		RX_DV => RX_DV,
		RX_ER => RX_ER,
		RXD => RXD,
		INCE => ince,
		ENDFIN => endfin,
		FIFOIN => fifoin,
		RX_OF => rx_of);

   memio : RXinput_memio port map (
   		CLK => CLK,
		RESET => RESET,
		CEOUT => ceout,
		ENDF => endf,
		EMPTY => empty,
		DATA => data,
		MA => MA,
		MD => MD,
		BPOUT => BPOUT,
		CRCERR => CRCERR,
		OFERR => OFERR,
		PHYERR => PHYERR,
		RXF => RXF); 
   fifo : async_fifo port map (
   		din => fifodin,
		wr_en => ince,
		wr_clk => RX_CLK,
		rd_en => ceout,
		rd_clk => CLK,
		ainit => RESET, 
		dout => fifodout,
		full => open,
		empty => empty, 
		almost_full => rx_of);
    fifodin <= "0000000" & endfin & fifoin;
    endf <= fifodout(8);
    data <= fifodout(7 downto 0);


end Behavioral;
