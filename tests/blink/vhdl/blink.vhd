library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;

entity blink is
  port ( CLKIN : in std_logic;
         LEDACT   : out std_logic;
         LEDTX    : out std_logic;
         LEDRX    : out std_logic;
         LED100   : out std_logic;
         LED1000  : out std_logic;
         LEDDPX   : out std_logic;
         LEDPOWER : out std_logic;
         PHYRESET : out std_logic); 
end blink;


architecture Behavioral of blink is

  signal counter : std_logic_vector(25 downto 0) := (others => '0');
  
begin  -- Behavioral

  process(CLKIN)
    begin
      if rising_edge(CLKIN) then
        counter <= counter + 1;

        LEDPOWER <= counter(22);
        if counter(25 downto 23) = "000" then
          LEDACT <= '1';
        else
          LEDACT <= '0';
        end if;
        
        if counter(25 downto 23) = "001" then
          LEDTX <= '1';
        else
          LEDTX <= '0';
        end if;
        
        if counter(25 downto 23) = "010" then
          LEDRX <= '1';
        else
          LEDRX <= '0';
        end if;
        
        if counter(25 downto 23) = "011" then
          LED100 <= '1';
        else
          LED100 <= '0';
        end if;
        
        if counter(25 downto 23) = "100" then
          LED1000 <= '1';
        else
          LED1000 <= '0';
        end if;
        
        if counter(25 downto 23) = "101" then
          LEDDPX <= '1';
        else
          LEDDPX <= '0';
        end if;
        
        PHYRESET <='0';
        
      end if;
    end process; 

end Behavioral;
