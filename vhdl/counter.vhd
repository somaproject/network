library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter is
  
  port (
    CLK : in std_logic;
    CNTRST : in std_logic;
    INC: in std_logic;
    CNT : out std_logic_vector(31 downto 0)
    ) ;

end counter;

architecture Behavioral of counter is
  signal cntrstl : std_logic := '0';

  signal incl : std_logic := '0';

  signal lcnt : std_logic_vector(31 downto 0) := (others => '0');

  
begin  -- Behavioral

  main: process(CLK)
    begin
      if rising_edge(CLK) then
        cntrstl <= CNTRST;
        incl <= INC;

        CNT <= lcnt;

        if cntrstl = '1' then
          lcnt <= (others => '0');
        else
          if incl = '1' then
            lcnt <= lcnt + 1; 
            
          end if;
        end if;
        
      end if;

    end process main; 
  

end Behavioral;
