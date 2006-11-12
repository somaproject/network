library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity memtesttest is
end memtesttest;

architecture Behavioral of memtesttest is

  component memtest
    port (
      CLKIN    : in    std_logic;
      RAMDQ    : inout std_logic_vector(31 downto 0);
      RAMWE    : out   std_logic;
      RAMADDR  : out   std_logic_vector(16 downto 0);
      MEMCLK   : out   std_logic;
      LEDPOWER : out   std_logic
      );
  end component;

  signal CLKIN  : std_logic := '0';
  signal MEMCLK : std_logic := '0';

  signal RAMDQ   : std_logic_vector(31 downto 0) := (others => '0');
  signal RAMWE   : std_logic                     := '0';
  signal RAMADDR : std_logic_vector(16 downto 0) := (others => '0');

-- memory signals
  signal ESTATE : std_logic := '0';

  signal error_flag : std_logic := '0';
  signal reset : std_logic := '1';
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

  CLKIN <= not CLKIN after 10 ns;
  RESET <= '0' after 100 ns;
  

  memtest_uut : memtest
    port map (
      CLKIN    => CLKIN,
      RAMDQ    => RAMDQ,
      RAMWE    => RAMWE,
      RAMADDR  => RAMADDR,
      MEMCLK   => MEMCLK,
      LEDPOWER => error_flag);

  memory : mt55l256l32p
    port map (
      Dq    => RAMDQ,
      addr  => RAMADDR,
      Lbo_n => '0',
      CLK   => MEMCLK,
      CKE_N => '0',
      LD_N  => '0',
      BWA_N => '0',
      BWB_N => '0',
      BWC_N => '0',
      BWD_N => '0',
      RW_N  => RAMWE,
      OE_N  => '0',
      CE_N  => '0',
      CE2_N => '0',
      CE2   => '1',
      Zz    => '0');

  -- check
  process
  begin
    wait for 100 us;
    ESTATE <= '1';
    wait for 1 us;
    ESTATE <= '0';
    wait;


  end process;


end Behavioral;
