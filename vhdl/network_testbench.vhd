
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

ENTITY network_testbench IS
END network_testbench;

ARCHITECTURE behavior OF network_testbench IS 
-- This is the main testbench for the network
-- It will evolve over time to become increasingly complicated
-- and read from an increasingly complicated set of vectors
--
-- 
--
-- We have two files, gmii.rx.*.dat, gmii.tx.*.dat


-- gmii.rx.*.dat is pushed into the RX* interface
--    RX_DV RX_ER RXD (hex) 

   constant FILE_GMII_RX : string := "testvectors/gmii.rx.allframes.dat";
   constant FILE_GMII_TX : string := "testvectors/gmii.tx.3.dat";
   constant FILE_IO_RAW_TX : string := "testvectors/io.tx.raw.0.dat";
   constant FILE_IO_FRAME_TX : string := "testvectors/io.tx.frame.3.dat";
   constant FILE_IO_RX : string := "testvectors/io.rx.allframes.dat";
    
 
	component network is
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
	           DINEN : in std_logic;
				  MDIO : inout std_logic;
				  MDC : out std_logic;
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
				  SCS : in std_logic );
	end component;

	SIGNAL clkin :  std_logic := '0';
	SIGNAL reset :  std_logic := '1';
	SIGNAL rx_dv :  std_logic := '0';
	SIGNAL rx_er :  std_logic := '0';
	SIGNAL rxd :  std_logic_vector(7 downto 0) := (others => '0');
	SIGNAL rx_clk :  std_logic := '0';
	SIGNAL txd :  std_logic_vector(7 downto 0);
	SIGNAL tx_en :  std_logic;
	SIGNAL gtx_clk :  std_logic;
	SIGNAL ma, ma_delay :  std_logic_vector(16 downto 0);
	SIGNAL md, md_delay :  std_logic_vector(31 downto 0) := (others => 'Z');
	SIGNAL mclk, mclk_delay :  std_logic;
	SIGNAL mwe, mwe_delay :  std_logic := '1';
	SIGNAL clkioin :  std_logic := '0';
	SIGNAL nextframe :  std_logic := '0';
	SIGNAL dout :  std_logic_vector(15 downto 0);
	SIGNAL douten :  std_logic;
	SIGNAL newframe :  std_logic := '0';
	SIGNAL din :  std_logic_vector(15 downto 0);
	SIGNAL dinen :  std_logic := '0';
	SIGNAL mdio : std_logic := '0';
	SIGNAL mdc : std_logic;
	SIGNAL ledact : std_logic; 
	SIGNAL ledtx : std_logic; 
	SIGNAL ledrx : std_logic; 
	SIGNAL led100 : std_logic; 
	SIGNAL led1000 : std_logic; 
	SIGNAL leddpx : std_logic; 
	SIGNAL phyreset : std_logic; 
	SIGNAL sclk : std_logic;
	signal sin : std_logic;
	signal sout : std_logic;
	signal scs : std_logic; 

---------------------------------------
-- support components
---------------------------------------
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

	signal sram_save : std_logic := '0'; 

	signal io_input_mode : integer := 1; 
	signal gmii_loopback : integer := 0; 
	signal din_frame, din_raw : std_logic_vector(15 downto 0) := (others => '0');
	signal newframe_frame, newframe_raw : std_logic := '0';



BEGIN
	-- delay setups
	ma_delay <= ma after 1 ns;
	md_delay <= md after 1 ns; 
	mclk_delay <= mclk after 1 ns;
	mwe_delay <= mwe after 1 ns; 


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
		dinen => dinen,
		mdio => mdio,
		mdc => mdc,
		ledact => ledact,
		ledtx => ledtx,
		ledrx => ledrx,
		led100 => led100,
		led1000 => led1000,
		leddpx => leddpx,
		phyreset => phyreset,
		sclk => sclk,
		sin => sin,
		sout => sout,
		scs => scs
	);

---------------------------------------
-- support components
---------------------------------------
   sram: test_NoBLSRAM generic map (
   	FILEIN => "testvectors/sram.in.0.dat",
		FILEOUT => "testvectors/sram.out.0.dat",
		physical_sim => 0,
		TSU => 0 ns,
		THD => 0 ns,
		TKQ => 0 ns,
		TKQX => 0 ns
		)
		port map (
		CLK => mclk,
		DQ => md,
		ADDR => ma,
		WE => mwe,
		reset => RESET,
		SAVE => sram_save);

