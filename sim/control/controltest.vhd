
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controltest is
end controltest;

architecture behavior of controltest is

  component control
    port(
      CLK        : in    std_logic;
      CLKLO      : in    std_logic;
      RESET      : in    std_logic;
      SCLK       : in    std_logic;
      SCS        : in    std_logic;
      SIN        : in    std_logic;
      TXF        : in    std_logic;
      RXF        : in    std_logic;
      TXFIFOWERR : in    std_logic;
      RXFIFOWERR : in    std_logic;
      RXPHYERR   : in    std_logic;
      RXOFERR    : in    std_logic;
      RXCRCERR   : in    std_logic;
      MDEBUGDATA : in    std_logic_vector(31 downto 0);
      RXBP       : in    std_logic_vector(15 downto 0);
      RXFBBP     : in    std_logic_vector(15 downto 0);
      TXBP       : in    std_logic_vector(15 downto 0);
      TXFBBP     : in    std_logic_vector(15 downto 0);
      MDIO       : inout std_logic;
      SOUT       : out   std_logic;
      LEDACT     : out   std_logic;
      LEDTX      : out   std_logic;
      LEDRX      : out   std_logic;
      LED100     : out   std_logic;
      LED1000    : out   std_logic;
      LEDDPX     : out   std_logic;
      PHYRESET   : out   std_logic;
      RXBCAST    : out   std_logic;
      RXMCAST    : out   std_logic;
      RXUCAST    : out   std_logic;
      RXALLF     : out   std_logic;
      MACADDR    : out   std_logic_vector(47 downto 0);
      MDC        : out   std_logic;
      MDEBUGADDR : out   std_logic_vector(16 downto 0)
      );
  end component;

  component GMII is
                   port ( MDIO : inout std_logic;
                          MDC  : in    std_logic;
                          DONE : out   std_logic);
  end component;

  signal CLK        : std_logic := '0';
  signal CLKLO      : std_logic := '0';
  signal RESET      : std_logic := '0';
  signal SCLK       : std_logic := '0';
  signal SCS        : std_logic := '0';
  signal SIN        : std_logic := '0';
  signal SOUT       : std_logic := '0';
  signal LEDACT     : std_logic := '0';
  signal LEDTX      : std_logic := '0';
  signal LEDRX      : std_logic := '0';
  signal LED100     : std_logic := '0';
  signal LED1000    : std_logic := '0';
  signal LEDDPX     : std_logic := '0';
  signal PHYRESET   : std_logic := '0';
  signal TXF        : std_logic := '0';
  signal RXF        : std_logic := '0';
  signal TXFIFOWERR : std_logic := '0';
  signal RXFIFOWERR : std_logic := '0';
  signal RXPHYERR   : std_logic := '0';
  signal RXOFERR    : std_logic := '0';
  signal RXCRCERR   : std_logic := '0';
  signal RXBCAST    : std_logic := '0';
  signal RXMCAST    : std_logic := '0';
  signal RXUCAST    : std_logic := '0';
  signal RXALLF     : std_logic := '0';
  signal MACADDR    : std_logic_vector(47 downto 0) := (others => '0'); 
  signal MDIO       : std_logic := '0';
  signal MDC        : std_logic := '0';
  signal MDEBUGADDR : std_logic_vector(16 downto 0) := (others => '0'); 
  signal MDEBUGDATA : std_logic_vector(31 downto 0) := (others => '0'); 
  signal RXBP       : std_logic_vector(15 downto 0) := (others => '0'); 
  signal RXFBBP     : std_logic_vector(15 downto 0) := (others => '0'); 
  signal TXBP       : std_logic_vector(15 downto 0) := (others => '0'); 
  signal TXFBBP     : std_logic_vector(15 downto 0) := (others => '0'); 
  signal GMIIDONE   : std_logic := '0';

  signal serialdin, serialdout   : std_logic_vector(31 downto 0)
                                             := (others => '0');
  signal serialaddr              : std_logic_vector(6 downto 0)
                                             := (others => '0');
  signal serialrw                : std_logic := '0';
  signal serialstart, serialdone : std_logic := '0';

  signal status : integer := 0;
  
