library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;


entity phytesttest is

end phytesttest;

architecture Behavioral of phytesttest is

  component phytest
    port (
      CLKIN    : in  std_logic;
      RESET    : in  std_logic;
      MCLK     : out std_logic;
      PHYRESET : out std_logic;
      LEDPOWER : out std_logic;
      LED100   : out std_logic;
      LED1000  : out std_logic;
      LEDACT   : out std_logic;
      LEDTX    : out std_logic;
      LEDRX    : out std_logic;
      LEDDPX   : out std_logic;
      GTX_CLK  : out std_logic;
      TX_EN    : out std_logic;
      TXD      : out std_logic_vector(7 downto 0);

      MDIO : inout std_logic;
      MDC  : out   std_logic
      );
  end component;


  signal CLKIN    : std_logic                    := '0';
  signal RESET    : std_logic                    := '1';
  signal MCLK     : std_logic                    := '0';
  signal PHYRESET : std_logic                    := '0';
  signal LEDPOWER : std_logic                    := '0';
  signal LED100   : std_logic                    := '0';
  signal LED1000  : std_logic                    := '0';
  signal LEDACT   : std_logic                    := '0';
  signal LEDTX    : std_logic                    := '0';
  signal LEDRX    : std_logic                    := '0';
  signal LEDDPX   : std_logic                    := '0';
  signal GTX_CLK  : std_logic                    := '0';
  signal TX_EN    : std_logic                    := '0';
  signal TXD      : std_logic_vector(7 downto 0) := (others => '0');

  signal MDIO : std_logic := '0';
  signal MDC  : std_logic := '0';

begin  -- Behavioral

  phytest_uut : phytest
    port map (
      CLKIN    => CLKIN,
      RESET    => RESET,
      MCLK     => MCLK,
      PHYRESET => PHYRESET,
      LEDPOWER => LEDPOWER,
      LED100   => LED100,
      LED1000  => LED1000,
      LEDACT   => LEDACT,
      LEDTX    => LEDTX,
      LEDRX    => LEDRX,
      LEDDPX   => LEDDPX,
      GTX_CLK  => GTX_CLK,
      TX_EN    => TX_EN,
      TXD      => TXD,
      MDIO     => MDIO,
      MDC      => MDC);


  CLKIN <= not CLKIN after 4 ns;
  RESET <= '0'       after 20 ns;




end Behavioral;
