library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIFOcheck is
    Port ( CLK : in std_logic;
           BP : in std_logic_vector(15 downto 0);
           FBBP : in std_logic_vector(15 downto 0);
           FIFOFULL : out std_logic);
end FIFOcheck;

architecture Behavioral of FIFOcheck is
-- FIFOCHECK.VHD -- system to make sure we don't have overwrite
-- issues with our fifo. This is really simple: we just make
-- sure the BP is at least two maximum frame sizes behind
-- the FBBP. 
   signal bpl, fbbpl : std_logic_vector(15 downto 0) := (others =>'0');
   signal diff, diffl : std_logic_vector(15 downto 0) := (others => '0');

begin
   main: process(CLK) is
   begin
   	if rising_edge(CLK) then
	   bpl <= BP;
	   fbbpl <= FBBP; 
	   diff <= fbbpl - bpl ;
	   diffl <= diff;  
	   if (diffl > 8192) or (diffl =0) then
	   	 FIFOFULL <= '0';
	   else
	   	 FIFOFULL <= '1';
	   end if; 


	end if; 
   end process main;

end Behavioral;
