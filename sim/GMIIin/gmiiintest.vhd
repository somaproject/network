library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;

entity GMIIintest is
end GMIIintest;

architecture behavior of GMIIintest is

  component gmiiin
    port(
      CLK     : in  std_logic;
      RX_CLK  : in  std_logic;
      RX_ER   : in  std_logic;
      RX_DV   : in  std_logic;
      RXD     : in  std_logic_vector(7 downto 0);
      ENDFOUT : out std_logic;
      EROUT   : out std_logic;
      OFOUT   : out std_logic;
      VALID   : out std_logic;
      DOUT    : out std_logic_vector(7 downto 0)
      );
  end component;



  signal CLK     : std_logic                    := '0';
  signal RX_CLK  : std_logic                    := '0';
  signal RX_ER   : std_logic                    := '0';
  signal RX_DV   : std_logic                    := '0';
  signal RXD     : std_logic_vector(7 downto 0) := (others => '0');
  signal ENDFOUT : std_logic;
  signal EROUT   : std_logic;
  signal OFOUT   : std_logic;
  signal VALID   : std_logic;
  signal DOUT    : std_logic_vector(7 downto 0);

  -- synchronization signals 
  signal instate, outstate : integer   := 0;
  signal simdone           : std_logic := '0';

begin

  gmiiin_uut : gmiiin port map(
    CLK     => CLK,
    RX_CLK  => RX_CLK,
    RX_ER   => RX_ER,
    RX_DV   => RX_DV,
    RXD     => RXD,
    ENDFOUT => ENDFOUT,
    EROUT   => EROUT,
    OFOUT   => OFOUT,
    VALID   => VALID,
    DOUT    => DOUT
    );

  CLK    <= not CLK    after 3.98 ns; -- slightly faster
  RX_CLK <= not RX_CLK after 4.0 ns;  

  datain                : process
    file gmiifile       : text;
    variable L          : line;
    variable rxdv, rxer : integer;
    variable din        : std_logic_vector(7 downto 0) := (others => '0');


  begin

    wait for 200 ns;


    file_open(gmiifile, "gmii.0.dat", read_mode);
    while not endfile(gmiifile) loop
      readline(gmiifile, L);
      wait until rising_edge(RX_CLK);
      read(L, rxdv);
      read(L, rxer);
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
      RXD     <= din;
    end loop;
    wait until rising_edge(RX_CLK);
    RX_DV <= '0';
    
    wait;
  end process;

  dataverify     : process
    file pktfile : text;
    variable L   : line;
    variable len : integer;
    variable din : std_logic_vector(7 downto 0) := (others => '0');


  begin

    wait for 200 ns;


    file_open(pktfile, "pkt.0.dat", read_mode);
    while not endfile(pktfile) loop
      readline(pktfile, L);
      read(L, len);
      dloop: for i in 1 to len loop
        wait until rising_edge(CLK) and VALID = '1';
        exit dloop when OFOUT='1';
          
        hread(L, din);
        assert DOUT = din report "Error reading dout data" severity error;
      end loop;  -- i
      if ENDFOUT = '0' and OFOUT = '0'  then
        wait until rising_edge(CLK) and VALID = '1';        
      end if;

      assert ENDFOUT = '1' report "error with end of frame" severity Error;
    end loop;


    
    wait;
  end process dataverify;

end;
