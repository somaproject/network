
-- VHDL Test Bench Created from source file phystatus.vhd -- 15:24:42 10/04/2003
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

ENTITY phystatus_PHYstatus_testbench_vhd_tb IS
END phystatus_PHYstatus_testbench_vhd_tb;

ARCHITECTURE behavior OF phystatus_PHYstatus_testbench_vhd_tb IS 

	COMPONENT phystatus
	PORT(
		CLK : IN std_logic;
		PHYDIN : IN std_logic_vector(15 downto 0);
		PHYADDR : IN std_logic_vector(5 downto 0);
		PHYADDRR : IN std_logic;
		PHYADDRW : IN std_logic;
		RESET : IN std_logic;    
		MDIO : INOUT std_logic;      
		PHYDOUT : OUT std_logic_vector(15 downto 0);
		PHYADDRSTATUS : OUT std_logic;
		PHYSTAT : OUT std_logic_vector(31 downto 0);
		MDC : OUT std_logic
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic := '0';
	SIGNAL PHYDIN :  std_logic_vector(15 downto 0);
	SIGNAL PHYDOUT :  std_logic_vector(15 downto 0);
	SIGNAL PHYADDRSTATUS :  std_logic;
	SIGNAL PHYADDR :  std_logic_vector(5 downto 0);
	SIGNAL PHYADDRR :  std_logic;
	SIGNAL PHYADDRW :  std_logic;
	SIGNAL PHYSTAT :  std_logic_vector(31 downto 0);
	SIGNAL RESET :  std_logic := '1';
	SIGNAL MDIO :  std_logic;
	SIGNAL MDC :  std_logic;

BEGIN

	uut: phystatus PORT MAP(
		CLK => CLK,
		PHYDIN => PHYDIN,
		PHYDOUT => PHYDOUT,
		PHYADDRSTATUS => PHYADDRSTATUS,
		PHYADDR => PHYADDR,
		PHYADDRR => PHYADDRR,
		PHYADDRW => PHYADDRW,
		PHYSTAT => PHYSTAT,
		RESET => RESET,
		MDIO => MDIO,
		MDC => MDC
	);

	reset <= '0' after 300 ns; 

	clk <= not clk after 16 ns; 

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
