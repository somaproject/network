
-- VHDL Test Bench Created from source file control.vhd -- 20:20:21 10/16/2004
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

ENTITY controltest IS
END controltest;

ARCHITECTURE behavior OF controltest IS 

	COMPONENT control
	PORT(
		CLK : IN std_logic;
		CLKSLEN : IN std_logic;
		RESET : IN std_logic;
		SCLK : IN std_logic;
		SCS : IN std_logic;
		SIN : IN std_logic;
		TXF : IN std_logic;
		RXF : IN std_logic;
		TXFIFOWERR : IN std_logic;
		RXFIFOWERR : IN std_logic;
		RXPHYERR : IN std_logic;
		RXOFERR : IN std_logic;
		RXCRCERR : IN std_logic;
		MDEBUGDATA : IN std_logic_vector(31 downto 0);
		RXBP : IN std_logic_vector(15 downto 0);
		RXFBBP : IN std_logic_vector(15 downto 0);
		TXBP : IN std_logic_vector(15 downto 0);
		TXFBBP : IN std_logic_vector(15 downto 0);    
		MDIO : INOUT std_logic;      
		SOUT : OUT std_logic;
		LEDACT : OUT std_logic;
		LEDTX : OUT std_logic;
		LEDRX : OUT std_logic;
		LED100 : OUT std_logic;
		LED1000 : OUT std_logic;
		LEDDPX : OUT std_logic;
		PHYRESET : OUT std_logic;
		RXBCAST : OUT std_logic;
		RXMCAST : OUT std_logic;
		RXUCAST : OUT std_logic;
		RXALLF : OUT std_logic;
		MACADDR : OUT std_logic_vector(47 downto 0);
		MDC : OUT std_logic;
		MDEBUGADDR : OUT std_logic_vector(16 downto 0)
		);
	END COMPONENT;

	component GMII is
	    Port ( MDIO : inout std_logic;
	           MDC : in std_logic;
	           DONE : out std_logic);
	end component;

	SIGNAL CLK :  std_logic := '0';
	SIGNAL CLKSLEN :  std_logic := '0';
	SIGNAL RESET :  std_logic := '0';
	SIGNAL SCLK :  std_logic;
	SIGNAL SCS :  std_logic;
	SIGNAL SIN :  std_logic;
	SIGNAL SOUT :  std_logic;
	SIGNAL LEDACT :  std_logic;
	SIGNAL LEDTX :  std_logic;
	SIGNAL LEDRX :  std_logic;
	SIGNAL LED100 :  std_logic;
	SIGNAL LED1000 :  std_logic;
	SIGNAL LEDDPX :  std_logic;
	SIGNAL PHYRESET :  std_logic;
	SIGNAL TXF :  std_logic :='0';
	SIGNAL RXF :  std_logic :='0';
	SIGNAL TXFIFOWERR :  std_logic :='0';
	SIGNAL RXFIFOWERR :  std_logic :='0';
	SIGNAL RXPHYERR :  std_logic :='0';
	SIGNAL RXOFERR :  std_logic :='0';
	SIGNAL RXCRCERR :  std_logic :='0';
	SIGNAL RXBCAST :  std_logic;
	SIGNAL RXMCAST :  std_logic;
	SIGNAL RXUCAST :  std_logic;
	SIGNAL RXALLF :  std_logic;
	SIGNAL MACADDR :  std_logic_vector(47 downto 0);
	SIGNAL MDIO :  std_logic;
	SIGNAL MDC :  std_logic;
	SIGNAL MDEBUGADDR :  std_logic_vector(16 downto 0);
	SIGNAL MDEBUGDATA :  std_logic_vector(31 downto 0);
	SIGNAL RXBP :  std_logic_vector(15 downto 0);
	SIGNAL RXFBBP :  std_logic_vector(15 downto 0);
	SIGNAL TXBP :  std_logic_vector(15 downto 0);
	SIGNAL TXFBBP :  std_logic_vector(15 downto 0);
	SIGNAL GMIIDONE : std_logic := '0';

	signal serialdin, serialdout : std_logic_vector(31 downto 0)
		:= (others => '0');
	signal serialaddr : std_logic_vector(6 downto 0)	
		:= (others => '0');
	signal serialrw : std_logic := '0';
	signal serialstart, serialdone : std_logic := '0';


