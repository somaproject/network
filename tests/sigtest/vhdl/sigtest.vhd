library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;

entity sigtest is
  port ( CLKIOIN   : in  std_logic;
         DOUT      : out std_logic_vector(15 downto 0);
         DOUTEN    : out std_logic;
         NEWFRAME  : in  std_logic;
         NEXTFRAME : in  std_logic;
         DINEN     : out std_logic;
         DIN       : in  std_logic_vector(15 downto 0);
         PHYRESET  : out std_logic;
         SCLK      : in  std_logic;
         SIN       : in  std_logic;
         SOUT      : out std_logic;
         SCS       : out std_logic);
end sigtest;

architecture Behavioral of sigtest is

  signal data : std_logic_vector(15 downto 0) := (others => '0');
  signal nf   : std_logic                     := '0';
  signal newf : std_logic                     := '0';
  signal s1   : std_logic                     := '0';
  signal s2   : std_logic                     := '0';




begin  -- Behavioral

  PHYRESET <= '0';

  main : process(CLKIOIN)
  begin
    if rising_edge(CLKIOIN) then
      data <= DIN;
      nf <= NEXTFRAME;
      newf <= NEWFRAME;
      s1 <= SCLK;
      s2 <= SIN;

      DOUT <= data;
      DOUTEN <= nf;
      DINEN <= newf;
      SOUT <= s1;
      SCS <= s2;
      
      
    end if;
  end process;

end Behavioral;
