library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;

entity jtagserial is
  port (
    CLK  : in  std_logic;
    SCLK : out std_logic;
    SOUT : out std_logic;
    SCS  : out std_logic;
    SIN  : in  std_logic);
end jtagserial;


architecture Behavioral of jtagserial is
  signal jtagcapture : std_logic := '0';
  signal jtagdrck1   : std_logic := '0';
  signal jtagdrck2   : std_logic := '0';
  signal jtagsel1    : std_logic := '0';
  signal jtagsel2    : std_logic := '0';
  signal jtagshift   : std_logic := '0';
  signal jtagtdi     : std_logic := '0';
  signal jtagtdo1    : std_logic := '0';
  signal jtagtdo2    : std_logic := '0';
  signal jtagupdate  : std_logic := '0';


  signal tfscnt : std_logic_vector(7 downto 0) := (others => '0');

  signal jtagen : std_logic := '0';

  signal outtick : std_logic_vector(39 downto 0);


  component nicserialio
    port (
      CLK   : in  std_logic;
      START : in  std_logic;
      RW    : in  std_logic;
      ADDR  : in  std_logic_vector(5 downto 0);
      DIN   : in  std_logic_vector(31 downto 0);
      DOUT  : out std_logic_vector(31 downto 0);
      DONE  : out std_logic;
      SCLK  : out std_logic;
      SOUT  : out std_logic;
      SCS   : out std_logic;
      SIN   : in  std_logic);
  end component;

  signal start     : std_logic                     := '0';
  signal rw        : std_logic                     := '0';
  signal addr      : std_logic_vector(5 downto 0)  := (others => '0');
  signal din, dout : std_logic_vector(31 downto 0) := (others => '0');
  signal done      : std_logic                     := '0';

  signal jtagin, jtagout : std_logic_vector(39 downto 0) := (others => '0');

  signal update, updatel : std_logic := '0';

  signal outpos : integer range 0 to 39 := 0;

begin  -- Behavioral

  nicserialio_inst : nicserialio
    port map (
      CLK   => CLK,
      START => START,
      RW    => RW,
      ADDR  => addr,
      DIN   => din,
      DOUT  => dout,
      DONE  => done,
      SCLK  => SCLK,
      SOUT  => SOUT,
      SCS   => SCS,
      SIN   => SIN);


  BSCAN_SPARTAN3_inst : BSCAN_SPARTAN3
    port map (
      CAPTURE => jtagcapture,           -- CAPTURE output from TAP controller
      DRCK1   => jtagdrck1,             -- Data register output for USER1 functions
      DRCK2   => jtagDRCK2,             -- Data register output for USER2 functions
      SEL1    => jtagSEL1,              -- USER1 active output
      SEL2    => jtagSEL2,              -- USER2 active output
      SHIFT   => jtagSHIFT,             -- SHIFT output from TAP controller
      TDI     => jtagTDI,               -- TDI output from TAP controller
      UPDATE  => jtagUPDATE,            -- UPDATE output from TAP controller
      TDO1    => jtagtdo1,              -- Data input for USER1 function
      TDO2    => jtagtdo2               -- Data input for USER2 function
      );

  rw   <= jtagin(39);
  addr <= jtagin(37 downto 32);
  din  <= jtagin(31 downto 0);

  process(jtagdrck1)
  begin
    if rising_edge(jtagdrck1) then
      jtagin <= jtagtdi & jtagin(39 downto 1);
    end if;
  end process;

  process(jtagdrck2)
  begin
    if jtagUPDATE = '1' then
      outpos <= 0;
    else

      if rising_edge(jtagdrck2) then
        jtagtdo2 <= jtagout(outpos);

        outpos <= outpos + 1;
      end if;
    end if;
  end process;

  process (CLK)
  begin
    if rising_edge(CLK) then
      update                 <= jtagUPDATE;
      updatel                <= update;
      if updatel = '0' and update = '1' and jtagsel1 = '1' then
        start                <= '1';
      else
        start                <= '0';
      end if;
      if done = '1' then
        jtagout(31 downto 0) <= dout;
      end if;

    end if;
  end process;


end Behavioral;

