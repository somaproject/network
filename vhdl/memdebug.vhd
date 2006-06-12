library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memdebug is
    Port ( CLK : in std_logic;
           CLKEN : in std_logic; 
			  DOUT : out std_logic_vector(31 downto 0); 
			  ADDR : out std_logic_vector(16 downto 0));
end memdebug;

architecture Behavioral of memdebug is
	signal lcnt, cnt : std_logic_vector(15 downto 0) := (others => '0'); 

begin
	main: process(clk, clken) is
	begin
		if rising_edge(clk) then
		  if CLKEN = '1' then 
		  	if(cnt /= X"FFFF") then
				cnt <= cnt +  1; 
			end if; 
			lcnt <= cnt; 
			ADDR <= '0' & cnt; 
			DOUT <= X"FF" & cnt & X"FF";
		  end if; 
		end if; 
	end process; 

end Behavioral;
