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
         SCS       : out std_logic;
         LEDPOWER  : out std_logic;
         LED100    : out std_logic;
         LED1000   : out std_logic;
         LEDACT    : out std_logic;
         LEDTX     : out std_logic;
         LEDRX     : out std_logic;
         LEDDPX    : out std_logic

         );
end sigtest;

architecture Behavioral of sigtest is

  signal data : std_logic_vector(15 downto 0) := (others => '0');
  signal nf   : std_logic                     := '0';
  signal newf : std_logic                     := '0';
  signal s1   : std_logic                     := '0';
  signal s2   : std_logic                     := '0';

  signal ledcnt : std_logic_vector(21 downto 0) := (others => '0');

  signal ledsreg : std_logic_vector(7 downto 0) := "00000001";

begin  -- Behavioral

  PHYRESET <= '0';

  main : process(CLKIOIN)
  begin
    if rising_edge(CLKIOIN) then

      ledcnt <= ledcnt + 1;

      if ledcnt = "00" & X"00000" then
        ledsreg  <= ledsreg(6 downto 0) & ledsreg(7);
        LEDPOWER <= ledsreg(0);
        LEDACT   <= ledsreg(1);
        LEDTX    <= ledsreg(2);
        LEDRX    <= ledsreg(3);
        LEDDPX   <= ledsreg(4);
        LED100   <= ledsreg(5);
        LED1000  <= ledsreg(6);

      end if;


      data <= DIN;
      nf   <= NEXTFRAME;
      newf <= NEWFRAME;
      s1   <= SCLK;
      s2   <= SIN;

      DOUT   <= data;
      DOUTEN <= nf;
      DINEN  <= newf;
      SOUT   <= s1;
      SCS    <= s2;


    end if;
  end process;

end Behavioral;
