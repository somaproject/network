library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;
														  
entity testsuite is
    Port ( CLKIN : in std_logic;
	 		  CLKFB : in std_logic; 
           RESET : in std_logic;
           RX_DV : in std_logic;
           RX_ER : in std_logic;
           RXD : in std_logic_vector(7 downto 0);
           RX_CLK : in std_logic;
           TXD : out std_logic_vector(7 downto 0);
           TX_EN : out std_logic;
			  TX_ER : out std_logic; 
           GTX_CLK : out std_logic;
           MA : out std_logic_vector(16 downto 0);
           MD : inout std_logic_vector(31 downto 0);
           MCLK : out std_logic;
           MWE : out std_logic;
			  MOE : out std_logic; 
           CLKIOIN : in std_logic;
           NEXTFRAME : in std_logic;
           DOUT : out std_logic_vector(15 downto 0);
           DOUTEN : out std_logic;
           NEWFRAME : in std_logic;
           DIN : in std_logic_vector(15 downto 0);
           DINEN : in std_logic;
			  MDIO : inout std_logic;
			  MDC : out std_logic;
			  LEDPOWER : out std_logic; 
			  LEDACT : out std_logic;
			  LEDTX : out std_logic;
			  LEDRX : out std_logic;
			  LED100 : out std_logic;
			  LED1000 : out std_logic;
			  LEDDPX : out std_logic; 
			  PHYRESET : out std_logic;
			  SCLK : in std_logic;
			  SIN : in std_logic;
			  SOUT : out std_logic; 
			  SCS : in std_logic;
			  MACADDR : in std_logic_vector(7 downto 0);
			  MACDATA : out std_logic_vector(15 downto 0);
			  IFCLK : in std_logic;
			  NEXTF : in std_logic;
			  TESTOUT : out std_logic  		  
			   );
end testsuite;


