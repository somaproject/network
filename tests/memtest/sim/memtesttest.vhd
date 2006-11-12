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
      MOE      : out   std_logic;
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

  signal CLKIN : std_logic                     := '0';
  signal RESET : std_logic                     := '1';
  signal MD    : std_logic_vector(31 downto 0) := (others => '0');
  signal MWE   : std_logic                     := '0';
  signal MA    : std_logic_vector(16 downto 0) := (others => '0');
  signal MCLKout, MCLKin  : std_logic                     := '0';
  signal MOE   : std_logic                     := '0';

  signal PHYRESET : std_logic := '0';
  signal LEDPOWER : std_logic := '0';
  signal LED100   : std_logic := '0';
  signal LED1000  : std_logic := '0';
  signal LEDACT   : std_logic := '0';

  component mt55l256l32p
    generic (
      -- Constant parameters
      addr_bits : integer := 17;
      data_bits : integer := 32;

      -- Timing parameters for -10 (100 Mhz)
      tKHKH : time := 10.0 ns;
      tKHKL : time := 3.2 ns;
      tKLKH : time := 3.2 ns;
      tKHQV : time := 5.0 ns;
      tAVKH : time := 2.0 ns;
      tEVKH : time := 2.0 ns;
      tCVKH : time := 2.0 ns;
      tDVKH : time := 2.0 ns;
      tKHAX : time := 0.5 ns;
      tKHEX : time := 0.5 ns;
      tKHCX : time := 0.5 ns;
      tKHDX : time := 0.5 ns
      );

    -- Port Declarations
    port (
      Dq    : inout std_logic_vector (data_bits - 1 downto 0);  -- Data I/O
      Addr  : in    std_logic_vector (addr_bits - 1 downto 0);  -- Address
      Lbo_n : in    std_logic;                                  -- Burst Mode
      Clk   : in    std_logic;                                  -- Clk
      Cke_n : in    std_logic;                                  -- Cke#
      Ld_n  : in    std_logic;                                  -- Adv/Ld#
      Bwa_n : in    std_logic;                                  -- Bwa#
      Bwb_n : in    std_logic;                                  -- BWb#
      Bwc_n : in    std_logic;                                  -- Bwa#
      Bwd_n : in    std_logic;                                  -- BWb#
      Rw_n  : in    std_logic;                                  -- RW#
      Oe_n  : in    std_logic;                                  -- OE#
      Ce_n  : in    std_logic;                                  -- CE#
      Ce2_n : in    std_logic;                                  -- CE2#
      Ce2   : in    std_logic;                                  -- CE2
      Zz    : in    std_logic                                   -- Snooze Mode
      );
  end component;

begin  -- Behavioral

  memtest_uut : memtest
    port map (
      CLKIN    => CLKIN,
      RESET    => RESET,
      MD       => MD,
      MWE      => MWE,
      MA       => MA,
      MOE      => MOE,
      MCLK     => MCLKout,
      PHYRESET => PHYRESET,
      LEDPOWER => LEDPOWER,
      LED100   => LED100,
      LED1000  => LED1000,
      LEDACT   => LEDACT);

  memory : mt55l256l32p
    port map (
      Dq    => MD,
      addr  => MA,
      Lbo_n => '0',
      CLK   => MCLKin,
      CKE_N => '0',
      LD_N  => '0',
      BWA_N => '0',
      BWB_N => '0',
      BWC_N => '0',
      BWD_N => '0',
      RW_N  => MWE,
      OE_N  => MOE,
      CE_N  => '0',
      CE2_N => '0',
      CE2   => '1',
      Zz    => '0');

  CLKIN <= not CLKIN after 10 ns;
  RESET <= '0'       after 20 ns;


  MCLKin <= not MCLKout after 9.5 ns;
  

end Behavioral;
