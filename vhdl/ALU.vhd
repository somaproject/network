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

	signal adderout, logicout, shiftout, Yint: std_logic_vector(15 downto 0);

	component ADDER is
    Port ( A : in std_logic_vector(15 downto 0);
           B : in std_logic_vector(15 downto 0);
           Y : out std_logic_vector(15 downto 0);
			  OP: in std_logic; 
           CIN : in std_logic;
           COUT : out std_logic);
    end component;
		  

begin
   -- special flags
	Z <= '1' when Yint = "0000000000000000" else '0';
	N <= '1' when Yint(15) = '1' else '0'; 


	-- instantiate the actual adder
	adder_inst: ADDER port map (
					A => A,
					B => B,
					Y => adderout,
					OP => AF(0),
					CIN => CIN,
					COUT => COUT);  

   main: process(A, B, AF, CIN) is
	begin
	-- new approach: do three things, only care about output on one of them.

		
		
		-- now the logic section
		case AF(1 downto 0) is
			when "00" =>
			   logicout <= NOT B;
			when "01"  =>
				logicout <= B;
			when "10" =>
				logicout <= A AND B;
			when "11" =>
				logicout <= A OR B;
			when others =>
				logicout <= B;
		end case; 
		
		-- and a shifter 
		if AF(0) = '0' then 
			shiftout <= '0' & B(15 downto 1); 
		else
		 	shiftout <= B(14 downto 0) & '0';
		end if; 

		case AF(2 downto 1) is
			when "00" =>
			   Yint <= adderout; 
			when "01"  =>
				Yint <= logicout; 
			when "10" =>
				Yint <= logicout; 
			when "11" =>
				Yint <= shiftout;
			when others =>
			   Yint <= logicout;
		end case; 	

		Y <= Yint; 

	end process main; 






end Behavioral;
