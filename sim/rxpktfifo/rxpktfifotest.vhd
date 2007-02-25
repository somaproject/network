library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;

entity rxpktfifotest is
end rxpktfifotest;

architecture behavior of rxpktfifotest is

  component rxpktfifo
    port (
      CLK       : in  std_logic;
      -- Input interface
      DIN       : in  std_logic_vector(7 downto 0);
      OFIN      : in  std_logic;
      ERIN      : in  std_logic;
      ENDFIN    : in  std_logic;
      VALIDIN   : in  std_logic;
      -- output interface
      NEXTF     : in  std_logic;
      DOUT      : out std_logic_vector(7 downto 0);
      GMIIOFOUT : out std_logic;
      EROUT     : out std_logic;
      ENDFOUT   : out std_logic;
      OFOUT     : out std_logic;
      VALID     : out std_logic);
  end component;


  signal CLK : std_logic := '0';

  -- Input interface
  signal DIN     : std_logic_vector(7 downto 0) := (others => '0');
  signal OFIN    : std_logic                    := '0';
  signal ERIN    : std_logic                    := '0';
  signal ENDFIN  : std_logic                    := '0';
  signal VALIDIN : std_logic                    := '0';

  -- output interface
  signal NEXTF     : std_logic                    := '0';
  signal DOUT      : std_logic_vector(7 downto 0) := (others => '0');
  signal GMIIOFOUT : std_logic                    := '0';
  signal EROUT     : std_logic                    := '0';
  signal ENDFOUT   : std_logic                    := '0';
  signal OFOUT     : std_logic                    := '0';
  signal VALID     : std_logic                    := '0';


begin

  rxpktfifo_uut : rxpktfifo
    port map (
      CLK       => CLK,
      DIN       => DIN,
      OFIN      => OFIN,
      ERIN      => ERIN,
      ENDFIN    => ENDFIN,
      VALIDIN   => VALIDIN,
      NEXTF     => NEXTF,
      DOUT      => DOUT,
      GMIIOFOUT => GMIIOFOUT,
      EROUT     => EROUT,
      ENDFOUT   => ENDFOUT,
      OFOUT     => OFOUT,
      VALID     => VALID);

  CLK <= not CLK after 8 ns;

  datain                                     : process
    file infile                              : text;
    variable L                               : line;
    variable ofinv, erinv, endfinv, validinv : integer;
    variable dinv                            : std_logic_vector(7 downto 0) := (others => '0');


  begin

    wait for 200 ns;

    file_open(infile, "in.0.dat", read_mode);
    while not endfile(infile) loop
      readline(infile, L);
      wait until rising_edge(CLK);
      read(L, validinv);
      read(L, endfinv);
      read(L, erinv);
      read(L, ofinv);
      hread(L, dinv);

      if validinv = 1 then
        VALIDIN <= '1';
      else
        VALIDIN <= '0';
      end if;

      if endfinv = 1 then
        ENDFIN <= '1';
      else
        ENDFIN <= '0';
      end if;

      if erinv = 1 then
        ERIN <= '1';
      else
        ERIN <= '0';
      end if;

      if ofinv = 1 then
        OFIN <= '1';
      else
        OFIN <= '0';
      end if;

      DIN <= dinv;

    end loop;
    wait until rising_edge(CLK);
    VALIDIN <= '0';
    file_close(infile); 
    wait for 10 us;
    
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
      wait until rising_edge(CLK);
      NEXTF <= '1';
      wait until rising_edge(CLK);
      NEXTF <= '0';

      dloop : for i in 1 to len loop

        wait until rising_edge(CLK) and VALID = '1';
        exit dloop when OFOUT = '1';

        hread(L, din);
        assert DOUT = din report "Error reading dout data" severity error;
      end loop;  -- i
      if ENDFOUT = '0' and OFOUT = '0' then
        wait until rising_edge(CLK) and VALID = '1';
      end if;

      assert ENDFOUT = '1' report "error with end of frame" severity error;
    end loop;

    file_close(pktfile);
    
    file_open(pktfile, "pkt.0.dat", read_mode);
    while not endfile(pktfile) loop
      readline(pktfile, L);
      read(L, len);
      wait until rising_edge(CLK);
      NEXTF <= '1';
      wait until rising_edge(CLK);
      NEXTF <= '0';

      dloop2 : for i in 1 to len loop

        wait until rising_edge(CLK) and VALID = '1';
        exit dloop2 when OFOUT = '1';

        hread(L, din);
        assert DOUT = din report "Error reading dout data" severity error;
      end loop;  -- i
      if ENDFOUT = '0' and OFOUT = '0' then
        wait until rising_edge(CLK) and VALID = '1';
      end if;

      assert ENDFOUT = '1' report "error with end of frame" severity error;

      wait for 1 us;
      
    end loop;

    file_close(pktfile);
    
    wait;
  end process dataverify;

end;