begin

  uut : control port map(
    CLK        => CLK,
    CLKLO      => CLKLO,
    RESET      => RESET,
    SCLK       => SCLK,
    SCS        => SCS,
    SIN        => SIN,
    SOUT       => SOUT,
    LEDACT     => LEDACT,
    LEDTX      => LEDTX,
    LEDRX      => LEDRX,
    LED100     => LED100,
    LED1000    => LED1000,
    LEDDPX     => LEDDPX,
    PHYRESET   => PHYRESET,
    TXF        => TXF,
    RXF        => RXF,
    TXFIFOWERR => TXFIFOWERR,
    RXFIFOWERR => RXFIFOWERR,
    RXPHYERR   => RXPHYERR,
    RXOFERR    => RXOFERR,
    RXCRCERR   => RXCRCERR,
    RXBCAST    => RXBCAST,
    RXMCAST    => RXMCAST,
    RXUCAST    => RXUCAST,
    RXALLF     => RXALLF,
    MACADDR    => MACADDR,
    MDIO       => MDIO,
    MDC        => MDC,
    MDEBUGADDR => MDEBUGADDR,
    MDEBUGDATA => MDEBUGDATA,
    RXBP       => RXBP,
    RXFBBP     => RXFBBP,
    TXBP       => TXBP,
    TXFBBP     => TXFBBP
    );

  gmii_io : gmii port map (
    MDC  => MDC,
    MDIO => MDIO,
    DONE => GMIIDONE);


  clk   <= not clk   after 4 ns;
  CLKLO <= not CLKLO after 4*8 ns;

  serialio : process
  begin
    while true loop
      SCLK <= '0';
      wait until rising_edge(serialstart);
      SCS  <= '0';
      wait for 1 us;
      SIN  <= serialrw;
      wait for 0.5 us;
      SCLK <= '1';
      wait for 1 us;
      SCLK <= '0';
      wait for 0.5 us;

      for i in 6 downto 0 loop
        SIN  <= serialaddr(i);
        wait for 0.5 us;
        SCLK <= '1';
        wait for 1 us;
        SCLK <= '0';
        wait for 0.5 us;
      end loop;

      -- input and output
      for i in 31 downto 0 loop
        SIN           <= serialdin(i);
        wait for 0.5 us;
        serialdout(i) <= SOUT;
        SCLK          <= '1';
        wait for 1 us;
        SCLK          <= '0';
        wait for 0.5 us;
      end loop;
      SCS             <= '1';
      serialdone      <= '1';
      wait for 1 ns;
      serialdone      <= '0';
    end loop;
  end process;



  main                   : process
    procedure sread(addr : integer) is
    begin
      wait for 100 us;
      serialrw    <= '0';               -- read
      serialaddr  <= std_logic_vector(to_signed(addr, 7));
      serialstart <= '1';
      wait until rising_edge(serialdone);
      serialstart <= '0';
    end sread;

    procedure swrite(addr : integer;
                     data : std_logic_vector(31 downto 0)) is
    begin
      wait for 100 us;
      serialrw    <= '1';               -- write
      serialaddr  <= std_logic_vector(to_signed(addr, 7));
      serialdin   <= data;
      serialstart <= '1';
      wait until rising_edge(serialdone);
      serialstart <= '0';

    end swrite;


  begin
    wait for 100 us;
    --wait until PHYRESET = '1';
    -- first, we test the debug readout
    sread(0);
    status <= 1; 
    assert serialdout = X"01234567"
      report "Error reading debug output at address 0"
      severity error;

    -- test the phy reset
    swrite(1, X"00000001");
    status <= 2; 
    wait until rising_edge(CLKLO) and PHYRESET = '1';

    -- test the write-to-phy skills
    -- we first write ABCD to location 0
    status <= 3; 

    swrite(9, X"0000ABCD");             -- write PHYDI
    swrite(8, X"00000020");             -- write PHYA
    sread(8);
    while serialdout(31) /= '1' loop
      sread(8);
    end loop;
    status <= 4; 

    -- then we write 1234 to location 1
    swrite(9, X"00001234");             -- write PHYDI
    swrite(8, X"00000021");             -- write PHYA
    sread(8);
    while serialdout(31) /= '1' loop
      sread(8);
    end loop;


    -- now we try to read back ABCD from loc 0
    status <= 5; 
    swrite(8, X"00000000");             -- write PHYA
    sread(8);
    while serialdout(31) /= '1' loop
      sread(8);
    end loop;

    sread(10);
    if serialdout(15 downto 0) /= X"ABCD" then
      report "Error reading back from PHY at address 0";
    end if;

    -- now, write to 11 and F, and try and set PHYSTAT
    status <= 10; 
    swrite(9, X"00007817");             -- write PHYDI        
    swrite(8, X"00000031");             -- write PHYA, loc = 0x11
    sread(8);
    while serialdout(31) /= '1' loop
      sread(8);
    end loop;

    swrite(9, X"0000AC57");             -- write PHYDI        
    swrite(8, X"0000002F");             -- write PHYA, loc = 0xF
    sread(8);
    while serialdout(31) /= '1' loop
      sread(8);
    end loop;

    wait for 0.5 ms;                    -- delay to allow PHYSTAT To be updated

    -- now, read back phystat
    status <= 20; 
    sread(2);
    if serialdout /= X"AC577817" then
      report "Error writing to PHY STATUS registers";
    end if;
    status <= 30; 

    if LEDACT /= '1' or LEDDPX /= '1' then
      report "Error setting LEDs";
    end if;
    status <= 40; 


    -- trigger the counters and see what we get:

    for i in 1 to 32768 loop
      if i mod 1 = 0 then
        TXF        <= '1';
      else
        TXF        <= '0';
      end if;
      if i mod 2 = 0 then
        RXF        <= '1';
      else
        RXF        <= '0';
      end if;
      if i mod 4 = 0 then
        TXFIFOWERR <= '1';
      else
        TXFIFOWERR <= '0';
      end if;
      if i mod 8 = 0 then
        RXFIFOWERR <= '1';
      else
        RXFIFOWERR <= '0';
      end if;
      if i mod 16 = 0 then
        RXPHYERR   <= '1';
      else
        RXPHYERR   <= '0';
      end if;
      if i mod 32 = 0 then
        RXOFERR    <= '1';
      else
        RXOFERR    <= '0';
      end if;
      if i mod 64 = 0 then
        RXCRCERR   <= '1';
      else
        RXCRCERR   <= '0';
      end if;


      wait until rising_edge(CLK);
    end loop;
      status <= 50; 
    
    TXF        <= '0';
    RXF        <= '0';
    TXFIFOWERR <= '0';
    RXFIFOWERR <= '0';
    RXPHYERR   <= '0';
    RXOFERR    <= '0';
    RXCRCERR   <= '0';



    sread(17);
    assert serialdout = X"00008000"
      report "Error counting TXF"
      severity error;

    sread(18);
    assert serialdout = X"00004000"
      report "Error counting RXF"
      severity error;

    sread(19);
    assert serialdout = X"00002000"
      report "Error counting TXFIFOWERR"
      severity error;

    sread(20);
    assert serialdout = X"00001000"
      report "Error counting RXFIFOWERR"
      severity error;


    sread(21);
    assert serialdout = X"00000800"
      report "Error counting RXPHYERR"
      severity error;

    sread(22);
    assert serialdout = X"00000400"
      report "Error counting RXOFERR"
      severity error;

    sread(23);
    assert serialdout = X"00000200"
      report "Error counting RXCRCERR"
      severity error;

    swrite(17, X"00000001");
    sread(17);
    assert serialdout = X"00000000"
      report "TXF Reset Failed"
      severity error;

    swrite(18, X"00000002");
    sread(18);
    assert serialdout = X"00000000"
      report "RXF Reset Failed"
      severity error;

    swrite(19, X"00000004");
    sread(19);
    assert serialdout = X"00000000"
      report "TXFIFOWERR Reset Failed"
      severity error;

    swrite(20, X"00000008");
    sread(20);
    assert serialdout = X"00000000"
      report "RXFIFOWERR Reset Failed"
      severity error;

    swrite(21, X"00000010");
    sread(21);
    assert serialdout = X"00000000"
      report "RXPHYERR Reset Failed"
      severity error;

    swrite(22, X"00000020");
    sread(22);
    assert serialdout = X"00000000"
      report "RXOFERR Reset Failed"
      severity error;


    -- now, try setting the mac addresses
    swrite(29, X"00001234");
    swrite(30, X"00005678");
    swrite(31, X"0000ABCD");
    sread(29);
    assert serialdout = X"00001234"
      report "MACADDR low-word write failed"
      severity error;
    sread(30);
    assert serialdout = X"00005678"
      report "MACADDR mid-word write failed"
      severity error;
    sread(31);
    assert serialdout = X"0000ABCD"
      report "MACADDR high-word write failed"
      severity error;

    assert false
      report "End of Simulation"
      severity failure;





  end process;



end;
