
-- VHDL Test Bench Created from source file memctl.vhd -- 21:04:30 03/26/2003
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

  library UNISIM;
use UNISIM.VComponents.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 
-- this testbench potentially has really really bad problems. 
-- 
-- but it's all we've got to work with, and hey, the behavioral is still valid


	COMPONENT memctl
	PORT(
		clk : IN std_logic;
		clk4x : IN std_logic;
		clk1 : IN std_logic;
		clk2 : IN std_logic;
		clk3 : IN std_logic;
		clk4 : IN std_logic;
		memclk: OUT std_logic; 
		clknum : IN std_logic_vector(1 downto 0);
		addr1 : IN std_logic_vector(21 downto 0);
		addr2 : IN std_logic_vector(21 downto 0);
		addr3 : IN std_logic_vector(21 downto 0);
		addr4 : IN std_logic_vector(21 downto 0);
		we1 : IN std_logic;
		we2 : IN std_logic;
		we3 : IN std_logic;
		we4 : IN std_logic;
		d1 : IN std_logic_vector(31 downto 0);
		d2 : IN std_logic_vector(31 downto 0);
		d3 : IN std_logic_vector(31 downto 0);
		d4 : IN std_logic_vector(31 downto 0);    
		dq : INOUT std_logic_vector(31 downto 0);      
		q1 : OUT std_logic_vector(31 downto 0);
		q2 : OUT std_logic_vector(31 downto 0);
		q3 : OUT std_logic_vector(31 downto 0);
		q4 : OUT std_logic_vector(31 downto 0);
		addr : OUT std_logic_vector(21 downto 0);
		we : OUT std_logic
		);
	END COMPONENT;
		component mt55l128l32p IS
		    GENERIC (
		        -- Constant parameters
		        addr_bits : INTEGER := 17;
		        data_bits : INTEGER := 32;

		        -- Timing parameters for -10 (100 Mhz)
		        tKHKH    : TIME    := 10.0 ns;
		        tKHKL    : TIME    :=  2.5 ns;
		        tKLKH    : TIME    :=  2.5 ns;
		        tKHQV    : TIME    :=  5.0 ns;
		        tAVKH    : TIME    :=  2.0 ns;
		        tEVKH    : TIME    :=  2.0 ns;
		        tCVKH    : TIME    :=  2.0 ns;
		        tDVKH    : TIME    :=  2.0 ns;
		        tKHAX    : TIME    :=  0.5 ns;
		        tKHEX    : TIME    :=  0.5 ns;
		        tKHCX    : TIME    :=  0.5 ns;
		        tKHDX    : TIME    :=  0.5 ns
		    );

		    -- Port Declarations
		    PORT (
		        Dq        : INOUT STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0);   -- Data I/O
		        Addr      : IN    STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0);   -- Address
		        Lbo_n     : IN    STD_LOGIC;                                   -- Burst Mode
		        Clk       : IN    STD_LOGIC;                                   -- Clk
		        Cke_n     : IN    STD_LOGIC;                                   -- Cke#
		        Ld_n      : IN    STD_LOGIC;                                   -- Adv/Ld#
		        Bwa_n     : IN    STD_LOGIC;                                   -- Bwa#
		        Bwb_n     : IN    STD_LOGIC;                                   -- BWb#
		        Bwc_n     : IN    STD_LOGIC;                                   -- Bwc#
		        Bwd_n     : IN    STD_LOGIC;                                   -- BWd#
		        Rw_n      : IN    STD_LOGIC;                                   -- RW#
		        Oe_n      : IN    STD_LOGIC;                                   -- OE#
		        Ce_n      : IN    STD_LOGIC;                                   -- CE#
		        Ce2_n     : IN    STD_LOGIC;                                   -- CE2#
		        Ce2       : IN    STD_LOGIC;                                   -- CE2
		        Zz        : IN    STD_LOGIC                                    -- Snooze Mode
		    );
		END component;


	SIGNAL clk :  std_logic := '0';
	SIGNAL clk4x :  std_logic := '0';
	SIGNAL clk1 :  std_logic;
	SIGNAL clk2 :  std_logic;
	SIGNAL clk3 :  std_logic;
	SIGNAL clk4 :  std_logic;
	SIGNAL memclk, memclkskew: std_logic; 
	SIGNAL clknum :  std_logic_vector(1 downto 0);
	SIGNAL addr1 :  std_logic_vector(21 downto 0);
	SIGNAL addr2 :  std_logic_vector(21 downto 0);
	SIGNAL addr3 :  std_logic_vector(21 downto 0);
	SIGNAL addr4 :  std_logic_vector(21 downto 0);
	SIGNAL we1 :  std_logic;
	SIGNAL we2 :  std_logic;
	SIGNAL we3 :  std_logic;
	SIGNAL we4 :  std_logic;
	SIGNAL d1 :  std_logic_vector(31 downto 0);
	SIGNAL d2 :  std_logic_vector(31 downto 0);
	SIGNAL d3 :  std_logic_vector(31 downto 0);
	SIGNAL d4 :  std_logic_vector(31 downto 0);
	SIGNAL q1 :  std_logic_vector(31 downto 0);
	SIGNAL q2 :  std_logic_vector(31 downto 0);
	SIGNAL q3 :  std_logic_vector(31 downto 0);
	SIGNAL q4 :  std_logic_vector(31 downto 0);
	SIGNAL addr :  std_logic_vector(21 downto 0);
	SIGNAL we :  std_logic;
	SIGNAL dq :  std_logic_vector(31 downto 0);
	signal state : integer := 0; 

	constant T_4Xperiod : time := 7.575757 ns; 
   constant T_inputwait : time := 2.0 ns; 


