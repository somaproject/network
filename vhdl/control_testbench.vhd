
-- VHDL Test Bench Created from source file control.vhd -- 16:26:22 09/26/2003
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

use ieee.std_logic_textio.ALL; 
use std.textio.all; 


ENTITY control_testbench IS
END control_testbench;

ARCHITECTURE behavior OF control_testbench IS 

	COMPONENT control
	PORT(
		clk : IN std_logic;
		clksl : IN std_logic;
		sclk : IN std_logic;
		scs : IN std_logic;
		sin : IN std_logic;
		txf : IN std_logic;
		rxf : IN std_logic;
		txfifowerr : IN std_logic;
		rxfifowerr : IN std_logic;
		rxphyerr : IN std_logic;
		rxoferr : IN std_logic;
		rxcrcerr : IN std_logic;          
		sout : OUT std_logic;
		ledact : OUT std_logic;
		ledtx : OUT std_logic;
		ledrx : OUT std_logic;
		led100 : OUT std_logic;
		led1000 : OUT std_logic;
		leddpx : OUT std_logic;
		phyreset : OUT std_logic;
		rxbcast : OUT std_logic;
		rxmcast : OUT std_logic;
		rxucast : OUT std_logic;
		macaddr : OUT std_logic_vector(47 downto 0)
		);
	END COMPONENT;

	SIGNAL clk :  std_logic := '0';
	SIGNAL clksl :  std_logic := '0';
	SIGNAL sclk :  std_logic := '0';
	SIGNAL scs :  std_logic := '1';
	SIGNAL sin :  std_logic := '0';
	SIGNAL sout :  std_logic := '0';
	SIGNAL ledact :  std_logic;
	SIGNAL ledtx :  std_logic;
	SIGNAL ledrx :  std_logic;
	SIGNAL led100 :  std_logic;
	SIGNAL led1000 :  std_logic;
	SIGNAL leddpx :  std_logic;
	SIGNAL phyreset : std_logic;
	SIGNAL txf :  std_logic := '0';
	SIGNAL rxf :  std_logic := '0';
	SIGNAL txfifowerr :  std_logic := '0';
	SIGNAL rxfifowerr :  std_logic := '0';
	SIGNAL rxphyerr :  std_logic := '0';
	SIGNAL rxoferr :  std_logic := '0';
	SIGNAL rxcrcerr :  std_logic := '0';
	SIGNAL rxbcast :  std_logic;
	SIGNAL rxmcast :  std_logic;
	SIGNAL rxucast :  std_logic;
	SIGNAL macaddr :  std_logic_vector(47 downto 0);


     signal datain: std_logic_vector(31 downto 0) := (others => '0');

BEGIN

	uut: control PORT MAP(
		clk => clk,
		clksl => clksl,
		sclk => sclk,
		scs => scs,
		sin => sin,
		sout => sout,
		ledact => ledact,
		ledtx => ledtx,
		ledrx => ledrx,
		led100 => led100,
		led1000 => led1000,
		leddpx => leddpx,
		phyreset => phyreset,
		txf => txf,
		rxf => rxf,
		txfifowerr => txfifowerr,
		rxfifowerr => rxfifowerr,
		rxphyerr => rxphyerr,
		rxoferr => rxoferr,
		rxcrcerr => rxcrcerr,
		rxbcast => rxbcast,
		rxmcast => rxmcast,
		rxucast => rxucast,
		macaddr => macaddr
	);



   clk <= not clk after 4 ns;
   clksl <= not clksl after 8 ns; 
   sclk <= not sclk after 0.5 us;


   process(clk) is
   	variable count : integer := 0;

   begin
     if rising_edge(clk) then
	   count := count + 1; 

	   if count mod 1000 = 0 then
	      rxf <= '1';
	   else
	   	 rxf <= '0';
	   end if; 
     end if; 
   end process; 


   process(clksl) is
   	variable count : integer := 0;

   begin
     if rising_edge(clksl) then
	   count := count + 1; 
     end if; 
   end process; 

   commands: process is
   -- the command-and-control file has the following format:
   --
   -- c/w r/w addr data
   -- where 
   --    c/w: 1 if command, 0 if wait
   --    r/w: if a command, 0 = read, 1 = write
   --    addr: if a command, the address (hex)
   --          if a wait, the number of sclk ticks to wait
   --    data: if a write command, the 16-bit hex command
   -- 
   -- 
	file read_file : text open read_mode is "testvectors/commands.dat";
	
	variable L : line;

   	variable count : integer := 0;
	variable cmd_cw, cmd_rw : std_logic := '0';
	variable cmd_data : std_logic_vector(31 downto 0) := (others => '0');
	
	variable outdelay : time := 100 ns; 

	variable cmd_addr : std_logic_vector(7 downto 0) := (others => '0');
	variable cmd_datain: std_logic_vector(31 downto 0) := (others => '0');

	
   begin
     while 0 <1 loop
	 	if not endfile(read_file) then 
		   readline(read_file, L);
		   read(L, cmd_cw);
		   read(L, cmd_rw);
		   hread(L, cmd_addr);
		   if cmd_cw = '0' then
		      -- wait
			for i in 1 to to_integer(unsigned(cmd_addr)) loop
			   wait until rising_edge(sclk); 
			end loop; 
		   elsif cmd_cw = '1' then
			 -- command
			 hread(L, cmd_data); 
			 -- regardless, we need to put the address out there

			 scs <= '0' after outdelay; 

			 for i in 7 downto 0 loop
				if i = 7 then
				   sin <= cmd_rw after outdelay; 
				elsif i <7 then
				   sin <= cmd_addr(i) after outdelay; 
				end if; 
				wait until rising_edge(sclk); 
			 end loop; 

			 if cmd_rw = '1' then
			 	-- it's a write!
				 for i in 31 downto 0 loop
				     sin <= cmd_data(i) after outdelay; 
					wait until rising_edge(sclk); 
				 end loop; 
			 else
				 for i in 31 downto 0 loop
					wait until rising_edge(sclk);
					datain(i) <= sout;  
				 end loop; 
			 end if; 

			 scs <= '1' after outdelay; 
	        end if;
		else
		   wait;
		end if; 
	end loop;   

   end process; 


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
