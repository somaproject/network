
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;


entity networktest is
end networktest;

architecture behavior of networktest is

  component network
    port(
      CLKIN     : in    std_logic;
      RX_DV     : in    std_logic;
      RX_ER     : in    std_logic;
      RXD       : in    std_logic_vector(7 downto 0);
      RX_CLK    : in    std_logic;
      CLKIOIN   : in    std_logic;
      NEXTFRAME : in    std_logic;
      NEWFRAME  : in    std_logic;
      DIN       : in    std_logic_vector(15 downto 0);
      SCLK      : in    std_logic;
      SIN       : in    std_logic;
      SCS       : in    std_logic;
      MD        : inout std_logic_vector(31 downto 0);
      MDIO      : inout std_logic;
      TXD       : out   std_logic_vector(7 downto 0);
      TX_EN     : out   std_logic;
      GTX_CLK   : out   std_logic;
      MA        : out   std_logic_vector(16 downto 0);
      MCLK      : out   std_logic;
      MWE       : out   std_logic;
      DOUT      : out   std_logic_vector(15 downto 0);
      DOUTEN    : out   std_logic;
      MDC       : out   std_logic;
      LEDACT    : out   std_logic;
      LEDTX     : out   std_logic;
      LEDRX     : out   std_logic;
      LED100    : out   std_logic;
      LED1000   : out   std_logic;
      LEDDPX    : out   std_logic;
      LEDPOWER  : out   std_logic;
      PHYRESET  : out   std_logic;
      SOUT      : out   std_logic
      );
  end component;

  component NoBLSRAM
--     generic ( FILEIN       :       string  := "SRAM_in.dat";
--               FILEOUT      :       string  := "SRAM_out.dat";
--               physical_sim :       integer := 0;
--               TSU          :       time;
--               THD          :       time;
--               TKQ          :       time;
--               TKQX         :       time);
    port ( CLK             : in    std_logic;
           DQ              : inout std_logic_vector(31 downto 0);
           ADDR            : in    std_logic_vector(16 downto 0);
           WE              : in    std_logic;
           RESET           : in    std_logic;
           SAVE            : in    std_logic);
  end component;

  signal CLKIN     : std_logic := '0';
  signal RESET     : std_logic := '1';
  signal RX_DV     : std_logic := '0';
  signal RX_ER     : std_logic := '0';
  signal RXD       : std_logic_vector(7 downto 0);
  signal RX_CLK    : std_logic := '0';
  signal TXD       : std_logic_vector(7 downto 0);
  signal TX_EN     : std_logic := '0';
  signal GTX_CLK   : std_logic := '0';
  signal MA        : std_logic_vector(16 downto 0);
  signal MD        : std_logic_vector(31 downto 0);
  signal MCLK      : std_logic := '0';
  signal MWE       : std_logic := '1';
  signal CLKIOIN   : std_logic := '0';
  signal NEXTFRAME : std_logic := '0';
  signal DOUT      : std_logic_vector(15 downto 0)
                               := (others => '0');
  signal DOUTEN    : std_logic := '0';
  signal NEWFRAME  : std_logic := '0';
  signal DIN       : std_logic_vector(15 downto 0);
  signal MDIO      : std_logic := '0';
  signal MDC       : std_logic := '0';
  signal LEDACT    : std_logic;
  signal LEDTX     : std_logic;
  signal LEDRX     : std_logic;
  signal LED100    : std_logic;
  signal LED1000   : std_logic;
  signal LEDDPX    : std_logic;
  signal LEDPOWER  : std_logic;
  signal PHYRESET  : std_logic;
  signal SCLK      : std_logic := '0';
  signal SIN       : std_logic := '0';
  signal SOUT      : std_logic;
  signal SCS       : std_logic := '0';

  signal save             : std_logic := '0';
  signal expected_gmiiout : std_logic_vector(7 downto 0)
                                      := (others => '0');

  signal rxinput_done, rxoutput_done,
    txinput_done, txoutput_done : std_logic := '0';


begin

  uut : network port map(
    CLKIN     => CLKIN,
    RX_DV     => RX_DV,
    RX_ER     => RX_ER,
    RXD       => RXD,
    RX_CLK    => RX_CLK,
    TXD       => TXD,
    TX_EN     => TX_EN,
    GTX_CLK   => GTX_CLK,
    MA        => MA,
    MD        => MD,
    MCLK      => MCLK,
    MWE       => MWE,
    CLKIOIN   => CLKIOIN,
    NEXTFRAME => NEXTFRAME,
    DOUT      => DOUT,
    DOUTEN    => DOUTEN,
    NEWFRAME  => NEWFRAME,
    DIN       => DIN,
    MDIO      => MDIO,
    MDC       => MDC,
    LEDACT    => LEDACT,
    LEDTX     => LEDTX,
    LEDRX     => LEDRX,
    LED100    => LED100,
    LED1000   => LED1000,
    LEDDPX    => LEDDPX,
    LEDPOWER  => LEDPOWER,
    PHYRESET  => PHYRESET,
    SCLK      => SCLK,
    SIN       => SIN,
    SOUT      => SOUT,
    SCS       => SCS
    );

  ram : NoBLSRAM
