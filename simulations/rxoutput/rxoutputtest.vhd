
-- VHDL Test Bench Created from source file rxoutput.vhd -- 20:16:03 11/05/2004
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

ENTITY rxoutputtest IS
END rxoutputtest;

ARCHITECTURE behavior OF rxoutputtest IS 

	COMPONENT rxoutput
	PORT(
		CLK : IN std_logic;
		CLKEN : IN std_logic;
		RESET : IN std_logic;
		BPIN : IN std_logic_vector(15 downto 0);
		MQ : IN std_logic_vector(31 downto 0);
		CLKIO : IN std_logic;
		NEXTFRAME : IN std_logic;          
		FBBP : OUT std_logic_vector(15 downto 0);
		MA : OUT std_logic_vector(15 downto 0);
		DOUT : OUT std_logic_vector(15 downto 0);
		DOUTEN : OUT std_logic
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic := '0';
	SIGNAL CLKEN :  std_logic := '0';
	SIGNAL RESET :  std_logic := '1';
	SIGNAL BPIN :  std_logic_vector(15 downto 0);
	SIGNAL FBBP :  std_logic_vector(15 downto 0);
	SIGNAL MA :  std_logic_vector(15 downto 0);
	SIGNAL MQ :  std_logic_vector(31 downto 0);
	SIGNAL CLKIO :  std_logic := '0';
	SIGNAL NEXTFRAME :  std_logic := '0';
	SIGNAL DOUT :  std_logic_vector(15 downto 0);
	SIGNAL DOUTEN :  std_logic;
	SIGNAL READDATA : std_logic_vector(31 downto 0) 
		:= (others => '0');
	signal DOUTEXPECTED : std_logic_vector(15 downto 0)
		:= (others => '0'); 
BEGIN

	uut: rxoutput PORT MAP(
		CLK => CLK,
		CLKEN => CLKEN,
		RESET => RESET,
		BPIN => BPIN,
		FBBP => FBBP,
		MA => MA,
		MQ => MQ,
		CLKIO => CLKIO,
		NEXTFRAME => NEXTFRAME,
		DOUT => DOUT,
		DOUTEN => DOUTEN
	);



	CLK <= not CLK after 4 ns; 
	--CLKIO <= not CLKIO after 8.4 ns; 
	CLKIO <= not CLKIO after 50 ns; 

	RESET <= '0' after 40 ns; 

	-- clken 
	clkenlatch: process(CLK) is
		variable cnt : integer := 0; 
	begin
		if rising_edge(CLK) and RESET = '0' then
			if cnt = 3 then
				cnt := 0; 
			else
				cnt := cnt + 1; 
			end if; 
			if cnt = 3 then 
				CLKEN <= '1' after 2 ns;
			else
				CLKEN <= '0' after 2 ns;
			end if; 

		end if;
	end process; 

	bpfollower: process is
		file bpfile: text;
		variable L: line;
		variable bpold, bpnew : std_logic_vector(15 downto 0)
			:= (others => '0'); 
	begin
		wait until falling_edge(RESET);
			file_open(bpfile, "bp.dat", read_mode);
		while not endfile(bpfile) loop
			wait until rising_edge(CLK); 
			readline(bpfile, L);
			hread(L, bpold);
			hread(L, bpnew);
			while fbbp /= bpin loop
				wait until rising_edge(CLK);
			end loop; 
			BPIN <= bpnew; 
			
		end loop; 
	end process bpfollower; 
		

	memdata : process(CLK, RESET) is
		file memfile : text;
		variable L: line; 
		variable inaddr, addr  : std_logic_vector(15 downto 0)
			:= (others => '0');
		variable indata, data, mdl: std_logic_vector(31 downto 0)
			:= (others => '0'); 
		variable md1, md2, md3, md4, md5, md6, md7
			: std_logic_vector(31 downto 0) 
			:= (others => '0');
		variable memfilepos : integer := 0; 

		type ramtype is array(2**16 -1 downto 0) of integer ; 
	     variable ram : ramtype := (others => 0); 
	begin
		if falling_edge(RESET) then
		else 
			if rising_edge(CLK) and RESET = '0' then
				if MA = X"0000" and memfilepos = 0 then
					file_open(memfile, "ram.0.low.dat", read_mode); 
					while not endfile(memfile) loop 
						readline(memfile, L); 
						hread(L, inaddr);
						hread(L, indata); 
						ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata)); 
					end loop; 
					file_close(memfile); 
					memfilepos := 1;
				elsif MA = X"4000" and memfilepos = 1 then
					file_open(memfile, "ram.0.high.dat", read_mode); 
					while not endfile(memfile) loop 
						readline(memfile, L); 
						hread(L, inaddr);
						hread(L, indata); 
						ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata)); 
					end loop; 
					file_close(memfile); 					memfilepos := 2;
				elsif MA = X"F000" and memfilepos = 2 then
					file_open(memfile, "ram.1.low.dat", read_mode); 
					while not endfile(memfile) loop 
						readline(memfile, L); 
						hread(L, inaddr);
						hread(L, indata); 
						ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata)); 
					end loop; 
					file_close(memfile); 					memfilepos := 3; 
				elsif MA = X"4000" and memfilepos = 3 then
					file_open(memfile, "ram.1.high.dat", read_mode); 
					while not endfile(memfile) loop 
						readline(memfile, L); 
						hread(L, inaddr);
						hread(L, indata); 
						ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata)); 
					end loop; 
					file_close(memfile); 					memfilepos := 4;
				end if; 

				if CLKEN = '1' then									
					data := std_logic_vector(to_signed(ram(to_integer(unsigned(MA))), 32));
				end if; 
				md6 := md5;
				md5 := md4;
				md4 := md3; 
				md3 := md2;
				md2 := md1;
				md1 := data;  

				MQ <= md5; 
			end if; 
		end if; 
	end process memdata; 

	checkdata : process is
		file datafile : text;
		variable L : line;
		variable words, nops, wcnt, ncnt : integer := 0;
		variable rdata : std_logic_vector(15 downto 0)
			:= (others => '0'); 
	begin
		wait until falling_edge(RESET);
			file_open(datafile, "data.dat", read_mode);
			words := 0;
			nops := 0;
		wait until rising_edge(CLKIO); 
		NEXTFRAME <= '0';
		while not endfile(datafile) loop
			readline(datafile, L);
			read(L, nops); 
			read(L, words);
			ncnt := -1; 
			while ncnt < nops loop
				wait until rising_edge(CLKIO);
				ncnt := ncnt + 1; 
			end loop;
			wcnt := 0; 
			NEXTFRAME <= '1' after 10 ns; 
			while wcnt < words loop
				wait until rising_edge(CLKIO) and DOUTEN = '1'; 
				wcnt := wcnt + 1;
				hread(L, rdata); 
				DOUTEXPECTED <= rdata; 
				if rdata /= DOUT then
					assert false
						report "error reading data"
						severity failure;   
				end if; 
		
			end loop; 
			NEXTFRAME <= '0' after 10 ns; 

		end loop; 

		wait; 
			
	end process checkdata; 	

END;
