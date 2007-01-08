library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity control is
  port (
    CLK         : in    std_logic;
    CLKLO       : in    std_logic;
    RESET       : in    std_logic;
    SCLK        : in    std_logic;
    SCS         : in    std_logic;
    SIN         : in    std_logic;
    SOUT        : out   std_logic;
    LEDACT      : out   std_logic;
    LEDTX       : out   std_logic;
    LEDRX       : out   std_logic;
    LED100      : out   std_logic;
    LED1000     : out   std_logic;
    LEDDPX      : out   std_logic;
    PHYRESET    : out   std_logic;
    TXF         : in    std_logic;
    RXF         : in    std_logic;
    TXFIFOWERR  : in    std_logic;
    RXFIFOWERR  : in    std_logic;
    RXPHYERR    : in    std_logic;
    RXOFERR     : in    std_logic;
    RXMEMCRCERR : in    std_logic;
    TXMEMCRCERR : in    std_logic;
    TXIOCRCERR : in std_logic; 
    RXCRCERR    : in    std_logic;
    RXBCAST     : out   std_logic;
    RXMCAST     : out   std_logic;
    RXUCAST     : out   std_logic;
    RXALLF      : out   std_logic;
    MACADDR     : out   std_logic_vector(47 downto 0);
    MDIO        : inout std_logic;
    MDC         : out   std_logic;
    MDEBUGADDR  : out   std_logic_vector(16 downto 0);
    MDEBUGDATA  : in    std_logic_vector(31 downto 0);
    RXBP        : in    std_logic_vector(15 downto 0);
    RXFBBP      : in    std_logic_vector(15 downto 0);
    TXBP        : in    std_logic_vector(15 downto 0);
    TXFBBP      : in    std_logic_vector(15 downto 0));

end control;

