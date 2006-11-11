library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity memtest is
  port ( CLKIN     : in    std_logic;
         MA        : out   std_logic_vector(16 downto 0);
         MD        : inout std_logic_vector(31 downto 0);
         MCLK      : out   std_logic;
         MWE       : out   std_logic;
         LEDPOWER  : out   std_logic;
         LEDLINK   : out   std_logic;
         LEDTX     : out   std_logic;
         LEDRX     : out   std_logic;
         LED100    : out   std_logic;
         LED1000   : out   std_logic;
         RESET     : in    std_logic;
         MOE       : out   std_logic;
         INTCLKOUT : out   std_logic);
end memtest;

architecture Behavioral of memtest is

  signal addr1, addr2, addr3, addr4 :
    std_logic_vector(14 downto 0) := (others => '0');
  signal addr1a, addr2a, addr3a, addr4a :
    std_logic_vector(16 downto 0) := (others => '0');
  signal d1, d2, d3, d4, q1, q2, q3, q4 :
    std_logic_vector(31 downto 0) := (others => '0');

  signal we1, we2, we3, we4, clken1, clken2, clken3, clken4 :
    std_logic := '0';
  signal err1, err2, err3, err4 : std_logic
              := '0';

  signal cecnt : integer range 0 to 3 := 0;
  signal clk   : std_logic            := '0';

  component memory
    port ( CLK     : in    std_logic;
           RESET   : in    std_logic;
           DQEXT   : inout std_logic_vector(31 downto 0);
           WEEXT   : out   std_logic;
           ADDREXT : out   std_logic_vector(16 downto 0);
           ADDR1   : in    std_logic_vector(16 downto 0);
           ADDR2   : in    std_logic_vector(16 downto 0);
           ADDR3   : in    std_logic_vector(16 downto 0);
           ADDR4   : in    std_logic_vector(16 downto 0);
           D1      : in    std_logic_vector(31 downto 0);
           D2      : in    std_logic_vector(31 downto 0);
           D3      : in    std_logic_vector(31 downto 0);
           D4      : in    std_logic_vector(31 downto 0);
           Q1      : out   std_logic_vector(31 downto 0);
           Q2      : out   std_logic_vector(31 downto 0);
           Q3      : out   std_logic_vector(31 downto 0);
           Q4      : out   std_logic_vector(31 downto 0);
           WE1     : in    std_logic;
           WE2     : in    std_logic;
           WE3     : in    std_logic;
           WE4     : in    std_logic;
           CLKEN1  : out   std_logic;
           CLKEN2  : out   std_logic;
           CLKEN3  : out   std_logic;
           CLKEN4  : out   std_logic);
  end component;

  component test1
    generic (STARTDATA : in  std_logic_vector(31 downto 0);
             STARTADDR : in  std_logic_vector(14 downto 0));
    port ( CLK         : in  std_logic;
           CE          : in  std_logic;
           WE          : out std_logic;
           D           : out std_logic_vector(31 downto 0);
           Q           : in  std_logic_vector(31 downto 0);
           ADDR        : out std_logic_vector(14 downto 0);
           err         : out std_logic;
           RESET       : in  std_logic);
  end component;

  component test2
    generic (STARTDATA : in  std_logic_vector(31 downto 0);
             STARTADDR : in  std_logic_vector(14 downto 0));
    port ( CLK         : in  std_logic;
           CE          : in  std_logic;
           WE          : out std_logic;
           D           : out std_logic_vector(31 downto 0);
           Q           : in  std_logic_vector(31 downto 0);
           ADDR        : out std_logic_vector(14 downto 0);
           err         : out std_logic;
           RESET       : in  std_logic);
  end component;

  component test3
    generic (STARTDATA : in  std_logic_vector(31 downto 0);
             STARTADDR : in  std_logic_vector(14 downto 0));
    port ( CLK         : in  std_logic;
           CE          : in  std_logic;
           WE          : out std_logic;
           D           : out std_logic_vector(31 downto 0);
           Q           : in  std_logic_vector(31 downto 0);
           ADDR        : out std_logic_vector(14 downto 0);
           ERR         : out std_logic;
           RESET       : in  std_logic);
  end component;


  component BUFG
    port (
      I                     : in  std_logic;
      O                     : out std_logic
      );
  end component;
  --
  component DCM
    --
    generic (
      DLL_FREQUENCY_MODE    :     string  := "HIGH";
      DUTY_CYCLE_CORRECTION :     boolean := false;
      CLKOUT_PHASE_SHIFT    :     string  := "FIXED";
      PHASE_SHIFT           :     integer := 100;
      STARTUP_WAIT          :     boolean := false
      );
    --

    port ( CLKIN : in  std_logic;
           CLKFB : in  std_logic;
           PSEN  : in  std_logic;
           PSCLK : in  std_logic;
           RST   : in  std_logic;
           CLK0  : out std_logic
           );
  end component;

  signal clk1x_w, clk0_w : std_logic;