BEGIN

	uut: control PORT MAP(
		CLK => CLK,
		CLKSLEN => CLKSLEN,
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
		TXF => TXF,
		RXF => RXF,
		TXFIFOWERR => TXFIFOWERR,
		RXFIFOWERR => RXFIFOWERR,
		RXPHYERR => RXPHYERR,
		RXOFERR => RXOFERR,
		RXCRCERR => RXCRCERR,
		RXBCAST => RXBCAST,
		RXMCAST => RXMCAST,
		RXUCAST => RXUCAST,
		RXALLF => RXALLF,
		MACADDR => MACADDR,
		MDIO => MDIO,
		MDC => MDC,
		MDEBUGADDR => MDEBUGADDR,
		MDEBUGDATA => MDEBUGDATA,
		RXBP => RXBP,
		RXFBBP => RXFBBP,
		TXBP => TXBP,
		TXFBBP => TXFBBP
	);

	gmii_io : gmii port map (
		MDC => MDC,
		MDIO => MDIO,
		DONE => GMIIDONE); 


	clk <= not clk after 4 ns;
	RESET <= '0' after 20 ns; 
	clock_enable: process(CLK) is
		variable clkcount : integer range 0 to 7 := 0;

	begin
		if rising_edge(CLK) then
		   if clkcount = 7 then	
		   	CLKSLEN <= '1';
			clkcount := 0;
		   else
		   	CLKSLEN <= '0';
			clkcount := clkcount + 1;
		   end if; 
		end if;		
	end process; 


	serialio : process is
	begin
		while 0 = 0  loop
			SCLK <= '0';
			wait until rising_edge(serialstart); 
			SCS <= '0';
			wait for 1 us;
			SIN <= serialrw; 
			wait for 0.5 us;
			SCLK <= '1'; 
			wait for 1 us;
			SCLK <= '0';
			wait for 0.5 us;
		
			for i in  6 downto 0 loop
			   SIN <= serialaddr(i);
			   wait for 0.5 us;
			   SCLK <= '1'; 
			   wait for 1 us;
			   SCLK <= '0';
			   wait for 0.5 us;		
			end loop;  

			-- input and output
			for i in  31 downto 0 loop
			   SIN <= serialdin(i);
			   wait for 0.5 us; 
			   serialdout(i) <= SOUT; 
			   SCLK <= '1';
			   wait for 1 us; 
			   SCLK <= '0';
			   wait for 0.5 us; 
			end loop; 
			SCS <= '1'; 
			serialdone <= '1';
			wait for 1 ns;
			serialdone <= '0';
		end loop; 
	end process; 

	main: process is
		procedure sread(addr : integer) is
		begin
			wait for 100 us; 
			serialrw <= '0'; -- read
			serialaddr <= std_logic_vector(to_signed(addr, 7)); 
			serialstart <= '1';
			wait until rising_edge(serialdone); 
		     serialstart <= '0';
		end sread; 

		procedure swrite(addr : integer;
			data: std_logic_vector(31 downto 0)) is
		begin
			wait for 100 us; 
			serialrw <= '1'; -- write
			serialaddr <=  std_logic_vector(to_signed(addr, 7)); 
			serialdin <= data ;
			serialstart <= '1';
			wait until rising_edge(serialdone); 
			serialstart <= '0'; 

		end swrite; 
		
			
	begin
		wait for 100 us; 
		wait until PHYRESET = '1'; 
		-- first, we test the debug readout
		sread(0); 
		if serialdout /= X"01234567" then
			report "Error reading debug output at address 0";
		end if; 
		-- test the phy reset
	     swrite(1, X"00000001"); 
		wait until rising_edge(PHYRESET); 

		-- test the write-to-phy skills
		-- we first write ABCD to location 0
		swrite(9, X"0000ABCD"); -- write PHYDI
		swrite(8, X"00000020"); -- write PHYA
		sread(8); 
		while serialdout(31) /= '1' loop
			sread(8);
		end loop; 
	   		

		-- then we write 1234 to location 1
		swrite(9, X"00001234"); -- write PHYDI
		swrite(8, X"00000021"); -- write PHYA
		sread(8); 
		while serialdout(31) /= '1' loop
			sread(8);
		end loop; 
		

		-- now we try to read back ABCD from loc 0
		swrite(8, X"00000000"); -- write PHYA
		sread(8); 
		while serialdout(31) /= '1' loop
			sread(8);
		end loop; 

		sread(10);
		if serialdout(15 downto 0) /= X"ABCD" then
			report "Error reading back from PHY at address 0";
		end if; 

		-- now, write to 11 and F, and try and set PHYSTAT
		swrite(9, X"00007817"); -- write PHYDI	  
		swrite(8, X"00000031"); -- write PHYA, loc = 11
		sread(8); 
		while serialdout(31) /= '1' loop
			sread(8);
		end loop;

		swrite(9, X"0000AC57"); -- write PHYDI	  
		swrite(8, X"0000002F"); -- write PHYA, loc = 0xF
		sread(8); 
		while serialdout(31) /= '1' loop
			sread(8);
		end loop;

		wait for 0.5 ms;  -- delay to allow PHYSTAT To be updated

		-- now, read back phystat
		sread(2);
		if serialdout /= X"AC577817" then
			report "Error writing to PHY STATUS registers";
		end if;

		if LEDACT /= '1' or LEDDPX /= '1' then
			report "Error setting LEDs";
		end if; 
   		
		-- trigger the counters and see what we get:

		for i in  1 to 32768 loop
			if i mod 1 = 0 then
				TXF <= '1';
			else
				TXF <= '0';
			end if; 
			if i mod 2 = 0 then
				RXF <= '1';
			else
				RXF <= '0';
			end if;
			if i mod 4 = 0 then
				TXFIFOWERR <= '1';
			else
				TXFIFOWERR <= '0';
			end if; 
			if i mod 8 = 0 then
				RXFIFOWERR <= '1';
			else
				RXFIFOWERR <= '0';
			end if; 
			if i mod 16 = 0 then
				RXPHYERR <= '1';
			else
				RXPHYERR <= '0';
			end if; 
			if i mod 32 = 0 then
				RXOFERR <= '1';
			else
				RXOFERR <= '0';
			end if; 
 			if i mod 64 = 0 then
				RXCRCERR <= '1';
			else
				RXCRCERR <= '0';
			end if; 
 
			  
			wait until CLKSLEN = '1'; 	
			wait until rising_edge(CLK); 
		end loop;
		TXF <= '0';
		RXF <= '0';
		TXFIFOWERR <= '0';
		RXFIFOWERR <= '0';
		RXPHYERR <= '0';
		RXOFERR <= '0';
		RXCRCERR <= '0'; 

		sread(17); 
		if serialdout /= X"00008000"	then
			report "Error counting TXF";
		end if; 

		sread(18); 
		if serialdout /= X"00004000"	then
			report "Error counting RXF";
		end if; 

		sread(19); 
		if serialdout /= X"00002000"	then
			report "Error counting TXFIFOWERR";
		end if; 

		sread(20); 
		if serialdout /= X"00001000"	then
			report "Error counting RXFIFOWERR";
		end if; 


		sread(21); 
		if serialdout /= X"00000800"	then
			report "Error counting RXPHYERR";
		end if; 

		sread(22); 
		if serialdout /= X"00000400"	then
			report "Error counting RXOFERR";
		end if; 

		sread(23); 
		if serialdout /= X"00000200"	then
			report "Error counting RXCRCERR";
		end if; 

		swrite(16, X"00000001");
		sread(17); 
		if serialdout /= X"00000000"	then
			report "TXF Reset Failed";
		end if; 

		swrite(16, X"00000002");
		sread(18); 
		if serialdout /= X"00000000"	then
			report "RXF Reset Failed";
		end if; 

		swrite(16, X"00000004");
		sread(19); 
		if serialdout /= X"00000000"	then
			report "TXFIFOWERR Reset Failed";
		end if; 

		swrite(16, X"00000008");
		sread(20); 
		if serialdout /= X"00000000"	then
			report "RXFIFOWERR Reset Failed";
		end if; 

		swrite(16, X"00000010");
		sread(21); 
		if serialdout /= X"00000000"	then
			report "RXPHYERR Reset Failed";
		end if; 

		swrite(16, X"00000020");
		sread(22); 
		if serialdout /= X"00000000"	then
			report "RXOFERR Reset Failed";
		end if; 

		 
		-- now, try setting the mac addresses
		swrite(29, X"00001234"); 
		swrite(30, X"00005678");
		swrite(31, X"0000ABCD"); 
		sread(29);
		if serialdout /= X"00001234"	then
			report "MACADDR low-word write failed";
		end if; 
		sread(30);
		if serialdout /= X"00005678"	then
			report "MACADDR mid-word write failed";
		end if; 
		sread(31);
		if serialdout /= X"0000ABCD"	then
			report "MACADDR high-word write failed";
		end if; 


		

				
   		

	end process; 



END;
