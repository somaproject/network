library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity logical is
    Port ( A : in std_logic_vector(31 downto 0);
           B : in std_logic_vector(31 downto 0);
           AF : in std_logic_vector(1 downto 0);
           logicout : out std_logic_vector(31 downto 0));
end logical;

architecture Behavioral of logical is

begin
	process(A, B, AF) is 
	begin
	 		-- now the logic section
		case AF(1 downto 0) is
			when "00" =>
			   logicout <= NOT B;
			when "01"  =>
				logicout <= B(15 downto 0) & B(31 downto 16);
			when "10" =>
				logicout <= A AND B;
			when "11" =>
				logicout <= A OR B;
			when others =>
				logicout <= B;
		end case; 
		

	end process; 


end Behavioral;
