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
			clksl_fb, clkrx_to_bufg, rx_clk_int, ifclk_int,
			clksl_to_dll: std_logic := '0';

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

	signal tx_en_out : std_logic;
	signal err : std_logic; 

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
					CLKSL : in std_logic; 
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
           MAQ : out std_logic_vector(16 downto 0);
           MAD : out std_logic_vector(16 downto 0);
			  ERR : out std_logic; 
           CLKEN1 : in std_logic;
			  CLKEN2 : in std_logic);
     end component;
	component testsuite_tx is
	    Port ( CLK : in std_logic;
		 		  RESET : in std_logic; 
	           TX_EN : out std_logic;
	           TXD : out std_logic_vector(7 downto 0));
	end component;
begin
	 TX_ER <= '0'; 
	 MOE <= '1'; 

	 -- random LED flashing:
	 flash: process(CLK) is
	 	variable cnt : std_logic_vector(23 downto 0) := (others => '0'); 
		variable toggle, t1, t2, t3 : std_logic := '0';  
		
	 begin
	 	if rising_edge(CLK) then
			cnt := cnt + 1;
			t1 := cnt(23); 
			t2 := t1;
			t3 := t2; 	 		

			LEDPOWER <= t3;
		end if;
	 end process flash; 


	--testrx : testsuite_rx port map (
	--	CLK => ifclk_int,
	--	RESET => RESET,
	--	MACDATA => MACDATA,
	--	MACADDR => MACADDR,
	--	RX_CLK => rx_clk_int,
	--	RX_DV => RX_DV,
	--	RXD => RXD,
	--	NEXTF => NEXTF,
	--	TESTOUT => open); 


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
			  WE2 => '0',
			  WE3 => '0',
			  WE4 =>  '0',
			  CLKEN1 => clken1,
			  CLKEN2 => clken2,
			  CLKEN3 => clken3,
			  CLKEN4 => clken4);

	 -- ledrx

    
	 clk_DLL : CLKDLL generic map (
	 		CLKDV_DIVIDE => 8.0) 
			port map (
			CLKIN => CLKIN,
			RST => RESET,
			CLKFB => clk, 
			CLKDV => clksl_to_bufg,
			CLK0 => clk_to_bufg); 
	clk_bufg : BUFG port map (
			I => clk_to_bufg,
			O => clk) ; 

	clksl_bufg : BUFG port map (
		I => clksl_to_bufg,
		O => clksl); 

	rx_clk_dll : BUFGDLL  port map (
			I => RX_CLK,
			O => rx_clk_int); 
	--rx_clk_int <= RX_CLK; 
	--if_clk_dll : BUFGDLL port map (
	--		I => IFCLK,
	--		O => ifclk_int); 
	--ifclk_int <= IFCLK; 
	MCLK <= clk; 

	mac_control: control port map (
				CLK => clksl,
				RESET => RESET,
				CLKSL => clksl,
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
				MQ => q2,
				MAD => addr1,
				MAQ => addr2,
				ERR => err,
				CLKEN1 => clken1,
				CLKEN2 => clken2);


	 flasherror: process(CLK) is
	 	variable cnt: std_logic_vector(3 downto 0) := (others => '0'); 
		variable toggle, t1, t2, t3 : std_logic := '0';  
		variable err2, err3, cntr2, cntr3 : std_logic := '0'; 
	 begin
	 	if rising_edge(CLK) then
			if err = '1' then 
				cnt := (others => '0');
			else
				if not (cnt = "1111") then
					cnt := cnt + 1; 
					LEDACT <= '1';
				else
					LEDACT <= '0';
				end if;
			end if; 
		end if;
	 end process flasherror; 

	 txsim : testsuite_tx port map (
	 			CLK => clk, 
	 			RESET => RESET,
	 			TX_EN => tx_en_out,
	 			TXD => TXD);
	testout <= '0'; 
 	TX_EN <= tx_en_out; 
		GTX_CLK <= clk; 
	process(rx_clk_int) is
	begin 
	   if rising_edge(rx_clk_int) then
			if RX_DV = '1' or RXD = "00000000" or MACADDR = "0000000" or
				NEXTF = '1' or  RX_ER = '1' or IFCLK = '0'  then
				LEDRX <= '1';
			else
				LEDRX <= '0';
			end if;
			
		end if;
	end process; 			 
	MACDATA <= (others => '0'); 





end Behavioral;
