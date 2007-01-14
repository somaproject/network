library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;

entity memorytest is

end memorytest;

architecture Behavioral of memorytest is

  component memory
    port (
      CLK     : in    std_logic;
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

  component NoBLSRAM
-- generic ( FILEIN : string := "SRAM_in.dat";
-- FILEOUT : string := "SRAM_out.dat";
-- physical_sim : integer := 0;
-- TSU : time;
-- THD : time;
-- TKQ : time;
-- TKQX : time);
    port ( CLK   : in    std_logic;
           DQ    : inout std_logic_vector(31 downto 0);
           ADDR  : in    std_logic_vector(16 downto 0);
           WE    : in    std_logic;
           RESET : in    std_logic;
           SAVE  : in    std_logic);
  end component;

  signal CLK   : std_logic                     := '0';
  signal RESET : std_logic                     := '0';
  signal DQEXT : std_logic_vector(31 downto 0) := (others => '0');
  signal WEEXT : std_logic                     := '0';

  signal ADDREXT : std_logic_vector(16 downto 0) := (others => '0');
  signal ADDR1   : std_logic_vector(16 downto 0) := "00000000010000000";
  signal ADDR2   : std_logic_vector(16 downto 0) := "00000000010000000";
  signal ADDR3   : std_logic_vector(16 downto 0) := "00000000000000000";
  signal ADDR4   : std_logic_vector(16 downto 0) := "00000000000000000";
  signal D1      : std_logic_vector(31 downto 0) := (others => '0');
  signal D2      : std_logic_vector(31 downto 0) := (others => '0');
  signal D3      : std_logic_vector(31 downto 0) := X"01234567";
  signal D4      : std_logic_vector(31 downto 0) := (others => '0');
  signal Q1      : std_logic_vector(31 downto 0) := (others => '0');
  signal Q2      : std_logic_vector(31 downto 0) := (others => '0');
  signal Q3      : std_logic_vector(31 downto 0) := (others => '0');
  signal Q4      : std_logic_vector(31 downto 0) := (others => '0');

  signal WE1    : std_logic := '0';
  signal WE2    : std_logic := '0';
  signal WE3    : std_logic := '0';
  signal WE4    : std_logic := '0';
  signal CLKEN1 : std_logic := '0';
  signal CLKEN2 : std_logic := '0';
  signal CLKEN3 : std_logic := '0';
  signal CLKEN4 : std_logic := '0';

  signal MEMCLK : std_logic := '0';

begin  -- Behavioral

  CLK    <= not CLK       after 4 ns;
  MEMCLK <= transport CLK after 1 ns;

  ram : NoBLSRAM
-- generic map (
-- TSU => 0 ns,
-- THD => 0 ns,
-- TKQ => 0 ns,
-- TKQX => 0 ns)
    port map (
      CLK   => MEMCLK,
      DQ    => DQEXT,
      ADDR  => ADDREXT,
      WE    => WEEXT,
      RESET => '0',
      SAVE  => '0');

  uut : memory
    port map (
      CLK     => CLK,
      RESET   => RESET,
      DQEXT   => DQEXT,
      WEEXT   => WEEXT,
      ADDREXT => ADDREXT,
      ADDR1   => ADDR1,
      ADDR2   => ADDR2,
      ADDR3   => ADDR3,
      ADDR4   => ADDR4,
      D1      => D1,
      D2      => D2,
      D3      => D3,
      D4      => D4,
      Q1      => Q1,
      Q2      => Q2,
      Q3      => Q3,
      Q4      => Q4,
      WE1     => WE1,
      WE2     => WE2,
      WE3     => WE3,
      WE4     => WE4,
      CLKEN1  => CLKEN1,
      CLKEN2  => CLKEN2,
      CLKEN3  => CLKEN3,
      CLKEN4  => CLKEN4
      );

  -- try writing
  process(CLK)
  begin
    if rising_edge(CLK) then
      WE1     <= '1';
      if CLKEN1 = '1' then
        D1    <= D1 + 1;
        ADDR1 <= ADDR1 + 1;
      end if;
    end if;
  end process;

  process(CLK)
  begin
    if rising_edge(CLK) then
      WE3     <= '1';
      if CLKEN1 = '1' then
        D3    <= D3 + 4;
        ADDR3 <= ADDR3 + 1;
      end if;
    end if;
  end process;

  verifylow : process
  begin
    WE2     <= '0';
    wait until rising_edge(CLK) and CLKEN2 = '1';
    wait until rising_edge(CLK) and CLKEN2 = '1';
    wait until rising_edge(CLK) and CLKEN2 = '1';
    wait until rising_edge(CLK) and CLKEN2 = '1';
    wait until rising_edge(CLK) and CLKEN2 = '1';
    for i in 0 to 19 loop
      wait until rising_edge(CLK) and CLKEN2 = '1';
      ADDR2 <= ADDR2 + 1;

    end loop;  -- i
    wait;
  end process verifylow;


  verifyhigh : process
  begin
    WE4     <= '0';
    wait until rising_edge(CLK) and CLKEN4 = '1';
    wait until rising_edge(CLK) and CLKEN4 = '1';
    wait until rising_edge(CLK) and CLKEN4 = '1';
    wait until rising_edge(CLK) and CLKEN4 = '1';
    wait until rising_edge(CLK) and CLKEN4 = '1';
    for i in 0 to 19 loop
      wait until rising_edge(CLK) and CLKEN4 = '1';
      ADDR4 <= ADDR4 + 1;

    end loop;  -- i
    wait;
  end process verifyhigh;


end Behavioral;
