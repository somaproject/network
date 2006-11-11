library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;


entity memtest is
  port (
    CLKIN    : in    std_logic;
    RAMDQ    : inout std_logic_vector(31 downto 0);
    RAMOE    : out   std_logic;
    RAMWE    : out   std_logic;
    RAMADDR  : out   std_logic_vector(16 downto 0);
    MEMCLK   : out   std_logic;
    LEDPOWER : out   std_logic
    );
end memtest;

architecture Behavioral of memtest is

  signal dsel : std_logic := '0';

  signal lramwe     : std_logic                     := '0';
  signal lramaddr   : std_logic_vector(16 downto 0) := (others => '0');
  signal lts        : std_logic                     := '0';
  signal ts         : std_logic                     := '0';
  signal ramq, ramql, ramqll,  ramd : std_logic_vector(31 downto 0) := (others => '0');
  signal ramts      : std_logic_vector(31 downto 0) := (others => '0');

  signal ramdin, ramdin2: std_logic_vector(31 downto 0) := (others => '0');

  signal acnt : std_logic_vector(16 downto 0) := (others => '0');

  signal dcnt : std_logic_vector(31 downto 0) := (others => '0');

  type acnt_t is array (15 downto 0) of std_logic_vector(16 downto 0);
  signal acntreg : acnt_t := (others => (others => '0'));

  type dcnt_t is array (15 downto 0) of std_logic_vector(31 downto 0);
  signal dcntreg : dcnt_t := (others => (others => '0'));

  signal errorbits : std_logic_vector(31 downto 0) := (others => '0');

  signal clk, clkf, clkint, clkfint : std_logic := '0';

  -- error signals
  type errorbitsarray_t is array (31 downto 0) of std_logic_vector(7 downto 0);
  signal errorbitsarray : errorbitsarray_t := (others => (others => '0'));

  signal errorbitssreg : std_logic_vector(32*8-1 downto 0) := (others => '0');

  signal jtagcapture, jtagdrck, jtagreset, jtagsel,
    jtagshift, jtagtdi, jtagupdate, jtagtdo : std_logic := '0';

  signal startup_wait : std_logic := '1';

  attribute IOB          : string;
  attribute IOB of ramts : signal is "true";


begin  -- Behavioral
  DCM_inst : DCM
    generic map (
      CLKDV_DIVIDE       => 2.0,
      CLKFX_DIVIDE       => 2,
      CLKFX_MULTIPLY     => 2,
      DFS_FREQUENCY_MODE => "LOW",
      DLL_FREQUENCY_MODE => "LOW",
      CLKOUT_PHASE_SHIFT => "FIXED",
      PHASE_SHIFT        => 0,
      STARTUP_WAIT       => false)
    port map (
      CLK0               => clkfint,    -- 0 degree DCM CLK ouptput
      CLKFX              => clkint,     -- DCM CLK synthesis out (M/D)
      LOCKED             => open,       -- DCM LOCK status output
      CLKFB              => clkf,       -- DCM clock feedback
      CLKIN              => CLKIN,      -- Clock input (from IBUFG, BUFG or DCM)
      RST                => '0'
      );

  clkf_bufg : BUFG
    port map (
      O => clkf,
      I => clkfint);

  clk_bufg : BUFG
    port map (
      O => clk,
      I => clkint);

  MEMCLK <= not clk;

  lramwe <= '0' when dsel = '0' else '1';

  lts      <= '0'  when dsel = '0' else '1';
  lramaddr <= acnt when dsel = '0' else acntreg(5);

  iobs         : for i in 0 to 31 generate
    IOBUF_inst : IOBUF

      port map (
        O  => ramd(i),
        IO => RAMDQ(i),
        I  => ramqll(i),
        T  => ramts(i)
        );

  end generate iobs;



  main : process(CLK)
  begin
    if rising_edge(CLK) then
      dsel <= not dsel;

      -- registers
      RAMWE   <= lramwe;
      RAMADDR <= lramaddr;
      ramq    <= dcnt;
      ramql <= ramq;
      ramqll <= ramql; 

      ramdin <= ramd;
      ramts  <= (others => lts);

      -- counters
      if dsel = '1' then
        acnt <= acnt + 1;
        dcnt <= dcnt + 1;
      end if;

      if acnt = "00000000000010000" then
        startup_wait <= '0';
      end if;
      acntreg        <= acntreg(14 downto 0) & acnt;
      dcntreg        <= (dcntreg(14 downto 0) & dcnt);

      if dsel = '1' then
        if dcntreg(9) = ramdin then
          -- success!
          errorbits   <= (others => '0');
          LEDPOWER    <= '0';
        else
          if startup_wait = '0' then
            errorbits <= dcntreg(9) xor ramdin;
          end if;
          LEDPOWER    <= '1';
        end if;

      end if;
    end if;
  end process;



  errorbitschecks : for i in 0 to 31 generate
    process(CLK, jtagupdate)
    begin
      if rising_edge(CLK) then
        if errorbits(i) = '1' then
          if dsel = '1' then
            errorbitsarray(i) <= errorbitsarray(i) + 1;
          end if;
        end if;

      end if;

      if rising_edge(jtagupdate) then
        errorbitssreg(i*8+7 downto i*8) <= errorbitsarray(i);
      end if;
    end process;
  end generate errorbitschecks;

  ----------------------------------------------------------------------------
  -- JTAG OUTPUT
  ----------------------------------------------------------------------------

  BSCAN_SPARTAN3_inst : BSCAN_SPARTAN3
    port map (
      CAPTURE => jtagcapture,           -- CAPTURE output from TAP controller
      DRCK1   => jtagdrck,              -- Data register output for USER1 functions
      DRCK2   => open,                  -- Data register output for USER2 functions
      SEL1    => jtagsel,               -- USER1 active output
      SEL2    => open,                  -- USER2 active output
      SHIFT   => jtagshift,             -- SHIFT output from TAP controller
      TDI     => jtagtdi,               -- TDI output from TAP controller
      UPDATE  => jtagupdate,            -- UPDATE output from TAP controller
      TDO1    => jtagtdo,               -- Data input for USER1 function
      TDO2    => open                   -- Data input for USER2 function
      );


  -- output read
  process(jtagupdate, jtagsel, jtagdrck, jtagshift)
    variable tdopos : integer range 0 to (32*8 -1) := 0;
  begin

    if jtagupdate = '1' then
      tdopos     := 32*8 -1;
    elsif falling_edge(jtagdrck) then
      if jtagsel = '1' then
        if tdopos = 32*8 - 1 then
          tdopos := 0;
        else
          tdopos := tdopos + 1;
        end if;

      end if;
    end if;
    jtagtdo <= errorbitssreg(tdopos);
  end process;

  RAMOE <= '0';


end Behavioral;
