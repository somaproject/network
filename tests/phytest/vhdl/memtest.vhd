library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;


entity memtest is

  port (
    CLKIN    : in    std_logic;
    RESET    : in    std_logic;
    MD       : inout std_logic_vector(31 downto 0);
    MWE      : out   std_logic;
    MA       : out   std_logic_vector(16 downto 0);
    MCLK     : out   std_logic;
    PHYRESET : out   std_logic;
    LEDPOWER : out   std_logic;
    LED100   : out   std_logic;
    LED1000  : out   std_logic;
    LEDACT   : out   std_logic
    );

end memtest;

architecture Behavioral of memtest is

  signal clk : std_logic := '0';

  signal addr1  : std_logic_vector(18 downto 0) := (others => '0');
  signal d1     : std_logic_vector(33 downto 0) := (others => '0');
  signal q1     : std_logic_vector(33 downto 0) := (others => '0');
  signal we1    : std_logic;
  signal clken1 : std_logic                     := '0';

  signal addr2    : std_logic_vector(18 downto 0) := "1111111111111111000";
  signal expected : std_logic_vector(31 downto 0) := (others => '0');
  signal d2       : std_logic_vector(33 downto 0) := (others => '0');
  signal q2       : std_logic_vector(31 downto 0) := (others => '0');
  signal we2      : std_logic;
  signal clken2   : std_logic                     := '0';

  signal addr3  : std_logic_vector(16 downto 0) := (others => '0');
  signal d3     : std_logic_vector(31 downto 0) := (others => '0');
  signal q3     : std_logic_vector(31 downto 0) := (others => '0');
  signal we3    : std_logic;
  signal clken3 : std_logic                     := '0';

  signal addr4  : std_logic_vector(16 downto 0) := (others => '0');
  signal d4     : std_logic_vector(31 downto 0) := (others => '0');
  signal q4     : std_logic_vector(31 downto 0) := (others => '0');
  signal we4    : std_logic;
  signal clken4 : std_logic                     := '0';

  signal valid : std_logic := '0';


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


begin  -- Behavioral


  memory_inst : memory
    port map (
      CLK     => clk,
      RESET   => RESET,
      DQEXT   => MD,
      WEEXT   => MWE,
      ADDREXT => MA,
      ADDR1   => addr1(18 downto 2),
      ADDR2   => addr2(18 downto 2),
      ADDR3   => addr3,
      ADDR4   => addr4,
      D1      => d1(33 downto 2),
      D2      => d2(33 downto 2),
      D3      => D3,
      D4      => d4,
      Q1      => q1(33 downto 2),
      Q2      => q2,
      Q3      => q3,
      Q4      => q4,
      WE1     => we1,
      WE2     => we2,
      WE3     => we3,
      WE4     => we4,
      CLKEN1  => clken1,
      CLKEN2  => clken2,
      CLKEN3  => clken3,
      CLKEN4  => clken4);

  PHYRESET <= '0';

  WE1 <= '1';
  WE2 <= '0';
  WE3 <= '0';
  WE4 <= '0';

  MCLK <= clk;
  clk  <= CLKIN;

  main : process(clk)
  begin
    if rising_edge(clk) then
      addr1 <= addr1 + 1;
      d1    <= d1 + 1;

      addr2    <= addr2 + 1;
      expected <= d1(33 downto 2) - X"00000004";

      if clken2 = '1' then
        if expected = q2 then
          valid <= '1';
        else
          valid <= '0';
        end if;

      end if;
    end if;


  end process main;
    LEDPOWER  <= '1';
  LED100 <= '0';
  LED1000 <= '0';
  LEDACT <= valid;

end Behavioral;

