library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use std.TextIO.all;
use ieee.numeric_std.all;


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

  signal RX_CLK     : std_logic                     := '0';
  signal CLK        : std_logic                     := '0';
  signal RESET      : std_logic                     := '1';
  signal RX_DV      : std_logic                     := '0';
  signal RX_ER      : std_logic                     := '0';
  signal RXD        : std_logic_vector(7 downto 0)
                                                    := (others => '0');
  signal MD :
    std_logic_vector(31 downto 0)                   := (others => '0');
  signal MA         : std_logic_vector(15 downto 0) := (others => '0');
  signal BPOUT      : std_logic_vector(15 downto 0);
  signal RXCRCERR   : std_logic                     := '0';
  signal RXOFERR    : std_logic                     := '0';
  signal RXPHYERR   : std_logic                     := '0';
  signal RXFIFOWERR : std_logic                     := '0';
  signal FIFOFULL   : std_logic                     := '0';
  signal RXF        : std_logic                     := '0';
  signal MACADDR    : std_logic_vector(47 downto 0)
                                                    := (others => '0');
  signal RXBCAST    : std_logic                     := '0';
  signal RXMCAST    : std_logic                     := '0';
  signal RXUCAST    : std_logic                     := '0';
  signal RXALLF     : std_logic                     := '0';

  type rambuffer_t is array (0 to 2**16-1) of std_logic_vector(31 downto 0);


  signal verify_pos : integer := -1;
  
  -------------------------------------------------------------------------------
  function vec_image(arg     : std_logic_vector) return string is
    -- recursive function call turns ('1','0','1') into "101"
    -- Mike Treseler
    constant arg_norm        : std_logic_vector(1 to arg'length) := arg;
    constant center          : natural                           := 2;
                                        -- point to the character in '1'
    variable just_the_number : character;  -- the 1 or 0 inside the ' '
    variable bit_image       : string(1 to 3);
  begin
    if (arg'length > 0) then
      bit_image                                                  := std_logic'image( arg_norm(1) );  -- is   "'0'"
      just_the_number                                            := bit_image(center);  -- want "0"
      return just_the_number            -- do the first digit
        & vec_image(arg_norm(2 to arg_norm'length));  -- do rest same way
    else
      return "";                        -- until "the rest" is nothing
    end if;
  end function vec_image;
  --------------------------------------------------------------------------
  function vec_image(arg     : unsigned) return string is

  begin
    return vec_image(std_logic_vector(arg));
  end function vec_image;


    procedure verify_ram (
    filename  : in string;
    rambuffer : in rambuffer_t) is

    file ramfile           : text;
    variable L             : line;
    variable din           : std_logic_vector(31 downto 0) := (others => '0');
    variable dinint        : integer                       := 0;
    variable len           : integer                       := 0;
    variable rampos, startrampos        : integer                       := 0;
    variable pendingerrors : boolean                       := false;
  begin
    file_open(ramfile, filename, read_mode);

    while not endfile(ramfile) loop
      startrampos := rampos; 
      readline(ramfile, L);
      read(L, len);
      for i in 0 to len -1 loop
        hread(L, din);
        assert rambuffer(rampos) = din
          report "Error with ram address " & integer'image(rampos) & " " &
          vec_image(din) & " != "
          & vec_image(rambuffer(rampos)) severity error;
        if rambuffer(rampos) /= din then
          pendingerrors := true;
        end if;

        rampos := rampos + 1;
      end loop;  -- i
      if pendingerrors = false then
        report "Read frame which began at location " & integer'image(startrampos)
          & " without errors" severity note;
      end if;

    end loop;
  end procedure verify_ram;


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

  RX_CLK <= not RX_CLK after 4.0 ns;
  CLK    <= not CLK    after 3.9 ns;

  process
  begin
    wait until rising_edge(RXCRCERR);
    report "RXCRCERR!!!" severity error;

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

    wait for 1 us;
    -- verify ram contents
    verify_pos <= 0; 

    wait;
  end process;

  -- memory clock output
  fakeram : process(CLK, verify_pos)
    variable rambuffer : rambuffer_t := (others => (others => '0'));
    variable rpos : integer := 0;
    
  begin
    if rising_edge(CLK) then
      if rpos = 3 then
        rpos := 0;
        rambuffer(to_integer(unsigned(MA))) := MD;
      else
        rpos := rpos + 1; 
      end if;
    end if;

    if verify_pos'EVENT then
      verify_ram("ram." & integer'image(verify_pos) & ".dat", rambuffer); 
    end if;

  end process fakeram;
end;

