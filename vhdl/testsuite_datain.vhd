library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testsuite_datain is
    Port ( CLK : in std_logic;
           DIN : in std_logic_vector(15 downto 0);
           NEWFRAME : in std_logic;
           ERR : out std_logic);
end testsuite_datain;

architecture Behavioral of testsuite_datain is
	signal lfsr, lfsrl, dinl : std_logic_vector(15 downto 0); 
	signal lnewframe, llnewframe, lerr : std_logic := '0'; 

begin

	clock: process(CLK) is
	begin
		if rising_edge(CLK) then
			lfsrl <= lfsr; 
			lnewframe <= NEWFRAME;
			llnewframe <= lnewframe;  
			ERR <= lerr;
			if llnewframe = '0' and lnewframe = '1' then
				lerr <= '0';
			else
				if lnewframe = '1' and dinl /= lfsr then
					lerr <= '1';
				end if; 
			end if; 
			  
			if lnewframe = '0' then
				lfsr <= (others => '0'); 
				
			else
				dinl <= DIN; 
					lfsr(0) <= lfsr(15) xnor lfsr(14) xnor
										lfsr(12) xnor lfsr(3); 
					lfsr(15 downto 1) <= lfsr(14 downto 0);
			end if; 

		end if; 
	end process clock;
					
end Behavioral;
