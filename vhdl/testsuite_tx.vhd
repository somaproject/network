library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity testsuite_tx is
    Port ( CLK : in std_logic;
	 		  RESET : in std_logic; 
           TX_EN : out std_logic;
           TXD : out std_logic_vector(7 downto 0));
end testsuite_tx;

architecture Behavioral of testsuite_tx is

	signal ramaddr : std_logic_vector(8 downto 0); 
	signal counter : integer range 0 to 16000000 := 0; 
	signal ramout, ltxd : std_logic_vector(7 downto 0);
	signal llltx, lltx, ltx : std_logic; 
	constant framelen : integer := 20; 
	constant maxcnt : integer := 100; 
	component RAMB4_S8
		generic (
	       INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000403020100";
	       INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
			 );
	  port (DI     : in STD_LOGIC_VECTOR (7 downto 0);
	        EN     : in STD_logic;
	        WE     : in STD_logic;
	        RST    : in STD_logic;
	        CLK    : in STD_logic;
	        ADDR   : in STD_LOGIC_VECTOR (8 downto 0);
	        DO     : out STD_LOGIC_VECTOR (7 downto 0)); 
	end component;	 




begin
	process(clk) is
	begin
		 if rising_edge(CLK) then
			 if counter = maxcnt then 
				 counter <= 0;
				 lltx <= '1';
			 else
			 	 counter <= counter + 1; 
			 end if;

			 if counter = (framelen - 1) then
			 	 llltx <= '0';
			 end if; 
			 lltx <= llltx;
			 ltx <= lltx; 
			 TX_EN <= ltx;
			 ltxd <= ramout; 
			 TXD <= ltxd; 
		 end if; 
   end process; 


	rom : RAMB4_S8 generic map (
			INIT_00 => X"0000000000000000000000000000000000000000000000000000050403020100",
			INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
			INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000")
			port map (
				DI => "00000000",
				EN => '1',
				WE => '0',
				RST => RESET,
				CLK => CLK,
				ADDR => ramaddr,
				DO => ramout); 
  ramaddr <= std_logic_vector(to_unsigned(counter, 9)); 


end Behavioral;