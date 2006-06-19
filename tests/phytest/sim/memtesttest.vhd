library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;


entity memtesttest is

end memtesttest;

architecture Behavioral of memtesttest is

  component memtest
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
  end component;

  component NoBLSRAM
    generic ( FILEIN       :       string  := "SRAM_in.dat";
              FILEOUT      :       string  := "SRAM_out.dat";
              physical_sim :       integer := 0;
              TSU          :       time;
              THD          :       time;
              TKQ          :       time;
              TKQX         :       time);
    port ( CLK             : in    std_logic;
           DQ              : inout std_logic_vector(31 downto 0);
           ADDR            : in    std_logic_vector(16 downto 0);
           WE              : in    std_logic;
           RESET           : in    std_logic;
           SAVE            : in    std_logic);
  end component;

  signal CLKIN    : std_logic                     := '0';
  signal RESET    : std_logic                     := '1';
  signal MD       : std_logic_vector(31 downto 0) := (others => '0');
  signal MWE      : std_logic                     := '0';
  signal MA       : std_logic_vector(16 downto 0) := (others => '0');
  signal MCLK     : std_logic                     := '0';
  signal PHYRESET : std_logic                     := '0';
  signal LEDPOWER : std_logic                     := '0';
  signal LED100   : std_logic                     := '0';
  signal LED1000  : std_logic                     := '0';
  signal LEDACT   : std_logic                     := '0';

begin  -- Behavioral

  memtest_uut : memtest
    port map (
      CLKIN    => CLKIN,
      RESET    => RESET,
      MD       => MD,
      MWE      => MWE,
      MA       => MA,
      MCLK     => MCLK,
      PHYRESET => PHYRESET,
      LEDPOWER => LEDPOWER,
      LED100   => LED100,
      LED1000  => LED1000,
      LEDACT   => LEDACT);

  ram : NoBLSRAM
    generic map (
      TSU   => 0 ns,
      THD   => 0 ns,
      TKQ   => 0 ns,
      TKQX  => 0 ns)
    port map (
      CLK   => MCLK,
      DQ    => MD,
      ADDR  => MA,
      WE    => MWE,
      RESET => RESET,
      SAVE  => '0');

  CLKIN <= not CLKIN after 4 ns;
  RESET <= '0'       after 20 ns;




end Behavioral;
