library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDER is
    Port ( A : in std_logic_vector(15 downto 0);
           B : in std_logic_vector(15 downto 0);
           Y : out std_logic_vector(15 downto 0);
			  OP: in std_logic; 
           CIN : in std_logic;
           COUT : out std_logic);
end ADDER;

architecture Behavioral of ADDER is
-- basic adder, so we can mess with the syntax such that the 
-- synthesizer inferrs it to be small. 
	signal Atmp, Btmp, Ytmp: std_logic_vector(16 downto 0); 
begin
	adding: process(A,B,OP, CIN) is
	begin

		Atmp <= '0' & A;
		Btmp <= '0' & B;
		  
		if OP = '0' then 
			Ytmp <= Atmp + Btmp + CIN;
		else 
			Ytmp <= Atmp + (not Btmp ) + CIN;
		end if; 

		COUT <= Ytmp(16);
		Y <= Ytmp(15 downto 0);	 


	end process adding; 



end Behavioral;