architecture Behavioral of control is

  -- input control signals
  signal addr      : std_logic_vector(7 downto 0)  := (others => '0');
  signal rw        : std_logic                     := '0';
  signal din, dout : std_logic_vector(31 downto 0) := (others => '0');
  signal newcmd    : std_logic                     := '0';

  signal newcmdw : std_logic := '0';


  -- write signals
  signal PHYRESETW    : std_logic := '0';
  signal PHYSTATUSW   : std_logic := '0';
  signal PHYAddrW     : std_logic := '0';
  signal PHYDIW       : std_logic := '0';
  signal PHYDOW       : std_logic := '0';
  signal TXFR         : std_logic := '0';
  signal RXFR         : std_logic := '0';
  signal TXFIFOWERRR  : std_logic := '0';
  signal RXFIFOWERRR  : std_logic := '0';
  signal RXPHYERRR    : std_logic := '0';
  signal RXOFERRR     : std_logic := '0';
  signal RXCRCERRR    : std_logic := '0';
  signal TXMEMCRCERRR : std_logic := '0';
  signal TXIOCRCERRR : std_logic := '0';
  signal RXMEMCRCERRR : std_logic := '0';

  signal ALLFW    : std_logic := '0';
  signal RXBCASTW : std_logic := '0';
  signal RXMCASTW : std_logic := '0';
  signal RXUCASTW : std_logic := '0';
  signal MACLW    : std_logic := '0';
  signal MACMW    : std_logic := '0';
  signal MACHW    : std_logic := '0';


  -- PHY signals
  signal phyaddr  : std_logic_vector(31 downto 0) := (others => '0');
  signal phydi    : std_logic_vector(31 downto 0) := (others => '0');
  signal phydo    : std_logic_vector(31 downto 0) := (others => '0');
  signal phyaddrr : std_logic                     := '0';

  signal phystat   : std_logic_vector(31 downto 0) := (others => '0');
  signal lphyreset : std_logic                     := '0';

  -- source filter signals
  signal lmacaddr : std_logic_vector(47 downto 0) := (others => '0');
  signal lrxmcast : std_logic                     := '0';
  signal lrxbcast : std_logic                     := '0';
  signal lrxucast : std_logic                     := '0';
  signal lrxallf  : std_logic                     := '0';

  signal douten : std_logic := '0';

  -- base pointer latches
  signal rxbpl   : std_logic_vector(15 downto 0) := (others => '0');
  signal rxfbbpl : std_logic_vector(15 downto 0) := (others => '0');
  signal txbpl   : std_logic_vector(15 downto 0) := (others => '0');
  signal txfbbpl : std_logic_vector(15 downto 0) := (others => '0');

  -- counters
  signal txfcnt         : std_logic_vector(31 downto 0) := (others => '0');
  signal rxfcnt         : std_logic_vector(31 downto 0) := (others => '0');
  signal txfifowerrcnt  : std_logic_vector(31 downto 0) := (others => '0');
  signal rxfifowerrcnt  : std_logic_vector(31 downto 0) := (others => '0');
  signal rxphyerrcnt    : std_logic_vector(31 downto 0) := (others => '0');
  signal rxoferrcnt     : std_logic_vector(31 downto 0) := (others => '0');
  signal rxcrcerrcnt    : std_logic_vector(31 downto 0) := (others => '0');
  signal rxmemcrcerrcnt : std_logic_vector(31 downto 0) := (others => '0');
  signal txmemcrcerrcnt : std_logic_vector(31 downto 0) := (others => '0');
  signal txiocrcerrcnt : std_logic_vector(31 downto 0) := (others => '0');

  signal txcnt : integer range 0 to 100000 := 0;

  component serialio
    port ( CLK       : in  std_logic;
           RESET     : in  std_logic;
           SCLK      : in  std_logic;
           SCS       : in  std_logic;
           SIN       : in  std_logic;
           SOUT      : out std_logic;
           NEWCMD    : out std_logic;
           DOUTENOUT : out std_logic;
           ADDR      : out std_logic_vector(5 downto 0);
           RW        : out std_logic;
           DOUT      : out std_logic_vector(31 downto 0);
           DIN       : in  std_logic_vector(31 downto 0)
           );
  end component;

  component counter
    port (
      CLK    : in  std_logic;
      CNTRST : in  std_logic;
      INC    : in  std_logic;
      CNT    : out std_logic_vector(31 downto 0)
      );
  end component;

  component sourcefilter
    port (
      CLK     : in  std_logic;
      DIN     : in  std_logic_vector(31 downto 0);
      MACLW   : in  std_logic;
      MACMW   : in  std_logic;
      MACHW   : in  std_logic;
      BCASTW  : in  std_logic;
      MCASTW  : in  std_logic;
      UCASTW  : in  std_logic;
      ALLFW   : in  std_logic;
      MACADDR : out std_logic_vector(47 downto 0);
      RXMCAST : out std_logic;
      RXBCAST : out std_logic;
      RXUCAST : out std_logic;
      RXALLF  : out std_logic
      );
  end component;

  component PHYstatus
    port ( CLK           : in    std_logic;
           PHYDIN        : in    std_logic_vector(15 downto 0);
           PHYDOUT       : out   std_logic_vector(15 downto 0);
           PHYADDRSTATUS : out   std_logic;
           PHYADDR       : in    std_logic_vector(5 downto 0);
           PHYADDRR      : in    std_logic;
           PHYADDRW      : in    std_logic;
           PHYSTAT       : out   std_logic_vector(31 downto 0);
           RESET         : in    std_logic;
           MDIO          : inout std_logic;
           MDC           : out   std_logic;
           DUPLEX        : out   std_logic;
           LINK1000      : out   std_logic;
           LINK100       : out   std_logic;
           ACTIVITY      : out   std_logic);
  end component;