--     generic map (
--     TSU     => 0 ns,
--     THD     => 0 ns,
--     TKQ     => 0 ns,
--     TKQX    => 0 ns)
    port map (
      CLK   => MCLK,
      DQ    => MD,
      ADDR  => MA,
      WE    => MWE,
      RESET => RESET,
      SAVE  => SAVE);

  clkin   <= not clkin   after 10 ns;
  clkioin <= not clkioin after 8.5 ns;
  RX_CLK  <= not RX_CLK  after 4 ns;

  reset <= '0' after 80 ns;
  save  <= '1' after 1500 ns;

  -- input data:
  rxinput          : process
    file gmiifile  : text;
    variable L     : line;
    variable dvin  : integer := 0;
    variable erin  : integer := 0;
    variable rxdin : std_logic_vector(7 downto 0);

  begin
    file_open(gmiifile, "gmiiin.0.dat", read_mode);
    wait for 1 us;
    while not endfile(gmiifile) loop
      wait until rising_edge(RX_CLK) and RESET = '0';
      readline(gmiifile, L);
      hread(L, rxdin);
      read(L, dvin);
      read(L, erin);

      if dvin = 0 then
        RX_DV <= '0';
      elsif dvin = 1 then
        RX_DV <= '1';
      end if;

      if erin = 0 then
        RX_ER    <= '0';
      else
        RX_ER    <= '1';
      end if;
      RXD        <= rxdin;
    end loop;
    rxinput_done <= '1';
    wait;
  end process;

  rxoutput                           : process
    file datafile                    : text;
    variable L                       : line;
    variable words, nops, wcnt, ncnt : integer := 0;
    variable rdata                   : std_logic_vector(15 downto 0)
                                               := (others => '0');
    variable bytelen                 : integer := 0;

  begin
    wait until falling_edge(RESET);
    file_open(datafile, "dout.0.dat", read_mode);
    words     := 0;
    nops      := 0;
    wait until rising_edge(CLKIOin);
    NEXTFRAME   <= '0';
    while not endfile(datafile) loop
      readline(datafile, L);
      read(L, nops);
      read(L, words);
      ncnt    := -1;
      bytelen := 0;
      while ncnt < nops loop
        wait until rising_edge(CLKIOin);
        ncnt  := ncnt + 1;
      end loop;
      wcnt    := 0;
      NEXTFRAME <= '1' after 10 ns;
      while wcnt < words loop
        wait until rising_edge(CLKIOin) and DOUTEN = '1';
        wcnt  := wcnt + 1;

        hread(L, rdata);

        if wcnt = 1 then
          bytelen := to_integer(unsigned(rdata));
        end if;
        if ((bytelen mod 2 = 0) and (rdata /= DOUT)) or
          ((bytelen mod 2 = 1) and
           (rdata(15 downto 8) /= DOUT(15 downto 8)))then
          assert false
            report "RXOUTPUT : error reading data"
            severity error;
        end if;

      end loop;
      NEXTFRAME <= '0' after 10 ns;

    end loop;
    rxoutput_done <= '1';
    wait;

  end process rxoutput;

  -- input data:
  txinput               : process
    file dinfile        : text;
    variable L          : line;
    variable newframein : integer := 0;
    variable dinin      : std_logic_vector(15 downto 0);

  begin
    wait until falling_edge(RESET);

    wait for 1 us;
    file_open(dinfile, "din.0.dat", read_mode);
    while not endfile(dinfile) loop
      wait until rising_edge(CLKIOin);
      readline(dinfile, L);
      read(L, newframein);
      hread(L, dinin);
      if newframein = 0 then
        NEWFRAME <= '0';
      elsif newframein = 1 then
        NEWFRAME <= '1';
      end if;
      DIN        <= dinin;
    end loop;
    txinput_done <= '1';
    wait;

  end process txinput;


  --tx output simulation
  txoutput            : process
    file gmiifile     : text;
    variable L        : line;
    variable indata   : std_logic_vector(7 downto 0) := (others => '0');
    variable txenl    : std_logic                    := '0';
    variable txerrors : integer                      := 0;
  begin
    wait until falling_edge(RESET);
    file_open(gmiifile, "gmiiout.0.dat", read_mode);
    while not endfile(gmiifile) or TX_EN = '1' loop
      wait until rising_edge(GTX_CLK);

      if txenl = '0' and TX_EN = '1' then  -- rising edge
        txerrors   := 0;
        readline(gmiifile, L);
        hread(L, indata);
        if TXD /= indata then
          txerrors := txerrors + 1;
        end if;
        expected_gmiiout <= indata;
      elsif txenl = '1' and TX_EN = '0' then
        if txerrors /= 0 then
          assert false
            report "TXOUTPUT : error reading frame on gmii"
            severity error;
        end if;

      elsif txenl = '1' and TX_EN = '1' then
        hread(L, indata);
        if TXD /= indata then
          assert false
            report "TXOUTPUT : error reading frame on gmii"
            severity error;
        end if;

        expected_gmiiout <= indata;
      end if;

      txenl := TX_EN;
    end loop;

    txoutput_done <= '1';
    wait;
  end process txoutput;


  endofsim : process(rxinput_done, rxoutput_done,
                     txinput_done, txoutput_done)
  begin
    if rxinput_done = '1' and rxoutput_done = '1'
      and txoutput_done = '1' and txinput_done = '1' then
      assert false
        report "End of simulation"
        severity failure;
    end if;

  end process endofsim;

end;
