library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity network is
    Port ( CLKIN : in std_logic;
           RESET : in std_logic;
           RX_DV : in std_logic;
           RX_ER : in std_logic;
           RXD : in std_logic_vector(7 downto 0);
           RX_CLK : in std_logic;
           TXD : out std_logic_vector(7 downto 0);
           TX_EN : out std_logic;
           GTX_CLK : out std_logic;
           MA : out std_logic_vector(16 downto 0);
           MD : inout std_logic_vector(31 downto 0);
           MCLK : out std_logic;
           MWE : out std_logic;
           CLKIOIN : in std_logic;
           NEXTFRAME : in std_logic;
           DOUT : out std_logic_vector(15 downto 0);
           DOUTEN : out std_logic;
           NEWFRAME : in std_logic;
           DIN : in std_logic_vector(15 downto 0);
			  MDIO : inout std_logic;
			  MDC : out std_logic;
			  LEDACT : out std_logic;
			  LEDTX : out std_logic;
			  LEDRX : out std_logic;
			  LED100 : out std_logic;
			  LED1000 : out std_logic;
			  LEDDPX : out std_logic;
			  LEDPOWER : out std_logic;  
			  PHYRESET : out std_logic;
			  SCLK : in std_logic;
			  SIN : in std_logic;
			  SOUT : out std_logic; 
			  SCS : in std_logic );
end network;

