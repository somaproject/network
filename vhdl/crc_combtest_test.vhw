-- C:\DESKTOP\NETWORK\VHDL
-- VHDL Test Bench created by
-- HDL Bencher 5.1i
-- Sun Aug 24 21:21:20 2003
-- 
-- Notes:
-- 1) This testbench has been automatically generated from
--   your Test Bench Waveform
-- 2) To use this as a user modifiable testbench do the following:
--   - Save it as a file with a .vhd extension (i.e. File->Save As...)
--   - Add it to your project as a testbench source (i.e. Project->Add Source...)
-- 

LIBRARY  IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT CRC_combtest
		PORT (
			CLK : in  std_logic;
			CRC : out  std_logic_vector (31 DOWNTO 0);
			DATA : in  std_logic_vector (7 DOWNTO 0);
			RESET : in  std_logic;
			CRCN : out  std_logic_vector (31 DOWNTO 0);
			CRCR : out  std_logic_vector (31 DOWNTO 0);
			CRCRN : out  std_logic_vector (31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL CLK : std_logic;
	SIGNAL CRC : std_logic_vector (31 DOWNTO 0);
	SIGNAL DATA : std_logic_vector (7 DOWNTO 0);
	SIGNAL RESET : std_logic;
	SIGNAL CRCN : std_logic_vector (31 DOWNTO 0);
	SIGNAL CRCR : std_logic_vector (31 DOWNTO 0);
	SIGNAL CRCRN : std_logic_vector (31 DOWNTO 0);

BEGIN
	UUT : CRC_combtest
	PORT MAP (
		CLK => CLK,
		CRC => CRC,
		DATA => DATA,
		RESET => RESET,
		CRCN => CRCN,
		CRCR => CRCR,
		CRCRN => CRCRN
	);

	PROCESS -- clock process for CLK,
	BEGIN
		CLOCK_LOOP : LOOP
		CLK <= transport '0';
		WAIT FOR 1500 ps;
		CLK <= transport '1';
		WAIT FOR 1000 ps;
		WAIT FOR 4000 ps;
		CLK <= transport '0';
		WAIT FOR 3500 ps;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS   -- Process for CLK
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_CRC(
			next_CRC : std_logic_vector (31 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (CRC /= next_CRC) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ps CRC="));
				write(TX_LOC, CRC);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_CRC);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_CRCN(
			next_CRCN : std_logic_vector (31 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (CRCN /= next_CRCN) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ps CRCN="));
				write(TX_LOC, CRCN);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_CRCN);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_CRCR(
			next_CRCR : std_logic_vector (31 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (CRCR /= next_CRCR) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ps CRCR="));
				write(TX_LOC, CRCR);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_CRCR);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_CRCRN(
			next_CRCRN : std_logic_vector (31 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (CRCRN /= next_CRCRN) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ps CRCRN="));
				write(TX_LOC, CRCRN);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_CRCRN);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		BEGIN
		-- --------------------
		RESET <= transport '1';
		DATA <= transport std_logic_vector'("00000000"); --0
		-- --------------------
		WAIT FOR 10000 ps; -- Time=10000 ps
		RESET <= transport '0';
		DATA <= transport std_logic_vector'("00000000"); --0
		-- --------------------
		WAIT FOR 40000 ps; -- Time=50000 ps
		DATA <= transport std_logic_vector'("00000000"); --0
		-- --------------------
		WAIT FOR 922500 ps; -- Time=972500 ps
		-- --------------------

		IF (TX_ERROR = 0) THEN 
			write(TX_OUT,string'("No errors or warnings"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Simulation successful (not a failure).  No problems detected. "
				SEVERITY FAILURE;
		ELSE
			write(TX_OUT, TX_ERROR);
			write(TX_OUT, string'(
				" errors found in simulation"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Errors found during simulation"
				SEVERITY FAILURE;
		END IF;
	END PROCESS;
END testbench_arch;

CONFIGURATION CRC_combtest_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END CRC_combtest_cfg;
