library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity SFR is
    Port ( CLK : in std_logic;
           CLKEN : in std_logic;
           Y : in std_logic_vector(31 downto 0);
           SFROUT : out std_logic_vector(31 downto 0);
           Rb : in std_logic_vector(5 downto 0));
end SFR;

architecture Behavioral of SFR is
-- SFR.vhd  -- Special Function Registers
-- Okay, this is a rather sad combination of all the SFRs, so I don't
-- expect it to look pretty. But it should at least modularize the code
-- well enough that the poor CPU doesn't die. 
--
-- This is our big way of getting data to/from our main peripheral
-- controllers, for PCI target r/w, FIFO setup, and debug/commands
-- as well as our way of accessing general memory, one crippling-slow
-- word at a time. 
-- 

begin

   SFR_input: process(CLK, CLKEN, Y, Rb) is
	begin
		if rising_edge(CLK) then
			if CLKEN = '1' then
				case Rb is 
					when "100000" => 
						Null;	-- zero register, obviously don't store value. 
					when others =>
						Null; 
				end case;
			end if;
		end if;
	end process SFR_input; 

	SFR_output: process(Rb) is
	begin
		-- just a big multiplexor
		case Rb is
			when "100000" =>
				SFROUT <= (others => '0');
			when others =>
				SFROUT <= (others => '0');
		end case;
	end process SFR_output; 


end Behavioral;
