
-- VHDL Test Bench Created from source file txoutput.vhd -- 15:57:19 08/24/2003
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
use ieee.std_logic_unsigned.all; 


ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT txoutput
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		qd : IN std_logic_vector(31 downto 0);
		bp : IN std_logic_vector(15 downto 0);
		clken : IN std_logic;          
		ad : OUT std_logic_vector(15 downto 0);
		txd : OUT std_logic_vector(7 downto 0);
		frametx : out std_logic; 
		txen : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic := '0';
	SIGNAL reset :  std_logic := '1';
	SIGNAL qd :  std_logic_vector(31 downto 0);
	SIGNAL ad :  std_logic_vector(15 downto 0);
	SIGNAL bp :  std_logic_vector(15 downto 0);
	SIGNAL txd :  std_logic_vector(7 downto 0);
	SIGNAL txen :  std_logic;
	SIGNAL frametx: std_logic; 
	SIGNAL clken :  std_logic := '0';
	subtype word is std_logic_vector(31 downto 0); 
	signal qd1, qd2, qd3, qd4, qd5 : std_logic_vector(31 downto 0);
	signal ram_test : integer := 1; 
     type ram_type is array (0 to 65535) of word; 
BEGIN

	uut: txoutput PORT MAP(
		clk => clk,
		reset => reset,
		qd => qd,
		ad => ad,
		bp => bp,
		txd => txd,
		txen => txen,
		frametx => frametx, 
		clken => clken
	);


   clk <= not clk after 4 ns; 
   reset <= '0' after 20 ns; 


   -- main counter proc
   process(CLK, RESET) is
      variable counter : integer := 1;
   begin
      if RESET = '1' then 
	 	counter := 0;
	 else
	      if rising_edge(CLK) then
		 	 counter := counter + 1;
		 end if;
	 end if; 
	 if counter mod 4 = 0 then 
	    CLKEN <= '1' after 2 ns;
	 else
	    clken <= '0' after 2 ns;
	 end if; 		
   end process;

   -- memory process
   process is
   begin
     if ram_test = 0 then
	   bp <= X"0013";
	elsif ram_test = 1 then
	   bp <= X"0013";
	   wait for 5 us;
	   bp <= X"0018";
	end if; 
	wait;

   end process; 

   process(CLK, RESET) is
      variable RAM: ram_type; 


   begin

   	 if falling_edge(RESET) then
	   if ram_test = 0 then 
	   	-- two-packet test

		    RAM(0) := X"0000003C";
		    RAM(1) := X"003F0000";
		    RAM(2) := X"00000001";
		    RAM(3) := X"0400003F";
		    RAM(4) := X"00000101";
		    RAM(5) := X"00000000";
		    RAM(6) := X"00000000";
		    RAM(7) := X"00000000";
		    RAM(8) := X"00000000";
		    RAM(9) := X"00000000";
		    RAM(10) := X"00000000";
		    RAM(11) := X"00000000";
		    RAM(12) := X"00000000";
		    RAM(13) := X"00000000";
		    RAM(14) := X"00000000";
		    RAM(15) := X"00000000";
		    RAM(16) := X"0000003C";
		    RAM(17) := X"00000000";
		    RAM(18) := X"00000000";
		    RAM(19) := X"00000000";
		    RAM(20) := X"00000000";
		    RAM(21) := X"00000000";
		    RAM(22) := X"00000000";
		    RAM(23) := X"00000000";
		    RAM(24) := X"00000000";
		    RAM(25) := X"00000000";
		    RAM(26) := X"00000000";
		    RAM(27) := X"00000000";
		    RAM(28) := X"00000000";
		    RAM(29) := X"00000000";
		    RAM(30) := X"00000000";
		    RAM(31) := X"00000000";
		    RAM(32) := X"00000000";
		    RAM(33) := X"00000000";
		    RAM(34) := X"00000000";
		elsif ram_test = 1 then
		    -- sequential increasing packets test

		    RAM(0) := X"0000000C"; --pkt
		    RAM(1) := X"03020100";
		    RAM(2) := X"07060504";
		    RAM(3) := X"0B0A0908";
		    RAM(4) := X"0000000D"; --pkt
		    RAM(5) := X"03020100";
		    RAM(6) := X"07060504";
		    RAM(7) := X"0B0A0908";
		    RAM(8) := X"00000D0C"; 
		    RAM(9) := X"0000000E"; --pkt
		    RAM(10) := X"03020100";
		    RAM(11) := X"07060504";
		    RAM(12) := X"0B0A0908";
		    RAM(13) := X"000E0D0C";
		    RAM(14) := X"0000000F";--pkt
		    RAM(15) := X"03020100";
		    RAM(16) := X"07060504";
		    RAM(17) := X"0B0A0908";
		    RAM(18) := X"0F0E0D0C";
		    RAM(19) := X"00000010"; --pkt
		    RAM(20) := X"03020100";
		    RAM(21) := X"07060504";
		    RAM(22) := X"0B0A0908";
		    RAM(23) := X"0F0E0D0C";
		    RAM(24) := X"00000000";
		    RAM(25) := X"00000000";
		    RAM(26) := X"00000000";
		    RAM(27) := X"00000000";
		    RAM(28) := X"00000000";
		    RAM(29) := X"00000000";
		    RAM(30) := X"00000000";
		    RAM(31) := X"00000000";
		    RAM(32) := X"00000000";
		    RAM(33) := X"00000000";
		    RAM(34) := X"00000000";
		 end if; 
	 end if; 

	 if rising_edge(CLK) then
		 if clken = '1' then
		    qd1 <= RAM(conv_integer(ad)) after 2 ns; 
		 end if; 
		    qd2 <= qd1 after 2 ns; 
		    qd3 <= qd2 after 2 ns;
		    qd4 <= qd3 after 2 ns;
		    qd5 <= qd4 after 2 ns;
		    qd <= qd4 after 2 ns; 
	 end if;
   end process; 

END;