begin


  newcmdw <= newcmd and rw;
  serialio_inst : serialio
    port map (
      CLK       => CLKLO,
      RESET     => RESET,
      SCLK      => SCLK,
      SCS       => SCS,
      SIN       => SIN,
      SOUT      => SOUT,
      NEWCMD    => newcmd,
      DOUTENOUT => douten,
      ADDR      => addr(5 downto 0),
      RW        => rw,
      DOUT      => dout,
      DIN       => din);


  main : process(CLKLO)
  begin
    if rising_edge(CLKLO) then

      -- extra phy registers
      if phyaddrw = '1' then
        phyaddr(30 downto 0) <= dout(30 downto 0);
      end if;

      if phydiw = '1' then
        phydi(31 downto 0) <= dout(31 downto 0);
      end if;

      if phyresetw = '1' then
        lphyreset <= dout(0);
      end if;

      PHYRESET <= lphyreset;

      rxbpl   <= RXBP;
      rxfbbpl <= RXFBBP;
      txbpl   <= TXBP;
      txfbbpl <= TXFBBP;

    end if;
  end process main;

  phyaddrr <= '1' when addr = "01000" and rw = '0' and douten = '1' else '0';

  -- write command assertion table
  phyresetw    <= '1' when addr = X"01" and newcmdw = '1' else '0';
  phyaddrw     <= '1' when addr = X"08" and newcmdw = '1' else '0';
  phydiw       <= '1' when addr = X"09" and newcmdw = '1' else '0';
  rxmemcrcerrr <= '1' when addr = X"0E" and newcmdw = '1' else '0';
  txiocrcerrr  <= '1' when addr = X"0F" and newcmdw = '1' else '0';
  txmemcrcerrr <= '1' when addr = X"10" and newcmdw = '1' else '0';

  txfr        <= '1' when addr = X"11" and newcmdw = '1' else '0';
  rxfr        <= '1' when addr = X"12" and newcmdw = '1' else '0';
  txfifowerrr <= '1' when addr = X"13" and newcmdw = '1' else '0';
  rxfifowerrr <= '1' when addr = X"14" and newcmdw = '1' else '0';
  rxphyerrr   <= '1' when addr = X"15" and newcmdw = '1' else '0';
  rxoferrr    <= '1' when addr = X"16" and newcmdw = '1' else '0';
  rxcrcerrr   <= '1' when addr = X"17" and newcmdw = '1' else '0';

  allfw    <= '1' when addr = X"19" and newcmdw = '1' else '0';
  rxbcastw <= '1' when addr = X"1A" and newcmdw = '1' else '0';
  rxmcastw <= '1' when addr = X"1B" and newcmdw = '1' else '0';
  rxucastw <= '1' when addr = X"1C" and newcmdw = '1' else '0';
  maclw    <= '1' when addr = X"1D" and newcmdw = '1' else '0';
  macmw    <= '1' when addr = X"1E" and newcmdw = '1' else '0';
  machw    <= '1' when addr = X"1F" and newcmdw = '1' else '0';


  din <= X"01234567"                       when addr = X"00" else
         X"0000000" & "000" & lphyreset    when addr = X"01" else
         phystat                           when addr = X"02" else
         X"89ABCDEF"                       when addr = X"03" else
         X"00000000"                       when addr = X"04" else
         X"DEADBEEF"                       when addr = X"05" else
         rxbpl & rxfbbpl                   when addr = X"06" else
         txbpl & txfbbpl                   when addr = X"07" else
         PHYADDR                           when addr = X"08" else
         PHYDI                             when addr = X"09" else
         PHYDO                             when addr = X"0A" else
         X"00000000"                       when addr = X"0B" else
         X"00000000"                       when addr = X"0C" else
         X"00000000"                       when addr = X"0D" else
         rxmemcrcerrcnt                    when addr = X"0E" else
         txiocrcerrcnt                     when addr = X"0F" else
         txmemcrcerrcnt                    when addr = X"10" else
         txfcnt                            when addr = X"11" else
         rxfcnt                            when addr = X"12" else
         txfifowerrcnt                     when addr = X"13" else
         rxfifowerrcnt                     when addr = X"14" else
         rxphyerrcnt                       when addr = X"15" else
         rxoferrcnt                        when addr = X"16" else
         rxcrcerrcnt                       when addr = X"17" else
         X"00000000"                       when addr = X"18" else
         X"0000000" & "000" & lrxallf      when addr = X"19" else
         X"0000000" & "000" & lrxbcast     when addr = X"1A" else
         X"0000000" & "000" & lrxmcast     when addr = X"1B" else
         X"0000000" & "000" & lrxucast     when addr = X"1C" else
         X"0000" & lmacaddr(15 downto 0 )  when addr = X"1D" else
         X"0000" & lmacaddr(31 downto 16 ) when addr = X"1E" else
         X"0000" & lmacaddr(47 downto 32);

  -----------------------------------------------------------------------------
  -- Counters
  -----------------------------------------------------------------------------
  txf_counter : counter
    port map (
      CLK    => CLK,
      INC    => TXF,
      CNTRST => txfr,
      CNT    => txfcnt);

  rxf_counter : counter
    port map (
      CLK    => CLK,
      INC    => RXF,
      CNTRST => rxfr,
      CNT    => rxfcnt);

  txfifowerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => TXFIFOWERR,
      CNTRST => txfifowerrr,
      CNT    => txfifowerrcnt);

  rxfifowerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => RXFIFOWERR,
      CNTRST => rxfifowerrr,
      CNT    => rxfifowerrcnt);

  rxphyerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => RXPHYERR,
      CNTRST => rxphyerrr,
      CNT    => rxphyerrcnt);

  rxoferr_counter : counter
    port map (
      CLK    => CLK,
      INC    => RXOFERR,
      CNTRST => rxoferrr,
      CNT    => rxoferrcnt);

  rxcrcerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => RXCRCERR,
      CNTRST => rxcrcerrr,
      CNT    => rxcrcerrcnt);

  txmemcrcerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => TXMEMCRCERR,
      CNTRST => txmemcrcerrr,
      CNT    => txmemcrcerrcnt);

  txiocrcerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => TXIOCRCERR,
      CNTRST => txiocrcerrr,
      CNT    => txiocrcerrcnt);

  rxmemcrcerr_counter : counter
    port map (
      CLK    => CLK,
      INC    => RXMEMCRCERR,
      CNTRST => rxmemcrcerrr,
      CNT    => rxmemcrcerrcnt);



  sourcefilter_inst : sourcefilter
    port map (
      CLK     => CLKLO,
      DIN     => dout,
      MACLW   => maclw,
      MACMW   => macmw,
      MACHW   => machw,
      BCASTW  => rxbcastw,
      MCASTW  => rxmcastw,
      UCASTW  => rxucastw,
      allfw   => allfw,
      MACADDR => lmacaddr,
      RXMCAST => lrxmcast,
      RXBCAST => lrxbcast,
      RXUCAST => lrxucast,
      RXALLF  => lrxallf);


  PHYstatus_inst : PHYstatus
    port map (
      CLK           => clklo,
      PHYDIN        => phydi(15 downto 0),
      PHYDOUT       => phydo(15 downto 0),
      PHYADDRSTATUS => phyaddr(31),
      PHYADDR       => phyaddr(5 downto 0),
      PHYADDRR      => phyaddrr,
      PHYADDRW      => phyaddrw,
      PHYSTAT       => phystat,
      RESET         => reset,
      MDIO          => MDIO,
      MDC           => MDC,
      DUPLEX        => LEDDPX,
      LINK1000      => LED1000,
      LINK100       => LED100,
      ACTIVITY      => LEDACT);

  -- output process on main clock
  outputs : process(CLK)
  begin
    if rising_edge(CLK) then
      MACADDR <= lmacaddr;
      RXMCAST <= lrxmcast;
      RXBCAST <= lrxbcast;
      RXUCAST <= lrxucast;
      RXALLF  <= lrxallf;


      if txf = '1' then
        txcnt   <= 1000;
      else
        if txcnt > 0 then
          txcnt <= txcnt - 1;
        end if;
      end if;

      if txcnt /= 0 then
        LEDTX <= '1';
      else
        LEDTX <= '0';
      end if;

      LEDRX <= rxf;

    end if;
  end process outputs;


end Behavioral;
