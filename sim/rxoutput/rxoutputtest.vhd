
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;

entity rxoutputtest is
end rxoutputtest;

architecture behavior of rxoutputtest is

  component rxoutput
    port(
      CLK       : in  std_logic;
      CLKEN     : in  std_logic;
      RESET     : in  std_logic;
      BPIN      : in  std_logic_vector(15 downto 0);
      MQ        : in  std_logic_vector(31 downto 0);
      CLKIO     : in  std_logic;
      NEXTFRAME : in  std_logic;
      MEMCRCERR : out std_logic; 
      FBBP      : out std_logic_vector(15 downto 0);
      MA        : out std_logic_vector(15 downto 0);
      DOUT      : out std_logic_vector(15 downto 0);
      DOUTEN    : out std_logic
      );
  end component;

  signal CLK          : std_logic := '0';
  signal CLKEN        : std_logic := '0';
  signal RESET        : std_logic := '1';
  signal BPIN         : std_logic_vector(15 downto 0);
  signal FBBP         : std_logic_vector(15 downto 0);
  signal MA           : std_logic_vector(15 downto 0);
  signal MQ           : std_logic_vector(31 downto 0);
  signal CLKIO        : std_logic := '0';
  signal NEXTFRAME    : std_logic := '0';
  signal MEMCRCERR    : std_logic := '0';
  signal DOUT         : std_logic_vector(15 downto 0);
  signal DOUTEN       : std_logic;
  signal READDATA     : std_logic_vector(31 downto 0)
                                  := (others => '0');
  signal DOUTEXPECTED : std_logic_vector(15 downto 0)
                                  := (others => '0');
begin

  uut : rxoutput port map(
    CLK       => CLK,
    CLKEN     => CLKEN,
    RESET     => RESET,
    BPIN      => BPIN,
    FBBP      => FBBP,
    MA        => MA,
    MQ        => MQ,
    MEMCRCERR => MEMCRCERR, 
    CLKIO     => CLKIO,
    NEXTFRAME => NEXTFRAME,
    DOUT      => DOUT,
    DOUTEN    => DOUTEN
    );



  CLK   <= not CLK   after 4 ns;
  --CLKIO <= not CLKIO after 8.4 ns; 
  CLKIO <= not CLKIO after 10 ns;

  RESET <= '0' after 40 ns;

  -- clken 
  clkenlatch     : process(CLK)
    variable cnt : integer := 0;
  begin
    if rising_edge(CLK) and RESET = '0' then
      if cnt = 3 then
        cnt                := 0;
      else
        cnt                := cnt + 1;
      end if;
      if cnt = 3 then
        CLKEN <= '1' after 2 ns;
      else
        CLKEN <= '0' after 2 ns;
      end if;

    end if;
  end process;

  bpfollower                                : process is
                        file bpfile         : text;
                      variable L            : line;
                      variable bpold, bpnew : std_logic_vector(15 downto 0)
 := (others => '0');
  begin
    wait until falling_edge(RESET);
    file_open(bpfile, "bp.dat", read_mode);
    while not endfile(bpfile) loop
      wait until rising_edge(CLK);
      readline(bpfile, L);
      hread(L, bpold);
      hread(L, bpnew);
      while fbbp /= bpin loop
        wait until rising_edge(CLK);
      end loop;
      BPIN <= bpnew;

    end loop;
  end process bpfollower;


  memdata                      : process(CLK, RESET)
    file memfile               : text;
    variable L                 : line;
    variable inaddr, addr      : std_logic_vector(15 downto 0)
                                         := (others => '0');
    variable indata, data, mdl : std_logic_vector(31 downto 0)
                                         := (others => '0');
    variable md1, md2, md3, md4, md5, md6, md7
                               : std_logic_vector(31 downto 0)
                                         := (others => '0');
    variable memfilepos        : integer := 0;

    type ramtype is array(2**16 -1 downto 0) of integer;
    variable ram : ramtype                    := (others => 0);
  begin
    if falling_edge(RESET) then
    else
      if rising_edge(CLK) and RESET = '0' then
        if MA = X"0000" and memfilepos = 0 then
          file_open(memfile, "ram.0.low.dat", read_mode);
          while not endfile(memfile) loop
            readline(memfile, L);
            hread(L, inaddr);
            hread(L, indata);
            ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata));
          end loop;
          file_close(memfile);
          memfilepos                          := 1;
        elsif MA = X"4000" and memfilepos = 1 then
          file_open(memfile, "ram.0.high.dat", read_mode);
          while not endfile(memfile) loop
            readline(memfile, L);
            hread(L, inaddr);
            hread(L, indata);
            ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata));
          end loop;
          file_close(memfile); memfilepos     := 2;
        elsif MA = X"F000" and memfilepos = 2 then
          file_open(memfile, "ram.1.low.dat", read_mode);
          while not endfile(memfile) loop
            readline(memfile, L);
            hread(L, inaddr);
            hread(L, indata);
            ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata));
          end loop;
          file_close(memfile); memfilepos     := 3;
        elsif MA = X"4000" and memfilepos = 3 then
          file_open(memfile, "ram.1.high.dat", read_mode);
          while not endfile(memfile) loop
            readline(memfile, L);
            hread(L, inaddr);
            hread(L, indata);
            ram(to_integer(unsigned(inaddr))) := to_integer(signed(indata));
          end loop;
          file_close(memfile); memfilepos     := 4;
        end if;

        if CLKEN = '1' then
          data := std_logic_vector(to_signed(ram(to_integer(unsigned(MA))), 32));
        end if;
        md6    := md5;
        md5    := md4;
        md4    := md3;
        md3    := md2;
        md2    := md1;
        md1    := data;

        MQ <= md5;
      end if;
    end if;
  end process memdata;

  checkdata                          : process
    file datafile                    : text;
    variable L                       : line;
    variable words, nops, wcnt, ncnt : integer := 0;
    variable rdata                   : std_logic_vector(15 downto 0)
                                               := (others => '0');
  begin
    wait until falling_edge(RESET);
    file_open(datafile, "data.dat", read_mode);
    words                                      := 0;
    nops                                       := 0;
    wait until rising_edge(CLKIO);
    NEXTFRAME <= '0';
    while not endfile(datafile) loop
      readline(datafile, L);
      read(L, nops);
      read(L, words);
      ncnt                                     := -1; 
      while ncnt < nops loop
        wait until rising_edge(CLKIO);
        ncnt := ncnt + 1; 
      end loop;
      wcnt := 0; 
      NEXTFRAME <= '1' after 10 ns; 
      while wcnt < words loop
        wait until rising_edge(CLKIO) and DOUTEN = '1'; 
        wcnt := wcnt + 1;
        hread(L, rdata); 
        DOUTEXPECTED <= rdata; 
        assert rdata = DOUT 
          report "error reading data"
          severity error;
        
      end loop; 
      NEXTFRAME <= '0' after 10 ns; 

    end loop; 

    report "End of Simulation"
      severity failure;  
    
  end process checkdata; 	

END;
