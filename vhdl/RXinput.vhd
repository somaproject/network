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
           RXCRCERR : out std_logic;
           RXOFERR : out std_logic;
           RXPHYERR : out std_logic;
		 	  RXFIFOWERR : out std_logic;
		     FIFOFULL : in std_logic; 
           RXF : out std_logic;
			  MACADDR : in std_logic_vector(47 downto 0);
			  RXBCAST : in std_logic;
			  RXMCAST : in std_logic;
			  RXUCAST : in std_logic;
			  RXALLF : in std_logic);
end  RXinput;

architecture Behavioral of RXinput is
-- RXINPUT.VHD -- the pre-memory input side of the receive section,
-- with its own 256x16 fifo to handle the two different clock
-- domains. Should require extensive testing. Since Xilinx apparently
-- has a patent on the gray-code FIFO implementation, we're 
-- using a FIFO from their CoreGen IP, such that only someone
-- with the ISE tools will be able to compile the project. 

   -- rx_clock signals
   signal ince, endfin, rx_nearf : std_logic := '0';
   signal fifoin: std_logic_vector(7 downto 0) := (others => '0');

   -- mmio signals
   signal ce, endf, invalid : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');

	component RXinput_GMII is
	    Port ( RX_CLK : in std_logic;
	           RX_DV : in std_logic;
	           RX_ER : in std_logic;
	           RXD : in std_logic_vector(7 downto 0);
	           INCE : out std_logic;
	           ENDFIN : out std_logic;
	           FIFOIN : out std_logic_vector(7 downto 0);
	           RX_NEARF : in std_logic);
	end component;

	component RXinput_memio is
	    Port ( CLK : in std_logic;
	    		 RESET : in std_logic;
	           CEOUT : out std_logic;
	           ENDF : in std_logic;
	           INVALID : in std_logic;
	           DATA : in std_logic_vector(7 downto 0);
	           MA : out std_logic_vector(15 downto 0);
			     MD : out std_logic_vector(31 downto 0); 
	           BPOUT : out std_logic_vector(15 downto 0);
	           RXCRCERR : out std_logic;
	           RXOFERR : out std_logic;
	           RXPHYERR : out std_logic;
		 	 RXFIFOWERR : out std_logic;
		 	 FIFOFULL : in std_logic; 
	           RXF : out std_logic;
			  MACADDR : in std_logic_vector(47 downto 0);
			  RXBCAST : in std_logic;
			  RXMCAST : in std_logic;
			  RXUCAST : in std_logic;
			  RXALLF : in std_logic);
	end component;

	component RXinput_fifo is
	    Port ( RX_CLK : in std_logic;
	    		 RESET : in std_logic; 
	           ENDFIN : in std_logic;
	           DIN : in std_logic_vector(7 downto 0);
	           NEARF : out std_logic;
	           CEIN : in std_logic;
	           CLK : in std_logic;
	           CE : in std_logic;
	           DATA : out std_logic_vector(7 downto 0);
	           ENDF : out std_logic;
	           INVALID : out std_logic);
	end component;

begin

     GMII: RXinput_GMII port map (
		 RX_CLK => RX_CLK,
		 RX_DV => RX_DV,
		 RX_ER => RX_ER,
		 RXD => RXD,
		 INCE => ince, 
		 ENDFIN => endfin,
		 FIFOIN => fifoin,
		 RX_NEARF => rx_nearf);
     
    memio: RXinput_memio port map (
    		 CLK => CLK,
		 RESET => RESET,
		 CEOUT => ce,
		 ENDF => endf, 
		 INVALID => invalid,
		 DATA => data, 
		 MA => MA,
		 MD => MD,
		 BPOUT => BPOUT,
		 RXCRCERR => RXCRCERR,
		 RXOFERR => RXOFERR,
		 RXPHYERR => RXPHYERR,
		 FIFOFULL => FIFOFULL,
		 RXFIFOWERR => RXFIFOWERR,
		 RXF => RXF,
		 MACADDR => MACADDR,
		 RXBCAST => RXBCAST,
		 RXMCAST => RXMCAST,
		 RXUCAST => RXUCAST,
		 RXALLF => RXALLF); 

    fifo: RXinput_fifo port map (
    		 RX_CLK => RX_CLK,
		 RESET => RESET, 
		 ENDFIN => endfin,
		 DIN => fifoin,
		 NEARF => rx_nearf,
		 CEIN => ince, 
		 CLK => CLK,
		 CE => ce,
		 DATA => data,
		 ENDF => endf, 
		 INVALID => invalid);




end Behavioral;
