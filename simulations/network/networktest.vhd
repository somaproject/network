
-- VHDL Test Bench Created from source file network.vhd -- 12:33:36 11/12/2004
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all; 
use  ieee.numeric_std.all; 
use std.TextIO.ALL; 


ENTITY networktest IS
END networktest;

ARCHITECTURE behavior OF networktest IS 

	COMPONENT network
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
		LEDPOWER : OUT std_logic;
		PHYRESET : OUT std_logic;
		SOUT : OUT std_logic
		);
	END COMPONENT;

	component NoBLSRAM is
	    Generic (  FILEIN : string := "SRAM_in.dat"; 
	    			FILEOUT : string := "SRAM_out.dat";
					physical_sim : integer := 0;
					TSU : time;
					THD : time;
					TKQ : time; 
					TKQX : time); 
	    Port ( CLK : in std_logic;
	           DQ : inout std_logic_vector(31 downto 0);
	           ADDR : in std_logic_vector(16 downto 0);
	           WE : in std_logic;
	           RESET : in std_logic;
			 SAVE : in std_logic);
	end component;

	SIGNAL CLKIN :  std_logic := '0';
	SIGNAL RESET :  std_logic := '1';
	SIGNAL RX_DV :  std_logic;
	SIGNAL RX_ER :  std_logic;
	SIGNAL RXD :  std_logic_vector(7 downto 0);
	SIGNAL RX_CLK :  std_logic := '0';
	SIGNAL TXD :  std_logic_vector(7 downto 0);
	SIGNAL TX_EN :  std_logic;
	SIGNAL GTX_CLK :  std_logic;
	SIGNAL MA :  std_logic_vector(16 downto 0);
	SIGNAL MD :  std_logic_vector(31 downto 0);
	SIGNAL MCLK :  std_logic;
	SIGNAL MWE :  std_logic;
	SIGNAL CLKIOIN :  std_logic := '0';
	SIGNAL NEXTFRAME :  std_logic := '0';
	SIGNAL DOUT :  std_logic_vector(15 downto 0)
		:= (others => '0');
	SIGNAL DOUTEN :  std_logic := '0';
	SIGNAL NEWFRAME :  std_logic := '0';
	SIGNAL DIN :  std_logic_vector(15 downto 0);
	SIGNAL MDIO :  std_logic := '0';
	SIGNAL MDC :  std_logic := '0';
	SIGNAL LEDACT :  std_logic;
	SIGNAL LEDTX :  std_logic;
	SIGNAL LEDRX :  std_logic;
	SIGNAL LED100 :  std_logic;
	SIGNAL LED1000 :  std_logic;
	SIGNAL LEDDPX :  std_logic;
	SIGNAL LEDPOWER :  std_logic;
	SIGNAL PHYRESET :  std_logic;
	SIGNAL SCLK :  std_logic := '0';
	SIGNAL SIN :  std_logic := '0';
	SIGNAL SOUT :  std_logic;
	SIGNAL SCS :  std_logic := '0';

	signal save : std_logic := '0'; 
	signal expected_gmiiout : std_logic_vector(7 downto 0)
		:= (others => '0');

	signal rxinput_done, rxoutput_done, 
		txinput_done, txoutput_done : std_logic := '0';