BEGIN


	uut: memctl PORT MAP(
		clk => clk,
		clk4x => clk4x,
		clk1 => clk1,
		clk2 => clk2,
		clk3 => clk3,
		clk4 => clk4,		
		memclk => memclk, 
		clknum => clknum,
		addr1 => addr1,
		addr2 => addr2,
		addr3 => addr3,
		addr4 => addr4,
		we1 => we1,
		we2 => we2,
		we3 => we3,
		we4 => we4,
		d1 => d1,
		d2 => d2,
		d3 => d3,
		d4 => d4,
		q1 => q1,
		q2 => q2,
		q3 => q3,
		q4 => q4,
		addr => addr,
		we => we,
		dq => dq
	);

	
	ZBT_RAM:  mt55l128l32p generic map (
		        -- Timing parameters for -7.5 (133 Mhz)
		        tKHKH => 7.5 ns,
		        tKHKL => 2.0 ns,
		        tKLKH => 2.0 ns,
		        tKHQV => 4.2 ns,
		        tAVKH => 1.7 ns,
		        tEVKH => 1.7 ns,
		        tCVKH => 1.7 ns,
		        tDVKH => 1.7 ns,
		        tKHAX => 0.5 ns,
		        tKHEX => 0.5 ns,
		        tKHCX => 0.5 ns,
		        tKHDX => 0.5 ns)
				port map (
		        Dq =>  DQ,   -- Data I/O
		        Addr  => ADDR(16 downto 0),   -- Address
		        Lbo_n  => '1',  -- Burst Mode
		        Clk    => memclkskew, -- Clk
		        Cke_n  => '0',  -- Cke#
		        Ld_n   => '0', -- Adv/Ld#
		        Bwa_n  => '0', -- Bwa#
		        Bwb_n  => '0', -- BWb#
		        Bwc_n  => '0', -- Bwc#
		        Bwd_n  => '0', -- BWd#
		        Rw_n   => WE, -- RW#
		        Oe_n   => '0', -- OE#
		        Ce_n   => '0', -- CE#
		        Ce2_n  => '0', -- CE2#
		        Ce2    => '1', -- CE2
		        Zz     => '0' -- Snooze Mode
				  ); 									
	
