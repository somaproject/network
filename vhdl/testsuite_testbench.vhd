
-- VHDL Test Bench Created from source file testsuite.vhd -- 16:03:15 10/25/2003
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testsuite_testbench IS
END testsuite_testbench;

ARCHITECTURE behavior OF testsuite_testbench IS 

	COMPONENT testsuite
	PORT(
		CLKIN : IN std_logic;
		RESET : IN std_logic;
		RX_DV : IN std_logic;
		RX_ER : IN std_logic;
		RXD : IN std_logic_vector(7 downto 0);
		RX_CLK : IN std_logic;
		CLKIOIN : IN std_logic;
		NEXTFRAME : IN std_logic;
		NEWFRAME : IN std_logic;
		DIN : IN std_logic_vector(15 downto 0);
		DINEN : IN std_logic;
		SCLK : IN std_logic;
		SIN : IN std_logic;
		SCS : IN std_logic;    
		MD : INOUT std_logic_vector(31 downto 0);
		MDIO : INOUT std_logic;      
		TXD : OUT std_logic_vector(7 downto 0);
		TX_EN : OUT std_logic;
		GTX_CLK : OUT std_logic;
		MA : OUT std_logic_vector(16 downto 0);
		MCLK : OUT std_logic;
		MWE : OUT std_logic;
		DOUT : OUT std_logic_vector(15 downto 0);
		DOUTEN : OUT std_logic;
		MDC : OUT std_logic;
		LEDACT : OUT std_logic;
		LEDTX : OUT std_logic;
		LEDRX : OUT std_logic;
		LED100 : OUT std_logic;
		LED1000 : OUT std_logic;
		LEDDPX : OUT std_logic;
		PHYRESET : OUT std_logic;
		SOUT : OUT std_logic;
		CLKFB : in std_logic;			
	   MACADDR : in std_logic_vector(7 downto 0);
	   MACDATA : out std_logic_vector(15 downto 0);
	   IFCLK : in std_logic;
	   NEXTF : in std_logic;
	   TESTOUT : out std_logic 
		);
	END COMPONENT;

	SIGNAL CLKIN :  std_logic := '0';
	SIGNAL RESET :  std_logic := '1';
	SIGNAL RX_DV :  std_logic := '0';
	SIGNAL RX_ER :  std_logic := '0';
	SIGNAL RXD :  std_logic_vector(7 downto 0) := (others => '0');
	SIGNAL RX_CLK :  std_logic := '0';
	SIGNAL TXD :  std_logic_vector(7 downto 0);
	SIGNAL TX_EN :  std_logic;
	SIGNAL GTX_CLK :  std_logic;
	SIGNAL MA :  std_logic_vector(16 downto 0);
	SIGNAL MD :  std_logic_vector(31 downto 0);
	SIGNAL MCLK :  std_logic;
	SIGNAL MWE :  std_logic;
	SIGNAL CLKIOIN :  std_logic;
	SIGNAL NEXTFRAME :  std_logic;
	SIGNAL DOUT :  std_logic_vector(15 downto 0);
	SIGNAL DOUTEN :  std_logic;
	SIGNAL NEWFRAME :  std_logic;
	SIGNAL DIN :  std_logic_vector(15 downto 0);
	SIGNAL DINEN :  std_logic;
	SIGNAL MDIO :  std_logic;
	SIGNAL MDC :  std_logic;
	SIGNAL LEDACT :  std_logic;
	SIGNAL LEDTX :  std_logic;
	SIGNAL LEDRX :  std_logic;
	SIGNAL LED100 :  std_logic;
	SIGNAL LED1000 :  std_logic;
	SIGNAL LEDDPX :  std_logic;
	SIGNAL PHYRESET :  std_logic;
	SIGNAL SCLK :  std_logic;
	SIGNAL SIN :  std_logic;
	SIGNAL SOUT :  std_logic;
	SIGNAL SCS :  std_logic;
	signal clkfb : std_logic; 
	SIGNAL MACADDR : std_logic_vector(7 downto 0) := (others => '0');
	SIGNAL MACDATA : std_logic_vector(15 downto 0);
	SIGNAL IFCLK : std_logic := '0';
	SIGNAL NEXTF : std_logic := '0';
	SIGNAL TESTOUT : std_logic; 

	signal sram_save : std_logic := '0'; 

	signal counter : integer := 0; 
	component test_NoBLSRAM is
	    Generic (  FILEIN : string := "SRAM_in.dat"; 
	    				FILEOUT : string := "SRAM_out.dat";
						physical_sim : integer := 0;
						TSU, THD, TKQ, TKQX : time); 
	    Port ( CLK : in std_logic;
	           DQ : inout std_logic_vector(31 downto 0);
	           ADDR : in std_logic_vector(16 downto 0);
	           WE : in std_logic;
	           RESET : in std_logic;
			 	  SAVE : in std_logic);
	end component;
