
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
   constant FILE_GMII_TX : string := "testvectors/gmii.tx.0.dat";
   constant FILE_IO_TX : string := "testvectors/io.tx.0.dat";
   constant FILE_IO_RX : string := "testvectors/io.rx.0.dat";
    
 
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
	SIGNAL mwe :  std_logic := '1';
	SIGNAL clkioin :  std_logic := '0';
	SIGNAL nextframe :  std_logic := '0';
	SIGNAL dout :  std_logic_vector(15 downto 0);
	SIGNAL douten :  std_logic;
	SIGNAL newframe :  std_logic := '0';
	SIGNAL din :  std_logic_vector(15 downto 0);
	SIGNAL dinen :  std_logic := '0';


---------------------------------------
-- support components
---------------------------------------
	component test_NoBLSRAM is
	    Generic (  FILEIN : string := "SRAM_in.dat"; 
	    			FILEOUT : string := "SRAM_out.dat"); 
	    Port ( CLK : in std_logic;
	           DQ : inout std_logic_vector(31 downto 0);
	           ADDR : in std_logic_vector(16 downto 0);
	           WE : in std_logic;
	           RESET : in std_logic;
			 SAVE : in std_logic);
	end component;

	signal sram_save : std_logic := '0'; 




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

---------------------------------------
-- support components
---------------------------------------
   sram: test_NoBLSRAM generic map (
   		FILEIN => "testvectors/sram.in.0.dat",
		FILEOUT => "testvectors/sram.out.0.dat")
		port map (
		CLK => mclk,
		DQ => md,
		ADDR => ma,
		WE => mwe,
		reset => RESET,
		SAVE => sram_save);

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


   master: process(clkin) is
      variable count: integer := 0; 
   begin
      if rising_edge(clkin) then
	    count := count + 1; 


	 end if;
	 
	 if count = 1000 then
	    sram_save <= '1';
	 else
	    sram_save <= '0';
 	 end if; 
   end process master; 


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

  gmii_tx : process(gtx_clk) is
      -- again, this format is TX_EN, TX_ER, TXD
	file write_file : text open write_mode is FILE_GMII_TX;	

	variable L : line;
	
	variable TX_EN_var : bit := '0';
	variable TXD_var : std_logic_vector(7 downto 0) := (others => '0');
	 

   begin
     if rising_edge(gtx_clk) then
 		 	-- wow, do realize that a full second of activity
			-- will generate 1 GB of data!
		 	TX_EN_var := to_bit(tx_en); 
			TXD_var := txd; 

			write(L, TX_EN_var);
			write(L, character(' '));
			 
			write(L, to_bit('0'));
			
			write(L, character(' ')); 
			hwrite(L, TXD_var); 
			writeline(write_file, L);

	end if;   

   end process gmii_tx;

   io_input : process(clkioin) is
      
	file load_file : text open read_mode is FILE_IO_TX;	

	variable L : line;
	
	variable tx_newframe : bit := '0';
	variable TX_data : std_logic_vector(15 downto 0) := (others => '0');
	 

   begin
     if rising_edge(clkioin) then
 		if not endfile(load_file) then 
			readline(load_file, L);
			read(L, tx_newframe);
		 	hread(L, tx_data);
			
			
			newframe <= to_x01(tx_newframe);
			din <= to_x01(tx_data); 


		end if;   

	end if; 
   end process io_input;


  io_output : process(clkioin, reset) is
     -- try and do this the way i'm supposed to 
	file write_file : text open write_mode is FILE_IO_RX;	

	variable L : line;
	

	variable dout_var : std_logic_vector(15 downto 0) := (others => '0');
	variable pktlen : std_logic_vector(15 downto 0) := (others => '0');
	 
     variable outstate : integer := 0; 
	variable frame_length : integer := 0;
	variable fcnt : integer := 0;  

   begin
     if rising_edge(clkioin) then
			
			-- so this is kind of a crap-out, because it doesnt
			-- let us test a lot of the receive-data functionality
			-- which is bad in that we can't test how well
			-- our design contracts hold. But on the bright
			-- side, it does return packets!

			if reset = '0' then
			   if nextframe = '0' and outstate = 0 then 
			      nextframe <= '1';
				 outstate := 1; 
			   elsif outstate = 3 then
			      nextframe <= '0'; 
 			      outstate := 4;
			   elsif outstate = 4 then 
			      IF douten = '0' THEN 
				   	 nextframe <= '0';
					 outstate := 0;
				 end if; 
			   end if; 
				
			   if outstate = 1 then
			   	 if DOUTEN = '1' then
				    pktlen := DOUT;
				    frame_length := to_integer(unsigned(DOUT));
				    fcnt :=  to_integer(unsigned(DOUT));
				    outstate := 2;
				    write(L, frame_length);
				    writeline(write_file, L);
				 end if; 
			   end if; 
			   
			   if outstate = 2 then
			   	 if fcnt < 1 then
				 	outstate := 3; 
				  	if DOUTEN = '1' then
					   hwrite(L, DOUT); 
					   writeline(write_file, L); 
					end if;
				 else
				  	if DOUTEN = '1' then
					   fcnt := fcnt - 2;
					   hwrite(L, DOUT); 
					   writeline(write_file, L); 
					end if;
				 end if;
			  end if;
		    end if; 
	end if;   

   end process io_output;
END;