architecture Behavioral of network is


	-- clock and timing signals
	signal clk, clkio, clkrx: std_logic := '0';
	signal clk_to_bufg, clkio_to_bufg, clkrx_to_bufg: std_logic := '0';
	signal clkslen, clkslen_to_bufg : std_logic := '0';
   signal clken1, clken2, clken3, clken4 : std_logic := '0';
	
	-- data
	signal d1, d2, d3, d4, q1, q2, q3, q4 : 
	      std_logic_vector(31 downto 0) :=	(others => '0');

	-- addresses
	signal addr1, addr2, addr3, addr4 : std_logic_vector(15 downto 0) :=
		 (others => '0');
	signal addr1ext, addr2ext, addr3ext, addr4ext : 
	       std_logic_vector(16 downto 0) :=	(others => '0');

	-- error and status signals
	signal rxcrcerr, rxoferr, rxphyerr, rxf, txf, 
	        txi_mwen, txfifowerr, rxfifowerr :
				std_logic := '0';
	signal rxcrcerrsr, rxoferrsr, rxphyerrsr, rxfsr, txfsr, 
	         txfifowerrsr, rxfifowerrsr :
				std_logic := '0';
	-- base pointers 
	signal rxbp, txbp : std_logic_vector(15 downto 0) :=
			(others => '0');
	signal txfbbp, rxfbbp : std_logic_vector(15 downto 0) :=
			(others => '0');

	-- fifo control
	signal txfifofull, rxfifofull : std_logic := '0';

	-- mac address filtering
	signal rxmcast, rxbcast, rxucast, rxallf : std_logic := '0';
	signal macaddr : std_logic_vector(47 downto 0) := (others => '0');

	component memory is
	    Port ( CLK : in std_logic;
			 		RESET : in std_logic;
	           DQEXT : inout std_logic_vector(31 downto 0) ;
	           WEEXT : out std_logic;
	           ADDREXT : out std_logic_vector(16 downto 0);
	           ADDR1 : in std_logic_vector(16 downto 0);
	           ADDR2 : in std_logic_vector(16 downto 0);
	           ADDR3 : in std_logic_vector(16 downto 0);
	           ADDR4 : in std_logic_vector(16 downto 0);
	           D1 : in std_logic_vector(31 downto 0);
	           D2 : in std_logic_vector(31 downto 0);
	           D3 : in std_logic_vector(31 downto 0);
	           D4 : in std_logic_vector(31 downto 0);
	           Q1 : out std_logic_vector(31 downto 0);
	           Q2 : out std_logic_vector(31 downto 0);
	           Q3 : out std_logic_vector(31 downto 0);
	           Q4 : out std_logic_vector(31 downto 0);
	           WE1 : in std_logic;
	           WE2 : in std_logic;
	           WE3 : in std_logic;
	           WE4 : in std_logic;
	           CLKEN1 : out std_logic;
	           CLKEN2 : out std_logic;
	           CLKEN3 : out std_logic;
	           CLKEN4 : out std_logic);
	end component;

	component RXinput is
	    Port ( 	RX_CLK : in std_logic;
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
	end component;

	component RXoutput is
	    Port ( CLK : in std_logic;
	    		 CLKEN : in std_logic; 
	    		 RESET : in std_logic;
	           BPIN : in std_logic_vector(15 downto 0);
		      FBBP : out std_logic_vector(15 downto 0);
	           MA : out std_logic_vector(15 downto 0);
	           MQ : in std_logic_vector(31 downto 0);
	           CLKIO : in std_logic;
			 NEXTFRAME : in std_logic; 
	           DOUT : out std_logic_vector(15 downto 0);
	           DOUTEN : out std_logic);
	end component;

	component TXoutput is
	    Port ( CLK : in std_logic;
	           RESET : in std_logic;
	           MQ : in std_logic_vector(31 downto 0);
	           MA : out std_logic_vector(15 downto 0);
	           BPIN : in std_logic_vector(15 downto 0);
	           TXD : out std_logic_vector(7 downto 0);
	           TXEN : out std_logic;
			 TXF: out std_logic;
		      FBBP: out std_logic_vector(15 downto 0); 
	           CLKEN : in std_logic;
			 GTX_CLK : out std_logic);
	end component;

	component TXinput is
	    Port ( CLK : in std_logic;
	    		 CLKIO : in std_logic; 
	    		 RESET : in std_logic; 
	           DIN : in std_logic_vector(15 downto 0);
	           NEWFRAME : in std_logic;
	           MD : out std_logic_vector(31 downto 0);
	           MWEN : out std_logic;
	           MA : out std_logic_vector(15 downto 0);
	           BPOUT : out std_logic_vector(15 downto 0);
			 FIFOFULL : in std_logic;
			 TXFIFOWERR : out std_logic;
	           DONE : out std_logic);
	end component;

	component FIFOcheck is
	    Port ( CLK : in std_logic;
	           BP : in std_logic_vector(15 downto 0);
	           FBBP : in std_logic_vector(15 downto 0);
	           FIFOFULL : out std_logic);
	end component;

	component control is
	    Port (	CLK : in std_logic;
		 			CLKSLEN : in std_logic;
		 			RESET : in std_logic;
					SCLK : in std_logic;
					SCS : in std_logic;
					SIN : in std_logic;
					SOUT : out std_logic;
					LEDACT : out std_logic;
					LEDTX : out std_logic;
					LEDRX : out std_logic;
					LED100 : out std_logic;
					LED1000 : out std_logic;
					LEDDPX : out std_logic;
					PHYRESET: out std_logic; 
					TXF : in std_logic;
					RXF : in std_logic;
					TXFIFOWERR : in std_logic;
					RXFIFOWERR : in std_logic;
					RXPHYERR : in std_logic;
					RXOFERR : in std_logic;
					RXCRCERR : in std_logic;
					RXBCAST : out std_logic;
					RXMCAST : out std_logic;
					RXUCAST : out std_logic;
					RXALLF : out std_logic; 
					MACADDR : out std_logic_vector(47 downto 0);
					MDIO : inout std_logic;
					MDC : out std_logic);
	end component;

	component clockenable is
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
	end component;


	component CLKDLL
	      port (CLKIN, CLKFB, RST : in STD_LOGIC;
	      CLK0, CLK90, CLK180, CLK270, CLK2X, CLKDV, LOCKED : out std_logic);
	end component;
 
	component BUFG
	      port (I : in STD_LOGIC; O : out std_logic);
	end component;



begin
	 LEDPOWER <= '1';

    addr1ext <= ('1' & addr1);
    addr2ext <= ('0' & addr2);
    addr3ext <= ('1' & addr3);
    addr4ext <= ('0' & addr4);

    clkio_dll : CLKDLL port map (
    		CLKIN => CLKIOIN,
			CLKFB => clkio,
			RST => RESET,
			CLKDV => open,
			CLK0 => clkio_to_bufg);

    clkio_bufg : BUFG port map (
    		I => clkio_to_bufg,
			O => clkio); 
																									

    clk_dll : CLKDLL port map (
    		CLKIN => CLKIN,
			CLKFB => clk,
			RST => RESET,
			CLK0 => clk_to_bufg, 
			CLKDV => open, 
			CLK90 => MCLK);
	 --MCLK <= clk; 	-- should be clk90
    clk_bufg : BUFG port map (
    		I => clk_to_bufg,
			O => clk); 

    -- receive in clock
    clkrx_dll : CLKDLL port map (
    		CLKIN => RX_CLK,
			CLKFB => clkrx,
			RST => RESET,
			CLKDV => open,
			CLK0 => clkrx_to_bufg);

    clkrx_bufg : BUFG port map (
    		I => clkrx_to_bufg,
			O => clkrx); 


	 
	 slowclock: clockenable port map (
	 			CLK => clk,
				RESET => RESET,
				CLKSLEN => clkslen,
				TXF => txf,
				TXFSR => txfsr,
				RXF => rxf,
				RXFSR => rxfsr,
				TXFIFOWERR => txfifowerr,
				TXFIFOWERRSR => txfifowerrsr,
				RXFIFOWERR => rxfifowerr,
				RXFIFOWERRSR => rxfifowerrsr,
				RXPHYERR => rxphyerr,
				RXPHYERRSR => rxphyerrsr,
				RXOFERR => rxoferr,
				RXOFERRSR => rxoferrsr,
				RXCRCERR => rxcrcerr,
				RXCRCERRSR => rxcrcerrsr); 


    memcontroller: memory port map (
    		  CLK => clk,
			  RESET => RESET,
			  DQEXT => MD,
			  WEEXT => MWE,
			  ADDREXT => MA,
			  ADDR1 => addr1ext,
			  ADDR2 => addr2ext,
			  ADDR3 => addr3ext,
			  ADDR4 => addr4ext,
			  D1 => d1,
			  D2 => d2, 
			  D3 => d3,
			  D4 => d4,
			  Q1 => q1,
			  Q2 => q2,
			  Q3 => q3,
			  Q4 => q4,
			  WE1 => '1', --'1',
			  WE2 => '0',
			  WE3 => '0',
			  WE4 =>  '1',
			  CLKEN1 => clken1,
			  CLKEN2 => clken2,
			  CLKEN3 => clken3,
			  CLKEN4 => clken4);
    rx_input: rxinput port map (
    	 	  RX_CLK => clkrx,
			  CLK => clk,
			  RESET => RESET,
			  RX_DV => RX_DV,
			  RX_ER => RX_ER,
			  RXD => RXD,
			  MD => d1,
			  MA => addr1,
			  BPOUT => rxbp,
			  RXCRCERR => rxcrcerr,
			  RXOFERR => rxoferr,
			  RXPHYERR => rxphyerr,
			  FIFOFULL => rxfifofull,
			  RXFIFOWERR => rxfifowerr,
			  RXF => rxf,
			  MACADDR => macaddr,
			  RXBCAST => rxbcast,
			  RXMCAST => rxmcast,
			  RXUCAST => rxucast,
			  RXALLF => rxallf);
   rx_output : rxoutput port map (
   			  CLK => clk,
			  CLKEN => clken3,
			  RESET => RESET,
			  BPIN => rxbp,
			  FBBP => rxfbbp,
			  MA => addr3,
			  MQ => q3,
			  CLKIO => clkio,
			  NEXTFRAME => NEXTFRAME,
			  DOUT => DOUT,
			  DOUTEN => DOUTEN);

   tx_output: txoutput port map (
   			  CLK => clk,
			  RESET => reset,
			  MQ => q2,
			  MA => addr2,
			  BPIN => txbp,
			  TXD => TXD,
			  TXEN => TX_EN,
			  TXF => txf,
			  FBBP => txfbbp, 
			  CLKEN => clken2, 
			  GTX_CLK => GTX_CLK);
   tx_input: txinput port map (
   			  CLK => clk,
			  CLKIO => clkio,
			  RESET => reset, 
			  DIN => DIN,
			  NEWFRAME => NEWFRAME,
			  MWEN => txi_mwen,
			  MA => addr4,
			  MD => d4,
			  BPOUT => txbp,
			  FIFOFULL => txfifofull,
			  TXFIFOWERR => txfifowerr,
			  DONE => open);

   tx_fifocheck: FIFOcheck port map(
   			  CLK => clk,
			  FIFOFULL => txfifofull,
			  BP => txbp,
			  FBBP => txfbbp);

   rx_fifocheck: FIFOcheck port map(
   			  CLK => clk,
			  FIFOFULL => rxfifofull,
			  BP => rxbp,
			  FBBP => rxfbbp);

	mac_control: control port map (
				CLK => clk,
				CLKSLEN => clkslen, 
				RESET => RESET,
				SCLK => SCLK,
				SCS => SCS, 
				SIN => SIN,
				SOUT => SOUT, 
				LEDACT => LEDACT,
				LEDTX => LEDTX,
				LEDRX => LEDRX,
				LED100 => LED100,
				LED1000 => LED1000,
				LEDDPX => LEDDPX,
				PHYRESET => PHYRESET,
				TXF => txfsr,
				RXF => rxfsr,
				TXFIFOWERR => txfifowerrsr,
				RXFIFOWERR => rxfifowerrsr,
				RXPHYERR => rxphyerrsr,
		 		RXOFERR => rxoferrsr,
				RXCRCERR => rxcrcerrsr,
				RXBCAST => rxbcast,
				RXMCAST => rxmcast,
				RXUCAST => rxucast,
				RXALLF => rxallf, 
				MACADDR => macaddr,
				MDIO => MDIO,
				MDC => MDC); 

-- debugging
	process(clk) is
		variable l, ll :std_logic; 
	
	begin
		if rising_edge(clk) then
			l := rxfsr;
			ll := l;
			--LEDRX <= ll; 
		end if; 
	end process; 
		  	
end Behavioral;
