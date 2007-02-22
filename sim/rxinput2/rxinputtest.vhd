library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;

entity RXinputtest is
end RXinputtest;

architecture behavior of RXinputtest is

  component rxinput
    port(
      RX_CLK     : in  std_logic;
      CLK        : in  std_logic;
      RESET      : in  std_logic;
      RX_DV      : in  std_logic;
      RX_ER      : in  std_logic;
      RXD        : in  std_logic_vector(7 downto 0);
      FIFOFULL   : in  std_logic;
      MACADDR    : in  std_logic_vector(47 downto 0);
      RXBCAST    : in  std_logic;
      RXMCAST    : in  std_logic;
      RXUCAST    : in  std_logic;
      RXALLF     : in  std_logic;
      MD         : out std_logic_vector(31 downto 0);
      MA         : out std_logic_vector(15 downto 0);
      BPOUT      : out std_logic_vector(15 downto 0);
      RXCRCERR   : out std_logic;
      RXOFERR    : out std_logic;
      RXPHYERR   : out std_logic;
      RXFIFOWERR : out std_logic;
      RXF        : out std_logic
      );
  end component;

  signal RX_CLK            : std_logic := '0';
  signal CLK               : std_logic := '0';
  signal RESET             : std_logic := '1';
  signal RX_DV             : std_logic := '0';
  signal RX_ER             : std_logic := '0';
  signal RXD               : std_logic_vector(7 downto 0)
                                       := (others => '0');
  signal MD, MD1, MD2, MD3 :
    std_logic_vector(31 downto 0);
  signal MA, MA1, MA2, MA3 : std_logic_vector(15 downto 0);
  signal BPOUT             : std_logic_vector(15 downto 0);
  signal RXCRCERR          : std_logic := '0';
  signal RXOFERR           : std_logic := '0';
  signal RXPHYERR          : std_logic := '0';
  signal RXFIFOWERR        : std_logic := '0';
  signal FIFOFULL          : std_logic := '0';
  signal RXF               : std_logic := '0';
  signal MACADDR           : std_logic_vector(47 downto 0)
                                       := (others => '0');
  signal RXBCAST           : std_logic := '0';
  signal RXMCAST           : std_logic := '0';
  signal RXUCAST           : std_logic := '0';
  signal RXALLF            : std_logic := '0';

begin


  MACADDR <= X"00003F000100";
  RXALLF  <= '1';

  uut : rxinput
    port map(
      RX_CLK     => RX_CLK,
      CLK        => CLK,
      RESET      => RESET,
      RX_DV      => RX_DV,
      RX_ER      => RX_ER,
      RXD        => RXD,
      MD         => MD,
      MA         => MA,
      BPOUT      => BPOUT,
      RXCRCERR   => RXCRCERR,
      RXOFERR    => RXOFERR,
      RXPHYERR   => RXPHYERR,
      RXFIFOWERR => RXFIFOWERR,
      FIFOFULL   => FIFOFULL,
      RXF        => RXF,
      MACADDR    => MACADDR,
      RXBCAST    => RXBCAST,
      RXMCAST    => RXMCAST,
      RXUCAST    => RXUCAST,
      RXALLF     => RXALLF
      );

  RX_CLK <= not RX_CLK after 3.98 ns;
  CLK    <= not CLK    after 4 ns;

  process
  begin
    wait until rising_edge(RXOFERR);
    report "RXOFERR!!!" severity failure;

  end process;


  process
    file gmiifile       : text;
    variable L          : line;
    variable rxdv, rxer : integer                      := 0;
    variable din        : std_logic_vector(7 downto 0) := (others => '0');

  begin
    RESET <= '0' after 40 ns;
    wait for 200 ns;


    file_open(gmiifile, "gmiiin.0.dat", read_mode);
    while not endfile(gmiifile) loop
      readline(gmiifile, L);
      wait until rising_edge(RX_CLK);
      read(L, rxer);
      read(L, rxdv);
      hread(L, din);
      if rxdv = 1 then
        RX_DV <= '1';
      else
        RX_DV <= '0';
      end if;

      if rxER = 1 then
        RX_ER <= '1';
      else
        RX_ER <= '0';
      end if;

      RXD <= din;
    end loop;
  end process;

END;
