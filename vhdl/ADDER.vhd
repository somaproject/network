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
           COUT : out std_logic;
           OFL : out std_logic);
end ADDER;

architecture Behavioral of ADDER is
-- basic adder, so we can mess with the syntax such that the 
-- synthesizer inferrs it to be small. 

begin
	adding: process(A,B,OP, CIN) is
	begin
		if OP = '0' then 
			Y <= A + B + CIN;
		else 
			Y <= A + (not B ) + CIN;
		end if; 


	end process adding; 



end Behavioral;
