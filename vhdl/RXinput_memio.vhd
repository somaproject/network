library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXinput_memio is
    Port ( CLK : in std_logic;
    		 RESET : in std_logic;
           CEOUT : out std_logic;
           ENDF : in std_logic;
           EMPTY : in std_logic;
           DATA : in std_logic_vector(7 downto 0);
           MA : out std_logic_vector(15 downto 0);
		 MD : out std_logic_vector(31 downto 0); 
           BPOUT : out std_logic_vector(15 downto 0);
           CRCERR : out std_logic;
           OFERR : out std_logic;
           PHYERR : out std_logic;
           RXF : out std_logic);
end RXinput_memio;

architecture Behavioral of RXinput_memio is
-- RXINPUT_MEMIO.VHD -- memory input/output on the internal-clock
-- side of the RX FIFO. 
   signal brdy, drdy, ceforce : std_logic := '0';
   
   signal brdyl, drdyl, lceforce : std_logic := '0';
   signal datal : std_logic_vector(7 downto 0) := (others => '0');

begin
   clock: process(RESET, CLK) is
   begin
   	if RESET = '1' then
	   
	else
	   if rising_edge(CLK) then
	   	 datal <= data; 
	      md(7 downto 0) <= datal; 
		 crcerr <= drdy;
		 oferr <= brdy;
		  

	   end if; 
	end if; 
   end process clock;
   CEOUT <= ceforce or brdy;        
 		  brdy <= (not ENDF) and drdy;
           drdy <= not EMPTY;
    

  


   -- dummy outs

   --lceforce <= reset; 

  
end Behavioral;
