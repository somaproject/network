library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 
use std.textio.all; 

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity test_NoBLSRAM is
    Generic (  FILEIN : string := "SRAM_in.dat"; 
    			FILEOUT : string := "SRAM_out.dat"); 
    Port ( CLK : in std_logic;
           DQ : inout std_logic_vector(31 downto 0);
           ADDR : in std_logic_vector(16 downto 0);
           WE : in std_logic;
           RESET : in std_logic;
		 SAVE : in std_logic);
end test_NoBLSRAM;

architecture Behavioral of test_NoBLSRAM is
-- another ram simulation.  filein is our input file, fileout is
-- where we save to. filein is read on startup, fileout is 
-- saved. This is ram designed to behave like Cypresses NoBL 
-- (i.e. micron ZBT) sync SRAM
   subtype word is std_logic_vector(31 downto 0);  

   type storage_array is 
   	array ( 0 to 131071) of word;
    signal IN_SIG, OUT_SIG, T_ENABLE:  std_logic;
   component IOBUF
      port (I, T: in std_logic; 
            O: out std_logic; 
            IO: inout std_logic);
   end component;   
   signal din, dout: word := (others => '0');

	signal lladdr, laddr, addr_now : std_logic_vector(16 downto 0) := (others => '0');
	signal llwe, lwe, we_now : std_logic := '1'; 
begin

   buffs: for i in 0 to 31 generate
	  buffs_inst: iobuf port map (
	        I=> dout(i),
		   O => din(i),
		   IO => DQ(i), 
		   T => T_ENABLE); 

   end generate; 
   main: process is

   	type load_file_type is file of word;
	type save_file_type is file of word;
	file load_file : text open read_mode is FILEIN;
	file save_file : text open write_mode is FILEOUT;
	variable WL, RL : line; 

	variable index : natural; 
	variable dword : bit_vector(31 downto 0);
	variable SRAM : storage_array := (others => "00000000000000000000000000000000"); 
	variable numaddress : integer := 0; 



   begin
     wait until falling_edge(RESET);
	   index:= 0;
	   for i in 0 to 131071 loop
	       SRAM(i) := (others => '0'); -- zero sram
	   end loop;
	    
	   while not endfile(load_file) loop
		 readline(load_file, RL);
		 read(RL, dword); 
		 SRAM(index) := to_x01(dword); 
		 index := index + 1;
	   end loop; 
	 

     -- falling edge starts cmd; read in 8 bits, then decide what to do
	while 0 < 1 loop 
		wait until rising_edge(CLK) or rising_edge(SAVE);
		     if rising_edge(SAVE) then
			   for i in 0 to 131071 loop 
			   	 write (WL, to_bitvector(SRAM(i)));
				 writeline(save_file, WL);
			   end loop; 
			end if; 		 
			if rising_edge(CLK) then

			     
			     

			    numaddress := to_integer(unsigned(laddr));
			    dout <= SRAM(numaddress) after 2 ns;

				T_ENABLE <= (not lwe) after 2 ns; 

			    if llwe = '0' then -- a write
			       --wait for 2 ns; 
			       SRAM(to_integer(unsigned(lladdr))) := din; 			        
			         
			    end if;

			end if; 
	end loop; 

	wait; 

   end process main; 
   clock: process(CLK) is
   begin
   	if rising_edge(CLK) then
	   		   llwe <= lwe; 
			    lwe <= WE;
			    
			    lladdr <= laddr;
			    laddr <= ADDR;

	end if; 

   end process clock; 
end Behavioral;
