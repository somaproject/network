
-- VHDL Test Bench Created from source file mii.vhd -- 23:37:25 10/16/2004
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

ENTITY miitest IS
END miitest;

ARCHITECTURE behavior OF miitest IS 

	COMPONENT mii
	PORT(
		CLK : IN std_logic;
		CLKSLEN : IN std_logic;
		RESET : IN std_logic;
		DIN : IN std_logic_vector(15 downto 0);
		ADDR : IN std_logic_vector(4 downto 0);
		START : IN std_logic;
		RW : IN std_logic;    
		MDIO : INOUT std_logic;      
		MDC : OUT std_logic;
		DOUT : OUT std_logic_vector(15 downto 0);
		DONE : OUT std_logic
		);
	END COMPONENT;

	component GMII is
	    Port ( MDIO : inout std_logic;
	           MDC : in std_logic;
	           DONE : out std_logic);
	end component;

	SIGNAL CLK :  std_logic := '0';
	SIGNAL CLKSLEN :  std_logic := '0';
	SIGNAL RESET :  std_logic := '1';
	SIGNAL MDIO :  std_logic;
	SIGNAL MDC :  std_logic;
	SIGNAL DIN :  std_logic_vector(15 downto 0);
	SIGNAL DOUT :  std_logic_vector(15 downto 0);
	SIGNAL ADDR :  std_logic_vector(4 downto 0);
	SIGNAL START :  std_logic;
	SIGNAL RW :  std_logic;
	SIGNAL DONE :  std_logic;

BEGIN

	uut: mii PORT MAP(
		CLK => CLK,
		CLKSLEN => CLKSLEN,
		RESET => RESET,
		MDIO => MDIO,
		MDC => MDC,
		DIN => DIN,
		DOUT => DOUT,
		ADDR => ADDR,
		START => START,
		RW => RW,
		DONE => DONE
	);

	gmii_uut : gmii port map (
		MDIO => MDIO,
		MDC => MDC, 
		DONE => open); 

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


	main : process is
	begin
		DIN <= X"0000"; 
		ADDR <= "00000"; 
		START <= '0';
		RW <= '0'; 

		wait for 10 us; 
		DIN <= X"ABCD";
		ADDR <= "00000";
		RW <= '1'; 
		wait until rising_edge(CLK) and CLKSLEN = '1';
		START <= '1';
		wait until rising_edge(CLK) and CLKSLEN = '1';
    		START <= '0';
		wait until rising_edge(CLK) 
			and CLKSLEN = '1'
			and DONE = '1'; 

		wait for 10 us; 
		DIN <= X"1234";
		ADDR <= "00100";
		RW <= '1'; 
		wait until rising_edge(CLK) and CLKSLEN = '1';
		START <= '1';
		wait until rising_edge(CLK) and CLKSLEN = '1';
    		START <= '0';
		wait until rising_edge(CLK) 
			and CLKSLEN = '1'
			and DONE = '1'; 

		wait for 10 us; 
		DIN <= X"1234";
		ADDR <= "00000";
		RW <= '0'; 
		wait until rising_edge(CLK) and CLKSLEN = '1';
		START <= '1';
		wait until rising_edge(CLK) and CLKSLEN = '1';
    		START <= '0';
		wait until rising_edge(CLK) 
			and CLKSLEN = '1'
			and DONE = '1'; 
		if DOUT /= X"ABCD" then
			report "Error reading data at address 0"; 
		end if; 

		wait for 10 us; 
		DIN <= X"7777";
		ADDR <= "00100";
		RW <= '0'; 
		wait until rising_edge(CLK) and CLKSLEN = '1';
		START <= '1';
		wait until rising_edge(CLK) and CLKSLEN = '1';
    		START <= '0';
		wait until rising_edge(CLK) 
			and CLKSLEN = '1'
			and DONE = '1'; 
		if DOUT /= X"1234" then
			report "Error reading data at address 0"; 
		end if;

		wait ; 

	end process main; 

END;
