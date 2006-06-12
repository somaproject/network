library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all; 
use  ieee.numeric_std.all; 
use std.TextIO.ALL; 

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GMII is
    Port ( MDIO : inout std_logic;
           MDC : in std_logic;
           DONE : out std_logic);
end GMII;

architecture Behavioral of GMII is

	type regtype is array(0 to 31) of
	integer range 0 to 65535;
	signal regs: regtype;
	signal dl: std_logic_vector(15 downto 0);  
	signal preamble : integer := 0;
	signal cmd : std_logic_vector(1 downto 0) := (others => '0'); 
	signal myaddr: std_logic_vector(4 downto 0) := (others => '0'); 
	signal d : std_logic_vector(15 downto 0) 
		:= (others => '0'); 
begin

	process is

	begin
		while 1 = 1 loop
		
			MDIO <= 'Z'; 
			-- preamble code
			while preamble < 31 loop
				wait until rising_edge(MDC);
				if MDIO = '1' then
					preamble <= preamble + 1;
				else
					preamble <= 0;
				end if; 
			end loop; 
    	
			wait until rising_edge(MDC);
			exit when MDIO /= '0';
			wait until rising_edge(MDC);
			exit when MDIO /= '1';
		
			-- get the cmd
			wait until rising_edge(MDC);
			cmd(1) <= MDIO; 
			wait until rising_edge(MDC);
			cmd(0) <= MDIO;

			-- py addr
			wait until rising_edge(MDC);
			exit when MDIO /= '0';
			wait until rising_edge(MDC);
			exit when MDIO /= '0';
			wait until rising_edge(MDC);
			exit when MDIO /= '0';
			wait until rising_edge(MDC);
			exit when MDIO /= '0';
			wait until rising_edge(MDC);

			-- reg addr
			wait until rising_edge(MDC);
			myaddr(4) <= MDIO;
			wait until rising_edge(MDC);
			myaddr(3) <= MDIO;
			wait until rising_edge(MDC);
			myaddr(2) <= MDIO;
			wait until rising_edge(MDC);
			myaddr(1) <= MDIO;
			wait until rising_edge(MDC);
			myaddr(0) <= MDIO;
			wait for 5 ns; 
			-- turnaround?
			if cmd = "10" then
				d <=  std_logic_vector(to_unsigned(regs(to_integer(unsigned(myaddr))), 16)); 
				
				-- this is a read:
				--wait until rising_edge(MDC);
				MDIO <= '1';
				wait until rising_edge(MDC);
				MDIO <= '0'; 
				for i in 15 downto 0 loop
				    wait until rising_edge(MDC); 
				    MDIO <= d(i); 
				end loop; 
				wait until rising_edge(MDC);
				MDIO <= 'Z'; 

			elsif cmd = "01" then
				-- this is a write:
				wait until rising_edge(MDC);
				MDIO <= 'Z';
				wait until rising_edge(MDC);
				MDIO <= 'Z';

				for i in 15 downto 0 loop
				    wait until rising_edge(MDC); 
				    d(i) <= MDIO; 
				end loop; 
				wait for 10 ns; 
				regs(to_integer(unsigned(myaddr))) <= to_integer(unsigned(d)); 

			else	
				exit when cmd = "11" or cmd = "00";
		     end if; 


	    	end loop; 

	end process;



end Behavioral;
