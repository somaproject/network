
-- VHDL Test Bench Created from source file mii.vhd -- 08:54:58 09/30/2003
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

ENTITY MII_testbench IS
END MII_testbench;

ARCHITECTURE behavior OF MII_testbench IS 

	COMPONENT mii
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		din : IN std_logic_vector(15 downto 0);
		addr : IN std_logic_vector(4 downto 0);
		start : IN std_logic;
		rw : IN std_logic;    
		mdio : INOUT std_logic;      
		mdc : OUT std_logic;
		dout : OUT std_logic_vector(15 downto 0);
		done : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic := '0';
	SIGNAL reset :  std_logic := '1';
	SIGNAL mdio :  std_logic;
	SIGNAL mdc :  std_logic;
	SIGNAL din :  std_logic_vector(15 downto 0);
	SIGNAL dout :  std_logic_vector(15 downto 0);
	SIGNAL addr :  std_logic_vector(4 downto 0);
	SIGNAL start :  std_logic;
	SIGNAL rw :  std_logic;
	SIGNAL done :  std_logic;

BEGIN

	uut: mii PORT MAP(
		clk => clk,
		reset => reset,
		mdio => mdio,
		mdc => mdc,
		din => din,
		dout => dout,
		addr => addr,
		start => start,
		rw => rw,
		done => done
	);

   reset <= '0' after 40 ns; 

   clk <= not clk after 16 ns; 

-- *** Test Bench - User Defined Section ***
   tb : PROCESS(clk) is
      variable count: integer := 0; 
   BEGIN

	if rising_edge(clk) then
	    count := count + 1; 


		if count = 100 then 
			start <= '1';
		else
			start <= '0';
		end if; 

		addr <= "00111";
		din <= "0000000100100011";

		rw <= '1';

	end if; 
	
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
