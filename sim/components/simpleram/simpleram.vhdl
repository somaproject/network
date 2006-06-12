library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all; 
use  ieee.numeric_std.all; 
use std.TextIO.ALL; 

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simpleram is
    Generic (addrwidth : integer := 15;
    			filename : string := "test.dat"; 
    		   
		   datawidth : integer := 32); 
    Port ( CLK : in std_logic;
           RESET : in std_logic;
           ADOUT : in std_logic_vector((addrwidth-1) downto 0);
           DOUT : out std_logic_vector(datawidth-1 downto 0);
		 ADIN: in std_logic_vector((addrwidth-1) downto 0);
		 DIN : in std_logic_vector(datawidth-1 downto 0);
		 WE : in std_logic;
		 SAVE : in std_logic); 
end simpleram;

architecture Behavioral of simpleram is
-- simpleram.vhdl -- a very simple synchronous ram implementation
-- we essentially use a single giant process as variables are much
-- cheaper than signals
-- data is simply stored as:
-- int addr int data
-- 

begin

   process(CLK, RESET) is
   	file datafile : text;
	variable L : line; 
	variable indata : std_logic_vector(datawidth-1 downto 0);
	variable inaddr: std_logic_vector((addrwidth-1) downto 0); 
	type ramtype is array(2**addrwidth-1 downto 0) of integer ; 
	variable ram : ramtype := (others => 0); 
   begin
   	if falling_edge(RESET) then
		-- load into ram
		file_open(datafile, filename, read_mode); 
		ram := (others => 0); 
		while not endfile(datafile) loop 
			readline(datafile, L); 
			hread(L, inaddr);
			hread(L, indata); 
			--ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata));
			ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata)); 
		end loop; 
		file_close(datafile); 
	else
		if rising_edge(CLK) then
			
			DOUT <= std_logic_vector(to_signed(ram(to_integer(unsigned(ADOUT))), datawidth)); 
		end if; 
	end if;  
					 
   end process; 


end Behavioral;
