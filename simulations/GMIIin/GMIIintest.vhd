
-- VHDL Test Bench Created from source file gmiiin.vhd -- 19:39:01 10/26/2004
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

ENTITY GMIIintest IS
END GMIIintest;

ARCHITECTURE behavior OF GMIIintest IS 

	COMPONENT gmiiin
	PORT(
		CLK : IN std_logic;
		RX_CLK : IN std_logic;
		RX_ER : IN std_logic;
		RX_DV : IN std_logic;
		RXD : IN std_logic_vector(7 downto 0);
		NEXTF : IN std_logic;          
		ENDFOUT : OUT std_logic;
		EROUT : OUT std_logic;
		OFOUT : OUT std_logic;
		VALID : OUT std_logic;
		DOUT : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic := '0';
	SIGNAL RX_CLK :  std_logic := '0';
	SIGNAL RX_ER :  std_logic := '0';
	SIGNAL RX_DV :  std_logic := '0';
	SIGNAL RXD :  std_logic_vector(7 downto 0) := (others =>'0');
	SIGNAL NEXTF :  std_logic;
	SIGNAL ENDFOUT :  std_logic;
	SIGNAL EROUT :  std_logic;
	SIGNAL OFOUT :  std_logic;
	SIGNAL VALID :  std_logic;
	SIGNAL DOUT :  std_logic_vector(7 downto 0);

BEGIN

	uut: gmiiin PORT MAP(
		CLK => CLK,
		RX_CLK => RX_CLK,
		RX_ER => RX_ER,
		RX_DV => RX_DV,
		RXD => RXD,
		NEXTF => NEXTF,
		ENDFOUT => ENDFOUT,
		EROUT => EROUT,
		OFOUT => OFOUT,
		VALID => VALID,
		DOUT => DOUT
	);

	CLK <= not CLK after 4 ns; 
	RX_CLK <= not RX_CLK after 3.98 ns;  -- slightly faster

	
	-- input data:
	inputdata: process is
		file gmiifile: text; 
		variable L : line; 
		variable dvin : integer := 0;
		variable erin : integer := 0; 
		variable rxdin : std_logic_vector(7 downto 0);

	begin					 	
		file_open(gmiifile, "gmii.dat", read_mode); 
		while not endfile(gmiifile) loop
			wait until rising_edge(RX_CLK); 
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
		wait; 

		--assert false
			--report "End of simulation"
			--severity failure;   
	end process; 

	-- output check data:
	output: process is
		file outfile: text; 
		variable L : line; 
		variable din : std_logic_vector(15 downto 0);

	begin					 	
		file_open(outfile, "output.dat", read_mode); 
		while not endfile(outfile) loop
			NEXTF <= '1';	
			wait until rising_edge(CLK); 
			NEXTF <= '0';
			readline(outfile, L);
			for i in 0 to 100000 loop
				wait until rising_edge(CLK);
				if VALID = '1' then		
					hread(L, din);
					if DIN(15) = '1' and ENDFOUT /= '1' then
						report "Error in detecting correct end of frame";
					else 
						if din(7 downto 0) /= DOUT
							and ENDFOUT = '0'  then
							report "error in DIN"; 
						end if;
					end if;   
					if ENDFOUT = '1' then
						exit;
					end if;  
				end if; 
			end loop; 
		end loop; 
		wait; 
		--assert false
			--report "End of simulation"
			--severity failure;   
	end process; 

END;
