library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity sourcefilter is
  
  port (
    CLK   : in std_logic;
    DIN : in std_logic_vector(31 downto 0); 
    MACLW : in std_logic; 
    MACMW : in std_logic; 
    MACHW : in std_logic;
    BCASTW : in std_logic;
    MCASTW : in std_logic;
    UCASTW : in std_logic;
    ALLFW : in std_logic;
    MACADDR : out std_logic_vector(47 downto 0); 
    RXMCAST: out std_logic;
    RXBCAST : out std_logic;
    RXUCAST : out std_logic;
    RXALLF : out std_logic
    );

end sourcefilter;

architecture Behavioral of sourcefilter is

begin  -- Behavioral

  main : process  (CLK)
    begin
      if rising_edge(CLK) then
        if MACLW = '1'  then
          MACADDR(15 downto 0) <= DIN(15 downto 0); 
        end if;

        if MACMW = '1'  then
          MACADDR(31 downto 16) <= DIN(15 downto 0); 
        end if;

        if MACHW = '1'  then
          MACADDR(47 downto 32) <= DIN(15 downto 0); 
        end if;

        if BCASTW = '1'  then
          RXBCAST <= DIN(0); 
        end if;

        if MCASTW = '1'  then
          RXMCAST <= DIN(0); 
        end if;

        if UCASTW = '1'  then
          RXUCAST <= DIN(0); 
        end if;

        if ALLFW = '1' then
          --RXALLF <= DIN(0);             -- debugging
          
        end if;
        RXALLF <= '1';
        
      end if;
    end process main; 

end Behavioral;