-- SYSTEM CLOCKS
--  Here's where we define our clocks;
   clkin <= not clkin after 4 ns;
   rx_clk <= not rx_clk after 4.001 ns; 
   clkioin <= not clkioin after 10 ns; 
   
   reset <= '0' after 200 ns; 

	SCLK <= 'L';
	SIN <= 'L'; 
	SCS <= 'H'; 

	MDIO <= 'H';

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


   gmii_rx : process(rx_clk, RESET) is
      -- again, this format is RX_DV, RX_ER, RXD
	file load_file : text open read_mode is FILE_GMII_RX;	

	variable L : line;
	
	variable RX_DV_var, RX_ER_var : bit := '0';
	variable RXD_var : std_logic_vector(7 downto 0) := (others => '0');
	 

   begin
     if rising_edge(rx_clk) then
 		if not endfile(load_file) and RESET = '0' then 
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


   din <= din_raw when io_input_mode = 0 else
   		din_frame when io_input_mode = 1;
   newframe <= newframe_raw when io_input_mode = 0 else
   		newframe_frame when io_input_mode = 1;

   io_input_raw : process(clkioin) is
      
	file load_file : text open read_mode is FILE_IO_RAW_TX;	

	variable L : line;
	
	variable tx_newframe : bit := '0';
	variable TX_data : std_logic_vector(15 downto 0) := (others => '0');
	 

   begin
     if rising_edge(clkioin) and io_input_mode = 0 then
 		if not endfile(load_file) then 
			readline(load_file, L);
			read(L, tx_newframe);
		 	hread(L, tx_data);
			
			
			newframe_raw <= to_x01(tx_newframe);
			din_raw <= to_x01(tx_data); 


		end if;   

	end if; 
   end process io_input_raw;


	

   io_input_frame : process is
      
	file load_file : text open read_mode is FILE_IO_FRAME_TX;	

	variable L : line;
	
	variable tx_newframe : bit := '0';
	variable TX_data : std_logic_vector(15 downto 0) := (others => '0');
	variable bytecount : integer := 0; 
	variable byte : std_logic_vector(7 downto 0); 
	 
												  
   begin
     wait for 1 us; 
     while not endfile(load_file) loop
		wait until rising_edge(clkioin); 
		if io_input_mode = 1 then
		   readline(load_file, L); 
		   read(L, bytecount); 
		   newframe_frame <= '1' after 1 ns; 
		   din_frame <= std_logic_vector(to_unsigned(bytecount, 16)) after 1 ns; 
		   
		   for i in  0 to (bytecount -1) loop
			  if i mod 2 = 0 then 
			    wait until rising_edge(clkioin); 
			  end if; 

 			  if (i mod 16) = 0 then
			  	readline(load_file, L);
			  end if;
			  
			  hread(L, byte); 
			  if i mod 2 = 0 then 
				TX_data(7 downto 0) := byte;
			  else
			  	TX_data(15 downto 8) := byte; 			      
			  end if; 
			  din_frame <= TX_data; 
		   end loop ;


		   wait until rising_edge(clkioin);
		   din_frame <= (others => '0') after 1 ns;
		   newframe_frame<= '0' after 1 ns;

		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		   wait until rising_edge(clkioin);
		end if; 
		wait until rising_edge(clkioin);
	end loop; 
	wait until rising_edge(clkioin);
   end process io_input_frame;



  io_output : process(clkioin, reset) is
     -- try and do this the way i'm supposed to 
	file write_file : text open write_mode is FILE_IO_RX;	

	variable L : line;
	

	variable dout_var : std_logic_vector(15 downto 0) := (others => '0');
	variable pktlen : std_logic_vector(15 downto 0) := (others => '0');
	 
     variable outstate : integer := 0; 
	variable frame_length : integer := 0;
	variable fcnt : integer := 0;  

	variable wordpos: integer; 

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
				    --write(L, frame_length);
				    --writeline(write_file, L);
				    wordpos := 0; 
				 end if; 
			   elsif outstate = 2 then
			   	 if fcnt < 1 then
				 	outstate := 3; 
				  	if DOUTEN = '1' then
					   --hwrite(L, DOUT(7 downto 0));
					   --write(L, character(' ')); 
					   --hwrite(L, DOUT(15 downto 8));  
					   if frame_length mod 16 /= 0 then
					      writeline(write_file, L);
					   end if;  
					end if;
				 else
				  	if DOUTEN = '1' then
					   fcnt := fcnt - 1;
					   hwrite(L, DOUT(7 downto 0));
					   write(L, character(' '));
					   fcnt := fcnt - 1;
					   if fcnt >-1 then
						   hwrite(L, DOUT(15 downto 8));
						   write(L, character(' '));  
						   wordpos := wordpos + 1; 
					   end if; 
					    
					end if;
				 end if;
				 if wordpos >7  then 
				 	wordpos := 0;
					--writeline(write_file, L);
				 end if; 
			  end if;
		    end if; 
	end if;   

   end process io_output;
END;
