library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testsuite_memory is
    Port ( CLK : in std_logic;
           MD : out std_logic_vector(31 downto 0);
           MQ : in std_logic_vector(31 downto 0);
           MAQ : out std_logic_vector(16 downto 0);
           MAD : out std_logic_vector(16 downto 0);
			  ERR : out std_logic; 
           CLKEN1 : in std_logic;
			  CLKEN2 : in std_logic);
end testsuite_memory;

architecture Behavioral of testsuite_memory is
	signal addrcnt, addrcntl, addrcntll: std_logic_vector(16 downto 0) := (others => '0'); 
	signal datacnt : std_logic_vector(31 downto 0) := (others => '0');
	signal dataw1, dataw2, dataw3, dataw4, dataw5, dataw6, dataw7 : 
		std_logic_vector(31 downto 0) := (others => '0');
	signal llerr, lerr : std_logic; 
begin

   main: process(CLK) is
	begin
		if rising_edge(CLK) then
			if CLKEN1 = '1' then
				addrcnt <= addrcnt + 1;  
				datacnt <= datacnt + 1; 
				dataw1 <= datacnt(31 downto 5) & datacnt(4 downto 0); 
				addrcntl <= addrcnt; 
			end if; 

			if CLKEN2 = '1' then
			   addrcntll <= addrcntl;
				if  (MQ = dataw4) then
					llerr <= '0';
				else
					llerr <= '1';
				end if;
				dataw2 <= dataw1;
				dataw3 <= dataw2;
				dataw4 <= dataw3;
				dataw5 <= dataw4; 
			end if; 

			lerr <= llerr;
			ERR <= lerr; 

		end if ;
	end process main; 

	MD <= datacnt(31 downto 5) &  datacnt(4 downto 0);  						 
	MAD <= addrcnt;
	MAQ <= addrcntll; 

end Behavioral;
