library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all; 
use  ieee.numeric_std.all; 
use std.TextIO.ALL; 

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;


entity GMIIin is
    Port ( CLK : in std_logic;
           RX_CLK : in std_logic;
           RX_ER : in std_logic;
           RX_DV : in std_logic;
           RXD : in std_logic_vector(7 downto 0);
           NEXTF : in std_logic;
           ENDFOUT : out std_logic;
           EROUT : out std_logic;
           OFOUT : out std_logic;
		 VALID : out std_logic; 
           DOUT : out std_logic_vector(7 downto 0));
end GMIIin;

architecture Behavioral of GMIIin is

begin
	-- strictly behavioral
	process is	 	
		file datafile : text; 
		variable L : line;
		variable indata : std_logic_vector(15 downto 0)	
			:= (others => '0');

	begin
		file_open(datafile, "gmiiin.0.dat", read_mode); 
		while not endfile(datafile) loop 
			readline(datafile, L); 
			wait until rising_edge(CLK) and NEXTF = '1';
			while not (indata(8) = '1' and indata(9) = '1') loop 
				hread(L, indata);
				DOUT <= indata(7 downto 0);
				VALID <= indata(8);
				ENDFOUT <= indata(9);
				EROUT <= indata(10);
				OFOUT <= indata(11); 
				wait until rising_edge(clk); 
			end loop; 
			indata(8) := '0'; 
		end loop; 
		wait; 								  	

	end process; 


end Behavioral;