BEGIN
   sram: test_NoBLSRAM generic map (
   	FILEIN => "testvectors/sram.in.0.dat",
		FILEOUT => "testvectors/sram.out.0.dat",
		physical_sim => 0,
		TSU => 2 ns,
		THD => 1 ns,
		TKQ => 2 ns,
		TKQX => 1 ns
		)
		port map (
		CLK => clkin,
		DQ => MD,
		ADDR => ma,
		WE => mwe,
		reset => RESET,
		SAVE => sram_save);


	uut: testsuite PORT MAP(
		CLKIN => CLKIN,
		CLKFB => clkfb, 
		RESET => RESET,
		RX_DV => RX_DV,
		RX_ER => RX_ER,
		RXD => RXD,
		RX_CLK => RX_CLK,
		TXD => TXD,
		TX_EN => TX_EN,
		GTX_CLK => GTX_CLK,
		MA => MA,
		MD => MD,
		MCLK => MCLK,
		MWE => MWE,
		CLKIOIN => CLKIOIN,
		NEXTFRAME => NEXTFRAME,
		DOUT => DOUT,
		DOUTEN => DOUTEN,
		NEWFRAME => NEWFRAME,
		DIN => DIN,
		DINEN => DINEN,
		MDIO => MDIO,
		MDC => MDC,
		LEDACT => LEDACT,
		LEDTX => LEDTX,
		LEDRX => LEDRX,
		LED100 => LED100,
		LED1000 => LED1000,
		LEDDPX => LEDDPX,
		PHYRESET => PHYRESET,
		SCLK => SCLK,
		SIN => SIN,
		SOUT => SOUT,
		SCS => SCS,
		MACADDR => MACADDR,
		MACDATA => MACDATA,
		IFCLK => IFCLK,
		NEXTF => NEXTF,
		TESTOUT => TESTOUT
	);

	reset <= '0' after 100 ns;
	CLKIN <= not CLKIN after 4 ns;
	IFCLK <= not IFCLK after 15 ns;
	RX_CLK <= not RX_CLK after 4 ns;  

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***


	macaddr <= "00000001" after 1 us; 
	RX_DV <= '1' after 10 us, '0' after 20 us; 
	MDIO <= 'L'; 
	serialtest: process(CLKIN) is
	begin
		if rising_edge(CLKIN) then 
			counter <= counter + 1; 
			if counter mod 50 = 0  and not (counter mod 100 = 0) then
				sclk <= '1';
			elsif counter mod 100 = 0 then
				sclk <= '0';
			end if; 
			if counter = 0 then
				scs <= '1';
				sin <= '0';
			elsif counter = 4000 - 10 then 
				scs <= '0';
			elsif counter = 9000 - 10 then
				scs <= '1';
			end if; 

			if counter = 14000 - 10 then 
				scs <= '0';
			elsif counter = 19000 - 10 then
				scs <= '1';
			end if; 
		end if; 
	end process serialtest; 

END;