BEGIN

	uut: network PORT MAP(
		CLKIN => CLKIN,
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
		MDIO => MDIO,
		MDC => MDC,
		LEDACT => LEDACT,
		LEDTX => LEDTX,
		LEDRX => LEDRX,
		LED100 => LED100,
		LED1000 => LED1000,
		LEDDPX => LEDDPX,
		LEDPOWER => LEDPOWER,
		PHYRESET => PHYRESET,
		SCLK => SCLK,
		SIN => SIN,
		SOUT => SOUT,
		SCS => SCS
	);

    ram : NoBLSRAM generic map (
    		TSU => 0 ns,
		THD => 0 ns,
		TKQ => 0 ns,
		TKQX => 0 ns)	
		port map (
    		CLK => MCLK,
		DQ => MD,
		ADDR => MA,
		WE => MWE,
		RESET => RESET,  
		SAVE => SAVE);

    clkin <= not clkin after 4 ns;
    clkioin <= not clkioin after 8.5 ns;
    RX_CLK <= not RX_CLK after 4 ns;  

    reset <= '0' after 80 ns; 
    save <= '1' after 1500 ns; 

	-- input data:
	rxinput: process is
		file gmiifile: text; 
		variable L : line; 
		variable dvin : integer := 0;
		variable erin : integer := 0; 
		variable rxdin : std_logic_vector(7 downto 0);

	begin					 	
		file_open(gmiifile, "gmiiin.0.dat", read_mode); 
		while not endfile(gmiifile) loop
			wait until rising_edge(RX_CLK) and RESET = '0'; 
			readline(gmiifile, L);
			hread(L, rxdin);
			read(L, dvin);
			read(L, erin); 

			if dvin = 0 then
				RX_DV <= '0';
			elsif dvin = 1 then
				RX_DV <= '1';
			end if; 

			if erin = 0 then
				RX_ER <= '0';
			else 
				RX_ER <= '1';
			end if; 
			RXD <= rxdin; 
		end loop; 
		rxinput_done <= '1'; 
		wait; 
	end process; 

	rxoutput : process is
		file datafile : text;
		variable L : line;
		variable words, nops, wcnt, ncnt : integer := 0;
		variable rdata : std_logic_vector(15 downto 0)
			:= (others => '0'); 
		variable bytelen : integer := 0; 

	begin
		wait until falling_edge(RESET);
			file_open(datafile, "dout.0.dat", read_mode);
			words := 0;
			nops := 0;
		wait until rising_edge(CLKIOin); 
		NEXTFRAME <= '0';
		while not endfile(datafile) loop
			readline(datafile, L);
			read(L, nops); 
			read(L, words);
			ncnt := -1; 
			bytelen := 0; 
			while ncnt < nops loop
				wait until rising_edge(CLKIOin);
				ncnt := ncnt + 1; 
			end loop;
			wcnt := 0; 
			NEXTFRAME <= '1' after 10 ns; 
			while wcnt < words loop
				wait until rising_edge(CLKIOin) and DOUTEN = '1'; 
				wcnt := wcnt + 1;

				hread(L, rdata); 

				if wcnt = 1 then
					bytelen := to_integer(unsigned(rdata));
				end if; 
				if ((bytelen mod 2 = 0) and (rdata /= DOUT)) or
					((bytelen mod 2 = 1) and 
					(rdata(7 downto 0) /= DOUT(7 downto 0)))then
					assert false
						report "RXOUTPUT : error reading data"
						severity failure;   
				end if; 
		
			end loop; 
			NEXTFRAME <= '0' after 10 ns; 

		end loop; 
		rxoutput_done <= '1'; 
		wait; 
			
	end process rxoutput; 	

	-- input data:
	txinput: process is
		file dinfile: text; 
		variable L : line; 
		variable newframein : integer := 0;
		variable dinin : std_logic_vector(15 downto 0);

	begin				
		wait until falling_edge(RESET); 
		
		   wait for 400 ns; 
		file_open(dinfile, "din.0.dat", read_mode); 
		while not endfile(dinfile) loop
			wait until rising_edge(CLKIOin); 
			readline(dinfile, L);
			read(L, newframein); 
			hread(L, dinin);
			if newframein = 0 then
				NEWFRAME <= '0';
			elsif newframein = 1 then
				NEWFRAME <= '1';
			end if; 
			DIN <= dinin; 
		end loop;
		txinput_done <= '1';  
		wait; 

	end process txinput; 

	
	--tx output simulation
	txoutput : process is
		file gmiifile : text;
		variable L : line; 
		variable indata : std_logic_vector(7 downto 0) := (others => '0');
		variable txenl : std_logic := '0'; 
		variable txerrors : integer := 0;  
	begin
		wait until falling_edge(RESET);
		   file_open(gmiifile, "gmiiout.0.dat", read_mode); 
		while not endfile(gmiifile) or TX_EN = '1' loop
		   	wait until rising_edge(GTX_CLK);

			if txenl = '0' and TX_EN = '1' then -- rising edge
				txerrors := 0; 
				readline(gmiifile, L); 
				hread(L, indata); 
				if TXD /= indata then
					txerrors := txerrors + 1; 
				end if;
				expected_gmiiout <= indata;  
			elsif txenl = '1' and TX_EN = '0' then
			     if txerrors /= 0 then
					assert false
						report "TXOUTPUT: error reading frame on gmii"
						severity failure;   
				end if;  

			elsif txenl = '1' and TX_EN = '1' then
				hread(L, indata); 
				if TXD /= indata then
					assert false
						report "TXOUTPUT: error reading frame on gmii"
						severity failure;   					
				end if; 
	
				expected_gmiiout <= indata; 
			end if;

			txenl := TX_EN; 
		end loop; 

		txoutput_done <= '1';
		wait;  
	end process txoutput;


	endofsim: process(rxinput_done, rxoutput_done,
				txinput_done, txoutput_done) is
	begin
		if rxinput_done = '1' and rxoutput_done = '1'
			and txoutput_done = '1' and txinput_done ='1' then
				assert false
					report "End of simulation"
					severity failure;   
		end if; 
		
	end process endofsim;   

END;
