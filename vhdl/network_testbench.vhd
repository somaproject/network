
-- VHDL Test Bench Created from source file network.vhd -- 20:00:56 09/20/2003
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
use ieee.std_logic_textio.ALL; 


USE ieee.numeric_std.ALL; 
use std.textio.all; 

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 
-- This is the main testbench for the network
-- It will evolve over time to become increasingly complicated
-- and read from an increasingly complicated set of vectors
--
-- 
--
-- We have two files, gmii.rx.*.dat, gmii.tx.*.dat


-- gmii.rx.*.dat is pushed into the RX* interface
--    RX_DV RX_ER RXD (hex) 

   constant FILE_GMII_RX : string := "testvectors/gmii.rx.0.dat";
    
 
	COMPONENT network
	PORT(
		clkin : IN std_logic;
		reset : IN std_logic;
		rx_dv : IN std_logic;
		rx_er : IN std_logic;
		rxd : IN std_logic_vector(7 downto 0);
		rx_clk : IN std_logic;
		clkioin : IN std_logic;
		nextframe : IN std_logic;
		newframe : IN std_logic;
		din : IN std_logic_vector(15 downto 0);
		dinen : IN std_logic;    
		md : INOUT std_logic_vector(31 downto 0);      
		txd : OUT std_logic_vector(7 downto 0);
		tx_en : OUT std_logic;
		gtx_clk : OUT std_logic;
		ma : OUT std_logic_vector(16 downto 0);
		mclk : OUT std_logic;
		mwe : OUT std_logic;
		dout : OUT std_logic_vector(15 downto 0);
		douten : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clkin :  std_logic := '0';
	SIGNAL reset :  std_logic := '1';
	SIGNAL rx_dv :  std_logic := '0';
	SIGNAL rx_er :  std_logic := '0';
	SIGNAL rxd :  std_logic_vector(7 downto 0) := (others => '0');
	SIGNAL rx_clk :  std_logic := '0';
	SIGNAL txd :  std_logic_vector(7 downto 0);
	SIGNAL tx_en :  std_logic;
	SIGNAL gtx_clk :  std_logic;
	SIGNAL ma :  std_logic_vector(16 downto 0);
	SIGNAL md :  std_logic_vector(31 downto 0) := (others => 'Z');
	SIGNAL mclk :  std_logic;
	SIGNAL mwe :  std_logic;
	SIGNAL clkioin :  std_logic := '0';
	SIGNAL nextframe :  std_logic := '0';
	SIGNAL dout :  std_logic_vector(15 downto 0);
	SIGNAL douten :  std_logic;
	SIGNAL newframe :  std_logic := '0';
	SIGNAL din :  std_logic_vector(15 downto 0);
	SIGNAL dinen :  std_logic := '0';

BEGIN

	uut: network PORT MAP(
		clkin => clkin,
		reset => reset,
		rx_dv => rx_dv,
		rx_er => rx_er,
		rxd => rxd,
		rx_clk => rx_clk,
		txd => txd,
		tx_en => tx_en,
		gtx_clk => gtx_clk,
		ma => ma,
		md => md,
		mclk => mclk,
		mwe => mwe,
		clkioin => clkioin,
		nextframe => nextframe,
		dout => dout,
		douten => douten,
		newframe => newframe,
		din => din,
		dinen => dinen
	);

-- SYSTEM CLOCKS
--  Here's where we define our clocks;
   clkin <= not clkin after 8 ns;
   rx_clk <= not rx_clk after 8 ns; 
   clkioin <= not clkioin after 17 ns; 
   
   reset <= '0' after 10 ns; 


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***


   gmii_rx : process(rx_clk) is
      -- again, this format is RX_DV, RX_ER, RXD
	file load_file : text open read_mode is FILE_GMII_RX;	

	variable L : line;
	
	variable RX_DV_var, RX_ER_var : bit := '0';
	variable RXD_var : std_logic_vector(7 downto 0) := (others => '0');
	 

   begin
     if rising_edge(rx_clk) then
 		if not endfile(load_file) then 
			readline(load_file, L);
			read(L, RX_DV_var);
		 	read(L, RX_ER_var);
		 	hread(L, RXD_var);
			
			rx_dv <= TO_X01(RX_DV_var);
			rx_er <= to_x01(RX_ER_var);
			rxd <= to_x01(RXD_var); 


		end if;   

	end if; 
   end process gmii_rx;


END;
