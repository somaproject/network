library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in std_logic_vector(15 downto 0);
           B : in std_logic_vector(15 downto 0);
           Y : out std_logic_vector(15 downto 0);
           AF : in std_logic_vector(2 downto 0);
           Z : out std_logic;
           N : out std_logic;
           CIN : in std_logic;
           COUT : out std_logic);
end ALU;

architecture Behavioral of ALU is
-- ALU.vhd -- general purpose Arithmetic Logic unit for CPU system.
-- Performs the following 16-bit operations, based on AF inputs 
-- AF:        Operation: 
--	000		  Y = A + B
-- 001		  Y = A - B
-- 010		  Y = A AND B
-- 011		  Y = A OR B
-- 100 		  Y = NOT B
-- 101		  Y = B
-- 110		  Y = 0 & B[15:1]
-- 111		  Y = B[14:0] & 0



begin

   main: process(A, B, AF, CIN) is
	begin
		case AF is
			when "000" =>
				Y <= A + B;
			when "001" =>
				Y <= A - B;
			when "010" =>
				Y <= A AND B;
			when "011" =>
				Y <=  A OR B;
			when "100" =>
				Y <= NOT B;
			when "101" =>
				Y <= B(14 downto 0) & '0';
			when "110" =>
				Y <= '0' & B(15 downto 1);
			when "111" =>
				Y <= B; 
			when others =>	 -- necessary for case syntax. 
				Y <= A + B; 
		end case; 
		


	end process main; 






end Behavioral;
