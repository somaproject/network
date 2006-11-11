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
  
  component NoBLSRAM
    generic (
      FILEIN       :       string  := "SRAM_in.dat";
      FILEOUT      :       string  := "SRAM_out.dat";
      physical_sim :       integer := 0;
      TSU          :       time;
      THD          :       time;
      TKQ          :       time;
      TKQX         :       time);
    port (
      CLK          : in    std_logic;
      DQ           : inout std_logic_vector(31 downto 0);
      ADDR         : in    std_logic_vector(16 downto 0);
      WE           : in    std_logic;
      RESET        : in    std_logic;
      SAVE         : in    std_logic);
  end component;

begin  -- Behavioral

  CLKIN <= not CLKIN after 10 ns;
  RESET <= '0' after 100 ns;
  
  memory : NoBLSRAM
    generic map (
      TSU  => 0 ns,
      THD  => 0 ns,
      TKQ  => 0 ns,
      TKQX => 0 ns)

    port map (
      CLK   => MEMCLK,
      DQ    => RAMDQ,
      ADDR  => RAMADDR,
      WE    => RAMWE,
      RESET => RESET,
      SAVE  => '0');

  memtest_uut : memtest
    port map (
      CLKIN    => CLKIN,
      RAMDQ    => RAMDQ,
      RAMWE    => RAMWE,
      RAMADDR  => RAMADDR,
      MEMCLK   => MEMCLK,
      LEDPOWER => error_flag);

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
