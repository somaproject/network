
-- VHDL Test Bench Created from source file cpu.vhd -- 15:04:16 04/04/2003
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
USE ieee.std_logic_arith.ALL; 
USE std.textio.ALL;
use ieee.std_logic_textio.all;

ENTITY testbench IS																											  
END testbench;

ARCHITECTURE behavior OF testbench IS 
-- cpu_TESTBENCH
-- This is the main testbench for the CPU, we read in actual assembly output
-- and run it. 
--
-- The 133 MHz clock is CLKEN'd down to 33 MHz. 


	COMPONENT cpu
	PORT(
		clk : IN std_logic;
		clken : IN std_logic;
		imdin : IN std_logic_vector(15 downto 0);
		imaddrw : IN std_logic_vector(8 downto 0);
		reset : IN std_logic;
		imwe : IN std_logic;
		mq : IN std_logic_vector(31 downto 0);          
		yout : OUT std_logic_vector(31 downto 0);
		md : OUT std_logic_vector(31 downto 0);
		mwe : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic := '0';
	SIGNAL clken :  std_logic := '0';
	SIGNAL imdin :  std_logic_vector(15 downto 0);
	SIGNAL imaddrw :  std_logic_vector(8 downto 0) := "000000000";
	SIGNAL reset :  std_logic := '1';
	SIGNAL imwe :  std_logic;
	SIGNAL yout :  std_logic_vector(31 downto 0);
	SIGNAL md :  std_logic_vector(31 downto 0);
	SIGNAL mq :  std_logic_vector(31 downto 0);
	SIGNAL mwe :  std_logic;

	signal CLKEN_EN : std_logic := '0'; 


BEGIN

	uut: cpu PORT MAP(
		clk => clk,
		clken => clken,
		imdin => imdin,
		imaddrw => imaddrw,
		reset => reset,
		imwe => imwe,
		yout => yout,
		md => md,
		mq => mq,
		mwe => mwe
	);


-- setup clocks:
	
 	CLK <= not clk after 3759 ps; 
	process(CLKEN, CLKEN_EN) is
	begin
		if CLKEN_EN = '1' then
			CLKEN <= '0' after 7518 ps, '1' after 3*7518 ps;
		end if; 
	end process; 

	RESET <= '0' after 20 ns;
	
	mq <= "00000000000000000000000000000011";
	
	LOAD_CODE: process(CLK, RESET) is
		file filehandle: text open read_mode is "\\shannon.mwl.ai.mit.edu\hostFS\acquisition\development\network\asm\test.hex";
		variable datachunk: line; 				  
		variable instructionword: std_logic_vector(31 downto 0); 
		variable byteis : std_logic := '0';
	   variable addr: integer  := -1; 


  	begin
		if rising_edge(CLK) and RESET = '0' then
			if endfile(filehandle) then
				CLKEN_EN <= '1';
				imwe <= '0'; 
			else
				if byteis = '0' then
					readline(filehandle, datachunk);
					hread(datachunk, instructionword);
					imdin <= instructionword(23 downto 16) & 
							instructionword(7 downto 0) after 4 ns; 
					byteis := '1';
				elsif byteis = '1' then
					imdin <= instructionword(31 downto 24) & 
								instructionword(15 downto 8) after 4 ns; 
					byteis := '0'; 
	 			end if; 
				addr := addr + 1;
				imaddrw <= conv_std_logic_vector(addr, 9) after 4 ns; 
				imwe <= '1';  

		  	end if; 
 		end if; 
 	end process load_code;  


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
