library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity CPU is
    Port ( CLK : in std_logic;
           CLKEN : in std_logic;
           IMDIN : in std_logic_vector(15 downto 0);
           IMADDRW : in std_logic_vector(8 downto 0);
           IMWE : in std_logic;
           Y : out std_logic_vector(15 downto 0));
end CPU;

architecture Behavioral of CPU is
-- CPU.vhd -- Network System Central Processing Unit
--  This is the master file for all the CPU components. See CPU.ai
--  under docs/hardware/network for a good overview of what this does.

-- necessary signals


-- ALU component definition
	component ALU is
	    Port ( A : in std_logic_vector(15 downto 0);
	           B : in std_logic_vector(15 downto 0);
	           Y : out std_logic_vector(15 downto 0);
	           AF : in std_logic_vector(2 downto 0);
	           Z : out std_logic;
	           N : out std_logic;
	           CIN : in std_logic;
	           COUT : out std_logic);
	end component;


begin


end Behavioral;