-- *** Test Bench - User Defined Section ***

   clk4x <= not clk4x after T_4Xperiod/2;
	 
	

	process(clk4x, state, memclk) is

		variable CLKnDELAY : time := 2 ns;	
		variable CLKNUMDELAY : time := 1.4 ns;	


	begin

	   memclkskew <= not memclk after 3 ns; 


		if rising_edge(clk4x) then
			if state = 3 then
				state <= 0;
			else
				state <= state + 1;
			end if; 
		end if; 

		if state = 0 or state = 1 then
			CLK <= '1';
		else
			CLK <= '0';
		end if; 

		
		if rising_edge(CLK4X) then
			if state = 0 then
				CLK1 <= '1' after CLKnDELAY;
			else
				CLK1 <= '0' after CLKnDELAY;
			end if; 
			if state = 1 then
				CLK2 <= '1' after CLKnDELAY;
			else
				CLK2 <= '0' after CLKnDELAY;
			end if; 
			if state = 2 then
				CLK3 <= '1' after CLKnDELAY;
			else
				CLK3 <= '0' after CLKnDELAY;
			end if; 
			if state = 3 then
				CLK4 <= '1' after CLKnDELAY;
			else
				CLK4 <= '0' after CLKnDELAY;
			end if; 


		end if;    

	 	if rising_edge(CLK4X) then
			if state = 0 then
				CLKNUM <= "00" after CLKNUMDELAY;
			elsif state = 1 then
				CLKNUM  <= "01" after CLKNUMDELAY;
			elsif state = 2 then
				CLKNUM  <= "10" after CLKNUMDELAY;
			elsif state = 3 then
				CLKNUM  <= "11" after CLKNUMDELAY;
			end if;
     		end if; 

	 end process; 
	


	-- here's where we do the big data-read-in
	-- We read a cycle consisting of 4 ADDRs, 4 WEs, 4 Ds, and 
	-- have a specific setup time for each of them prior to their
	-- respective CLK pulses. 
	-- 
	-- we have four separate text files for this testing. 
	--    each line has a number for the address, a numerical valule,
	--    and a 1 to read and 0 to write. i.e. 
	-- 	000001  0FFECDAB 0  -- to write FFECDAB to location 01
	--    000001  00000000 1  -- to read-back whatever is in 01

   -- these are updated T_inputwait rising_edge(CLK4x) && CLKn = 1,
	--    

   
	reading_line1: process(CLK4X, CLK1) is
		file filehandle: text open read_mode is "memctl_testbench_line1.dat";
		variable datachunk: line; 				  
		variable ADDR: std_logic_vector(23 downto 0); 
		variable DATA:  std_logic_vector(31 downto 0);
		variable RWCMD : integer range 0 to 1; 

  	begin
		if rising_edge(CLK4X) then
			if CLK1 = '1' then
				readline(filehandle, datachunk);
				hread(datachunk, ADDR);
				hread(datachunk, DATA);
				read(datachunk, RWCMD);
				
				ADDR1 <= ADDR(21 downto 0) after 	T_inputwait	;
				D1 <= DATA after 	T_inputwait	;
				if RWCMD = 1 then
					We1 <= '1' after T_inputwait; 
				else
					We1 <= '0' after T_inputwait;
				end if; 
 			end if; 
 		end if; 
 	end process reading_line1; 


	reading_line2: process(CLK4X, CLK1) is
		file filehandle: text open read_mode is "memctl_testbench_line2.dat";
		variable datachunk: line; 				  
		variable ADDR: std_logic_vector(23 downto 0); 
		variable DATA:  std_logic_vector(31 downto 0);
		variable RWCMD : integer range 0 to 1; 

  	begin
		if rising_edge(CLK4X) then
			if CLK2 = '1' then
				readline(filehandle, datachunk);
				hread(datachunk, ADDR);
				hread(datachunk, DATA);
				read(datachunk, RWCMD);
				
				ADDR2 <= ADDR(21 downto 0) after 	T_inputwait	;
				D2 <= DATA after 	T_inputwait	;
				if RWCMD = 1 then
					We2 <= '1' after T_inputwait; 
				else
					We2 <= '0' after T_inputwait;
				end if; 
 			end if; 
 		end if; 
 	end process reading_line2; 



	reading_line3: process(CLK4X, CLK1) is
		file filehandle: text open read_mode is "memctl_testbench_line3.dat";
		variable datachunk: line; 				  
		variable ADDR: std_logic_vector(23 downto 0); 
		variable DATA:  std_logic_vector(31 downto 0);
		variable RWCMD : integer range 0 to 1; 

  	begin
		if rising_edge(CLK4X) then
			if CLK3 = '1' then
				readline(filehandle, datachunk);
				hread(datachunk, ADDR);
				hread(datachunk, DATA);
				read(datachunk, RWCMD);
				
				ADDR3 <= ADDR(21 downto 0) after 	T_inputwait	;
				D3 <= DATA after 	T_inputwait	;
				if RWCMD = 1 then
					We3 <= '1' after T_inputwait; 
				else
					We3 <= '0' after T_inputwait;
				end if; 
 			end if; 
 		end if; 
 	end process reading_line3; 



	reading_line4: process(CLK4X, CLK1) is
		file filehandle: text open read_mode is "memctl_testbench_line4.dat";
		variable datachunk: line; 				  
		variable ADDR: std_logic_vector(23 downto 0); 
		variable DATA:  std_logic_vector(31 downto 0);
		variable RWCMD : integer range 0 to 1; 

  	begin
		if rising_edge(CLK4X) then
			if CLK4 = '1' then
				readline(filehandle, datachunk);
				hread(datachunk, ADDR);
				hread(datachunk, DATA);
				read(datachunk, RWCMD);
				
				ADDR4 <= ADDR(21 downto 0) after 	T_inputwait	;
				D4 <= DATA after 	T_inputwait	;
				if RWCMD = 1 then
					We4 <= '1' after T_inputwait; 
				else
					We4 <= '0' after T_inputwait;
				end if; 
 			end if; 
 		end if; 
 	end process reading_line4; 









   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