architecture Behavioral of testsuite is

	-- clock and timing signals
	signal clk, clkio, clksl, clkrx: std_logic := '0';
	signal clk_to_bufg, clkio_to_bufg, clksl_to_bufg, clksl_in,
			clksl_fb, clkrx_to_bufg, rx_clk_int, ifclk_int, ifclk_to_bufg,
			clkslen, rx_clk_to_bufg, clk180, clk90: std_logic := '0';

     signal clken1, clken2, clken3, clken4 : std_logic := '0';
	
	-- data
	signal d1, d2, d3, d4, q1, q2, q3, q4 : 
	      std_logic_vector(31 downto 0) :=	(others => '0');

	-- addresses
	signal addr1, addr2, addr3, addr4 : std_logic_vector(16 downto 0) :=
		 (others => '0');

	-- error and status signals
	signal rxcrcerr, rxoferr, rxphyerr, rxf, txf, 
	        txi_mwen, txfifowerr, rxfifowerr :
				std_logic := '0';
	signal txfsr, rxfsr : std_logic := '0'; 
	signal tx_en_out : std_logic;
	signal err, err2 : std_logic; 
	signal mwe2 : std_logic; 
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


	component control is
	    Port (	CLK : in std_logic;
		 			RESET : in std_logic;
					CLKSLEN : in std_logic; 
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
			generic (CLKDV_DIVIDE : in real := 4.0); 
	      port (CLKIN, CLKFB, RST : in STD_LOGIC;
	      CLK0, CLK90, CLK180, CLK270, CLK2X, CLKDV, LOCKED : out std_logic);
	end component;
 
	component BUFG
	      port (I : in STD_LOGIC; O : out std_logic);
	end component;


	component testsuite_rx is
	    Port ( CLK : in std_logic;
		 		  RX_CLK : in std_logic;
				  RX_DV : in std_logic;
				  RXD : in std_logic_vector(7 downto 0) ;  
				  RESET : in std_logic;  
	           MACADDR : in std_logic_vector(7 downto 0);
	           MACDATA : out std_logic_vector(15 downto 0);
				  NEXTF : in std_logic;
				  TESTOUT : out std_logic);
	end component;


	component testsuite_memory is
    Port ( CLK : in std_logic;
           MD : out std_logic_vector(31 downto 0);
           MQ : in std_logic_vector(31 downto 0);
           MAQ : out std_logic_vector(15 downto 0);
           MAD : out std_logic_vector(15 downto 0);
			  ERR : out std_logic; 
           CLKEN1 : in std_logic;
			  CLKEN2 : in std_logic);
     end component;

	component testsuite_memory2 is
	    Port ( CLK : in std_logic;
	           MD : out std_logic_vector(31 downto 0);
	           MQ : in std_logic_vector(31 downto 0);
	           MA : out std_logic_vector(15 downto 0);
				  MWE : out std_logic; 
				  ERR : out std_logic; 
	           CLKEN : in std_logic);
	end component;

	component testsuite_tx is
	    Port ( CLK : in std_logic;
		 		  RESET : in std_logic; 
	           TX_EN : out std_logic;
	           TXD : out std_logic_vector(7 downto 0));
	end component;
begin
	 MOE <= '0'; 

	 -- random LED flashing:
	 flash: process(clk) is
	 	variable cnt : std_logic_vector(23 downto 0) := (others => '0'); 
		variable toggle, t1, t2, t3 : std_logic := '0';  
		
	 begin
	 	if rising_edge(clk) then
			cnt := cnt + 1;
			t1 := cnt(23); 
			t2 := t1;
			t3 := t2; 	 		

			LEDPOWER <= t3;
			 
		end if;
	 end process flash; 

	 clken : clockenable port map (
	 		CLK => CLK,
			RESET => RESET,
			CLKSLEN => clkslen,
			TXF => txf,
			TXFSR => txfsr,
			RXF => rxf,
			RXFSR => rxfsr,
			TXFIFOWERR => '0',
			TXFIFOWERRSR => open,
			RXFIFOWERR => '0',
			RXFIFOWERRSR => open,
			RXPHYERR => '0',
			RXPHYERRSR => open,
			RXOFERR => '0',
			RXOFERRSR => open, 
			RXCRCERR => '0',
			RXCRCERRSR => open); 

	testrx : testsuite_rx port map (
		CLK => ifclk_int,
		RESET => RESET,
		MACDATA => MACDATA,
		MACADDR => MACADDR,
		RX_CLK => rx_clk_int,
		RX_DV => RX_DV,
		RXD => RXD,
		NEXTF => NEXTF,
	 	TESTOUT => open); 


    memcontroller: memory port map (
    		  CLK => clk,
			  RESET => RESET,
			  DQEXT => MD,
			  WEEXT => MWE,
			  ADDREXT => MA,
			  ADDR1 => addr1,
			  ADDR2 => addr2,
			  ADDR3 => addr3,
			  ADDR4 => addr4,
			  D1 => d1,
			  D2 => d2, 
			  D3 => d3,
			  D4 => d4,
			  Q1 => q1,
			  Q2 => q2,
			  Q3 => q3,
			  Q4 => q4,
			  WE1 => '1',
			  WE2 => mwe2,
			  WE3 => '0',
			  WE4 =>  '0',
			  CLKEN1 => clken1,
			  CLKEN2 => clken2,
			  CLKEN3 => clken3,
			  CLKEN4 => clken4);

	 -- ledrx

    
	 clk_DLL : CLKDLL
			port map (
			CLKIN => CLKIN,
			RST => RESET,
			CLKFB => CLKFB,
			CLK0 => clk_to_bufg,
			CLK180 => clk180,
			CLK90 => clk90); 
	clk_bufg : BUFG port map (
			I => clk_to_bufg,
			O => clk); 
	 ifclk_DLL : CLKDLL
			port map (
			CLKIN => ifclk,
			RST => RESET,
			CLKFB => IFclk_int,
			CLK0 => ifclk_to_bufg); 
	ifclk_bufg : BUFG port map (
			I => ifclk_to_bufg,
			O => ifclk_int); 

	 rxclk_DLL : CLKDLL
			port map (
			CLKIN => RX_CLK,
			RST => NEXTF,
			CLKFB => rx_clk_int,
			CLK0 => rx_clk_to_bufg); 
	rx_clk_bufg : BUFG port map (
			I => rx_clk_to_bufg,
			O => rx_clk_int);
	GTX_CLK <= clk180; 		 
	MCLK <= clk; 


	maccontrol: control port map (
				CLK => clk,
				RESET => RESET,
				CLKSLEN => clkslen,
				SCLK => SCLK,
				SCS => SCS, 
				SIN => SIN,
				SOUT => SOUT, 
				LEDACT => open,
				LEDTX => LEDTX,
				LEDRX => open,
				LED100 => LED100,
				LED1000 => LED1000,
				LEDDPX => LEDDPX,
				PHYRESET => PHYRESET,
				TXF => tx_en_out,
				RXF => '0',
				TXFIFOWERR => '0',
				RXFIFOWERR => '0',
				RXPHYERR => '0',
		 		RXOFERR => '0',
				RXCRCERR => '0',
				RXBCAST => open,
				RXMCAST => open,
				RXUCAST => open,
				RXALLF => open, 
				MACADDR => open,
				MDIO => MDIO,
				MDC => MDC); 

	 memtest: testsuite_memory port map (
	 			CLK => clk,
				MD => d1,
				MQ => q4,
				MAD => addr1(15 downto 0),
				MAQ => addr4(15 downto 0),
				ERR => err,
				CLKEN1 => clken1,
				CLKEN2 => clken4);
	 memtest2 : testsuite_memory2  port map(
				CLK => clk,
				MD => d2,
				MQ => q2,
				MA => addr2(15 downto 0),
				MWE => mwe2,
				ERR => err2,
				CLKEN => clken2);
				 
	addr1(16) <= '1';
	addr2(16) <= '0';
	addr3(16) <= '0';
	addr4(16) <= '1'; 
	

	 flasherror: process(CLK) is
	 	variable cnt: std_logic_vector(5 downto 0) := (others => '0'); 
		variable toggle, t1, t2, t3 : std_logic := '0';  
		variable err2, err3, cntr2, cntr3 : std_logic := '0'; 
	 begin
	 	if rising_edge(CLK) then
			if err = '1' or err2 = '1'  then 
				cnt := (others => '0');
				LEDACT <= '1'; 
			else
				if not (cnt = "111111") then
					cnt := cnt + 1; 
					LEDACT <= '1';
				else
					LEDACT <= '0';
				end if;
			end if; 
			if err = '1' then
				TESTOUT <= '1';
			else
				TESTOUT <= '0';
			end if; 
		end if;
	 end process flasherror; 

	 txsim : testsuite_tx port map (
	 			CLK => clk, 
	 			RESET => RESET,
	 			TX_EN => TX_EN,
	 			TXD => TXD);
	
   TX_ER <= '0'; 

	-- mirroring coce
	process(rx_clk_int) is
		variable rx_dvl, rx_dvll : std_logic := '0';
		variable rxdl, rxdll : std_logic_vector(7 downto 0) := (others => '0'); 

	begin
		
		if rising_edge(rx_clk_int)	 then
			--rx_dvl := RX_DV;
			--rx_dvll := rx_dvl;
			--TX_EN <= rx_dvll;

			--rxdl := RXD;
			--rxdll := rxdl;
			--TXD <= rxdll;
		end if;
	end process; 

 	
	process(rx_clk_int) is
	begin 
	   if rising_edge(rx_clk_int) then
			if RX_DV = '1' or RX_ER = '1' then
				LEDRX <= '1';
			else
				LEDRX <= '0';
			end if;
			
		end if;
	end process; 			 


end Behavioral;
