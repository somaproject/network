library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

 entity regfile is 
 port (CLK  : in std_logic;
 		CLKEN : in std_logic; 
		RESET : in std_logic;  
 		WE   : in std_logic; 
 		ADDRA   : in std_logic_vector(4 downto 0) := "00000";
		ADDRB	  : in std_logic_vector(4 downto 0) := "00000";  
 		ADDRW   : in std_logic_vector(4 downto 0) := "00000"; 
 		DATAA   : out std_logic_vector(31 downto 0); 
 		DATAB  : out std_logic_vector(31 downto 0); 
 		DATAW  : in std_logic_vector(31 downto 0)); 
 end regfile;
 
 architecture syn of regfile is 
-- This is our register file for our CPU. Note it is copied nearly
-- verbatim from the suggested xilinx code. 
--
--  The register file is 32 x 16, with an independent write port
-- and two read ports. The write address and first read address (a1)
-- are always the same, but a2 can be whatever we want it to be. 

 type ram_type is array (31 downto 0) of std_logic_vector (31 downto 0); 
 signal RAM : ram_type := (others => "00000000000000000000000000000000"); 
 
 begin 
 process (clk, we, CLKEN, DATAW) 
 begin 
 	if (clk'event and clk = '1') then  
 		if (we = '0' and CLKEN = '1' and RESET = '0')  then 
 			RAM(conv_integer(ADDRW)) <= DATAW; 
 		end if; 
 	end if; 
 end process;
 
 DATAB <= RAM(conv_integer(ADDRB)); 
 DATAA <= RAM(conv_integer(ADDRA)); 
 
 end syn;