
-- VHDL Test Bench Created from source file txoutput.vhd -- 19:57:23 10/09/2004
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

ENTITY txtest IS
END txtest;

ARCHITECTURE behavior OF txtest IS 

	COMPONENT txoutput
	PORT(
		CLK : IN std_logic;
		RESET : IN std_logic;
		MQ : IN std_logic_vector(31 downto 0);
		BPIN : IN std_logic_vector(15 downto 0);
		CLKEN : IN std_logic;          
		MA : OUT std_logic_vector(15 downto 0);
		TXD : OUT std_logic_vector(7 downto 0);
		TXEN : OUT std_logic;
		TXF : OUT std_logic;
		FBBP : OUT std_logic_vector(15 downto 0);
		GTX_CLK : OUT std_logic
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic := '0';
	SIGNAL RESET :  std_logic := '1';
	SIGNAL MQ :  std_logic_vector(31 downto 0);
	SIGNAL MA :  std_logic_vector(15 downto 0);
	SIGNAL BPIN :  std_logic_vector(15 downto 0);
	SIGNAL TXD :  std_logic_vector(7 downto 0);
	SIGNAL TXEN :  std_logic;
	SIGNAL TXF :  std_logic;
	SIGNAL FBBP :  std_logic_vector(15 downto 0);
	SIGNAL CLKEN :  std_logic;
	SIGNAL GTX_CLK :  std_logic;


	component simpleram is
	    Generic (addrwidth : integer := 15;
	    		   filename : string := "test.dat"; 
    		   	   datawidth : integer := 32); 
	    Port ( CLK : in std_logic;
	           RESET : in std_logic;
	           ADOUT : in std_logic_vector((addrwidth-1) downto 0);
	           DOUT : out std_logic_vector(datawidth-1 downto 0);
			 ADIN: in std_logic_vector((addrwidth-1) downto 0);
			 DIN : in std_logic_vector(datawidth-1 downto 0);
			 WE : in std_logic;
			 SAVE : in std_logic); 
	end component;

	signal dout,doutl1, doutl2, doutl3, doutl4, doutl5, doutl6 :
		std_logic_vector(31 downto 0) := (others => '0'); 
		 
	signal gmii_verify_ack : std_logic := '0'; 
	signal expected_txd : std_logic_vector(7 downto 0); 
	signal gmii_rx_error : std_logic := '0';
BEGIN

	uut: txoutput PORT MAP(
		CLK => CLK,
		RESET => RESET,
		MQ => MQ,
		MA => MA,
		BPIN => BPIN,
		TXD => TXD,
		TXEN => TXEN,
		TXF => TXF,
		FBBP => FBBP,
		CLKEN => CLKEN,
		GTX_CLK => GTX_CLK
	);

	bufram: simpleram generic map(
		addrwidth => 16,
		filename => "basic.ram.dat", 
		datawidth => 32)
		port map (
			CLK => clk,
			RESET => RESET, 
			ADOUT => MA, 
			DOUT => dout,
			ADIN => (others => '0'),
			DIN => (others => '0'), 
			WE => '0',
			SAVE => '0');
			
	-- generic timing stuff:
	clk <= not clk after 4 ns; 
	
	
	-- ram latency simulation
	process (clk) is
	begin
		if rising_edge(clk) then
			doutl1 <= dout; 
			doutl2 <= doutl1;
			doutl3 <= doutl2;
			doutl4 <= doutl3;
			doutl5 <= doutl4; 
			MQ <= doutl5; 
		end if; 
	end process; 

	process (clk, reset) is
		variable clkcnt : integer := 0; 
	begin
		if rising_edge(clk) then
			if RESET = '0' then
				if clkcnt = 3 then
					clkcnt := 0; 	
				else
					clkcnt := clkcnt + 1; 
				end if; 
				if clkcnt = 3 then
					CLKEN <= '1';
				else
					CLKEN <= '0';
				end if; 
			end if; 
		end if; 
	end process; 
				

	-- main code:
	main: process is
		file bpfile : text;
		variable L : line; 
		variable currentbp : integer := 0; 
		variable currentlen : integer := 0; 
	begin		   	
		wait for 40 ns; 
		RESET <= '0';
		file_open(bpfile, "basic.bp.dat", read_mode); 
		while not endfile(bpfile) loop
			readline(bpfile, L);
			read(L, currentbp); 
			read(L, currentlen); 
			wait until rising_edge(clk) and CLKEN = '1';
			BPIN <= std_logic_vector(
				to_unsigned(currentbp + (currentlen + 3)/4 + 1, 16)); 
			wait until rising_edge(clk) and gmii_verify_ack = '1'; 
		end loop; 
		file_close(bpfile); 

		-- now we try with multiple bp-reads
		RESET <= '1';
		wait for 40 ns; 
		RESET <= '0';
		file_open(bpfile, "basic.bp.dat", read_mode); 
		while not endfile(bpfile) loop
			readline(bpfile, L);
			read(L, currentbp); 
			read(L, currentlen); 
			wait until rising_edge(clk) and CLKEN = '1';
			BPIN <= std_logic_vector(
				to_unsigned(currentbp + (currentlen + 3)/4 + 1, 16)); 
			if not endfile(bpfile) then
				readline(bpfile, L);
				read(L, currentbp); 
				read(L, currentlen); 
				wait until rising_edge(clk) and CLKEN = '1';
				BPIN <= std_logic_vector(
					to_unsigned(currentbp + (currentlen + 3)/4 + 1, 16)); 
			end if; 
			if not endfile(bpfile) then
				readline(bpfile, L);
				read(L, currentbp); 
				read(L, currentlen); 
				wait until rising_edge(clk) and CLKEN = '1';
				BPIN <= std_logic_vector(
					to_unsigned(currentbp + (currentlen + 3)/4 + 1, 16)); 
			end if; 
			wait until rising_edge(clk) and gmii_verify_ack = '1'; 
		end loop; 

		file_close(bpfile); 


		assert false
			report "End of Simulation"
			severity failure;   

	end process main; 
	
	-- gmii output simulation
	gmii_verify: process(GTX_CLK, RESET) is
		file gmiifile : text;
		variable L : line; 
		variable indata : std_logic_vector(7 downto 0) := (others => '0');
		variable txenl : std_logic := '0'; 
		variable txerrors : integer := 0;  
	begin
		if falling_edge(RESET) then
		   file_open(gmiifile, "basic.gmii.dat", read_mode); 
		else
			if rising_edge(GTX_CLK) then
				if txenl = '0' and txen = '1' then -- rising edge
					txerrors := 0; 
					readline(gmiifile, L); 
					hread(L, indata); 
					expected_txd <= indata; 
					if TXD /= indata then
						txerrors := txerrors + 1; 
						gmii_rx_error <= '1';
					else	
						gmii_rx_error <= '0'; 
					end if; 
					gmii_verify_ack <= '0';
				elsif txenl = '1' and txen = '0' then
				     assert txerrors = 0 
						report "There was an error reading this frame"
						severity error;  
					gmii_verify_ack <= '1';

					if endfile(gmiifile) then
						file_close(gmiifile);
					end if; 
				elsif txenl = '1' and txen = '1' then
					hread(L, indata); 
					expected_txd <= indata; 
					if TXD /= indata then
						txerrors := txerrors + 1; 
						gmii_rx_error <= '1';
					else	
						gmii_rx_error <= '0'; 
					end if; 
					gmii_verify_ack <= '0';
				else
					gmii_verify_ack <= '0';
				end if;
				txenl := txen; 
			end if;
		end if;
	end process gmii_verify; 
 

END;