begin
  clk      <= CLKIN;
  MOE      <= '0';
  LEDPOWER <= '1';
  
  MCLK <= not clk;
  mem : memory port map(
    CLK     => clk,
    RESET   => reset,
    DQEXT   => MD,
    WEEXT   => MWE,
    ADDREXT => MA,
    ADDR1   => addr1a,
    ADDR2   => addr2a,
    ADDR3   => addr3a,
    ADDR4   => addr4a,
    D1      => d1,
    D2      => d2,
    D3      => d3,
    D4      => d4,
    Q1      => q1,
    Q2      => q2,
    Q3      => q3,
    Q4      => q4,
    we1     => we1,
    WE2     => we2,
    WE3     => we3,
    WE4     => we4,
    CLKEN1  => clken1,
    CLKEN2  => clken2,
    CLKEN3  => clken3,
    CLKEN4  => clken4);


  test_1 : test2 generic map
    (STARTDATA => X"00001100",
     STARTADDR => "001000000000001")
    port map(
      CLK      => clk,
      CE       => clken1,
      WE       => we1,
      D        => d1,
      Q        => q1,
      ADDR     => addr1,
      err      => err1,
      RESET    => RESET);

  test_2 : test1 generic map
    (STARTDATA => X"30FFFF00",
     STARTADDR => "110010001111000")
    port map(
      CLK      => clk,
      CE       => clken2,
      WE       => we2,
      D        => d2,
      Q        => q2,
      ADDR     => addr2,
      err      => err2,
      RESET    => RESET);


  test_3 : test2 generic map
    (STARTDATA => X"2ac45121",
     STARTADDR => "001001000110010")
    port map(
      CLK      => clk,
      CE       => clken3,
      WE       => we3,
      D        => d3,
      Q        => q3,
      ADDR     => addr3,
      err      => err3,
      RESET    => RESET);


  test_4 : test3 generic map
    (STARTDATA => X"00000000",
     STARTADDR => "000000000000000")
    port map(
      CLK      => clk,
      CE       => clken4,
      WE       => we4,
      D        => d4,
      Q        => q4,
      ADDR     => addr4,
      err      => err4,
      RESET    => RESET);


  addr1a <= "00" & addr1;
  addr2a <= "01" & addr2;
  addr3a <= "10" & addr3;
  addr4a <= "11" & addr4;


  main : process (CLK, RESET)

    variable ecnt1, ecnt1l, ecnt1ll : integer range 0 to 1250000 := 0;
    variable ecnt2, ecnt2l, ecnt2ll : integer range 0 to 1250000 := 0;
    variable ecnt3, ecnt3l, ecnt3ll : integer range 0 to 1250000 := 0;
    variable ecnt4, ecnt4l, ecnt4ll : integer range 0 to 1250000 := 0;

  begin
    if rising_edge(clk) then
      ecnt1l  := ecnt1;
      ecnt2l  := ecnt2;
      ecnt3l  := ecnt3;
      ecnt4l  := ecnt4;
      ecnt1ll := ecnt1l;
      ecnt2ll := ecnt2l;
      ecnt3ll := ecnt3l;
      ecnt4ll := ecnt4l;

      if ecnt1ll /= 0 then
        ecnt1   := ecnt1 - 1;
      else
        if err1 = '1' then
          ecnt1 := 1250000;
        end if;
      end if;

      if ecnt1ll /= 0 then
        LEDLINK <= '1';
      else
        LEDLINK <= '0';
      end if;


      if ecnt2ll /= 0 then
        ecnt2   := ecnt2 - 1;
      else
        if err2 = '1' then
          ecnt2 := 1250000;
        end if;
      end if;

      if ecnt2ll /= 0 then
        LEDTX <= '1';
      else
        LEDTX <= '0';
      end if;


      if ecnt3ll /= 0 then
        ecnt3   := ecnt3 - 1;
      else
        if err3 = '1' then
          ecnt3 := 1250000;
        end if;
      end if;

      if ecnt3ll /= 0 then
        LEDRX <= '1';
      else
        LEDRX <= '0';
      end if;


      if ecnt4ll /= 0 then
        ecnt4   := ecnt4 - 1;
      else
        if err4 = '1' then
          ecnt4 := 1250000;
        end if;
      end if;

      if ecnt4ll /= 0 then
        LED100 <= '1';
      else
        LED100 <= '0';
      end if;

      if err1 = '1' or err2 = '1' or err3 = '1' or err4 = '1' then
        LED1000 <= '1';
      else
        LED1000 <= '0';
      end if;


    end if;
  end process main;



end Behavioral;
