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
      NEXTF   : in  std_logic;
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
  signal NEXTF   : std_logic;
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
    NEXTF   => NEXTF,
    ENDFOUT => ENDFOUT,
    EROUT   => EROUT,
    OFOUT   => OFOUT,
    VALID   => VALID,
    DOUT    => DOUT
    );

  CLK    <= not CLK    after 3.98 ns;   -- slightly faster
  RX_CLK <= not RX_CLK after 4.0 ns;


  -- input data:

  dataout : process


    procedure readFIFO(constant len       : in integer;
                       constant startdata : in std_logic_vector(7 downto 0);
                       constant errorf    : in integer := 0 ) is
      variable                  data      :    std_logic_vector(7 downto 0);
      variable                  done      :    integer := 0;
      variable                  bcnt      :    integer := 0;
    begin
      data                                             := startdata;
      NEXTF   <= '1';
      bcnt                                             := 0;
      done                                             := 0;
      wait until rising_edge(CLK);
      while done = 0 loop
        NEXTF <= '0';
        wait until rising_edge(CLK);
        if VALID = '1' then
          if ENDFOUT = '0' and OFOUT = '0' and EROUT = '0' then
                                        -- normal data read
            bcnt                                       := bcnt + 1;
            assert DOUT(7 downto 0) = data
              report "Data read error"
              severity error;

          else
            if EROUT = '1' or OFOUT = '1' then
              assert errorf /= 0
                report "Frame was an unexpected error"
                severity error;
            end if;
            done := 1;
          end if;

          data := (data(6 downto 0) & data(7));
        end if;
      end loop;


    end procedure readFIFO;


  begin
    wait for 100 ns;
    wait until instate = 1;
    wait for 100 ns;
    readFIFO(100, X"01");
    wait until instate = 3;
    wait for 10 ns;
    readFIFO(200, X"F1");
    readFIFO(300, X"4C");
    readFIFO(50, X"05", 1);
    outstate <= 1;
    wait until instate = 4;
    readFIFO(1500, X"70", 1);
    outstate <= 2;
    wait for 400 ns;
    readFIFO(500, X"48");
    outstate <= 3;
    wait until instate = 5;
    readFIFO(400, X"A7");
    outstate <= 4;
    readFIFO(800, X"75", 1);            -- this one should fail 
    readFIFO(400, X"7B");

    wait;
  end process;

  datain : process

    procedure writeFIFO(constant len       : in integer;
                        constant startdata : in std_logic_vector(7 downto 0);
                        constant errloc    : in integer := -1 ) is

      variable data : std_logic_vector(7 downto 0);
    begin
      data   := startdata;
      for i in 1 to len loop
        RX_DV   <= '1';
        RXD     <= data;
        if i = errloc then
          RX_ER <= '1';
        else
          RX_ER <= '0';
        end if;
        wait until rising_edge(RX_CLK);
        data := (data(6 downto 0) & data(7));
      end loop;
      RX_DV     <= '0';
      wait until rising_edge(RX_CLK);

    end procedure writeFIFO;

  begin
    wait for 100 ns;
    instate <= 1;

    writeFIFO(100, X"01");
    writeFIFO(200, X"F1");
    instate <= 3;
    writeFIFO(300, X"4C");
    writeFIFO(50, X"05", 10);
    wait until outstate = 1;

    -- now, we're going to try and break the fifo
    writeFIFO(1500, X"70");             -- huge fifo
    instate <= 4;
    wait until outstate = 2;
    
    -- can we write to the fifo again without problems?
    writeFIFO(500, X"48");
    wait until outstate = 3;
    
    -- now, we write a good frame followed by an overflow
    writeFIFO(400, X"A7");
    writeFIFO(800, X"75");
    instate <= 5;
    wait until outstate = 4;
    writeFIFO(400, X"7B");

    report "End of Simulation" severity failure;
    wait;
  end process datain;


end;
