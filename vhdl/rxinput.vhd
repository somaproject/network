library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;

entity RXinput is
  port ( RX_CLK     : in  std_logic;
         CLK        : in  std_logic;
         RESET      : in  std_logic;
         RX_DV      : in  std_logic;
         RX_ER      : in  std_logic;
         RXD        : in  std_logic_vector(7 downto 0);
         MD         : out std_logic_vector(31 downto 0);
         MA         : out std_logic_vector(15 downto 0);
         BPOUT      : out std_logic_vector(15 downto 0);
         RXCRCERR   : out std_logic;
         RXOFERR    : out std_logic;
         RXPHYERR   : out std_logic;
         RXFIFOWERR : out std_logic;
         FIFOFULL   : in  std_logic;
         RXF        : out std_logic;
         MACADDR    : in  std_logic_vector(47 downto 0);
         RXBCAST    : in  std_logic;
         RXMCAST    : in  std_logic;
         RXUCAST    : in  std_logic;
         RXALLF     : in  std_logic);
end RXinput;

architecture Behavioral of RXinput is

  -- signals to interface with the GMII
  signal endf, dv, er, ovf, nextf : std_logic := '0';
  signal erl, ofl                 : std_logic := '0';
  signal data, datal              : std_logic_vector(7 downto 0)
                                              := (others => '0');

  -- memory data signals
  signal lm, lml : std_logic_vector(31 downto 0)
 := (others => '0');

  -- general control signal
  signal mwen, fd, bpwen, bpwenl, rd : std_logic := '0';

  -- byte counter
  signal bcnt : std_logic_vector(15 downto 0)
 := (others => '0');

  -- addr count and register
  signal lbp, lma, macnt : std_logic_vector(15 downto 0)
 := (others => '0');

  -- crc signals
  signal crc, crcl, crcll : std_logic_vector(31 downto 0)
                                      := (others => '0');
  signal fdl, crcvalid    : std_logic := '0';

  signal destok : std_logic := '0';

  -- states
  type states is (none, waitsfd, b0wr, b1wr, b2wr, b3wr,
                  checkf, lastwait0,
                  lastwait1, lastwait2, lastwait3,
                  bpwait0, bpwait1, bpwait2,
                  wwait0, wwait1, wwait2,
                  bpwait3, validf);
  signal cs, ns : states := none;



  component crc_combinational
    port ( CI : in  std_logic_vector(31 downto 0);
           D  : in  std_logic_vector(7 downto 0);
           CO : out std_logic_vector(31 downto 0));
  end component;

  component GMIIin
    port ( CLK     : in  std_logic;
           RX_CLK  : in  std_logic;
           RX_ER   : in  std_logic;
           RX_DV   : in  std_logic;
           RXD     : in  std_logic_vector(7 downto 0);
           NEXTF   : in  std_logic;
           ENDFOUT : out std_logic;
           EROUT   : out std_logic;
           OFOUT   : out std_logic;
           VALID   : out std_logic;
           DOUT    : out std_logic_vector(7 downto 0));
  end component;

  component RXValid
    port ( CLK     : in  std_logic;
           RESET   : in  std_logic;
           DATA    : in  std_logic_vector(7 downto 0);
           MACADDR : in  std_logic_vector(47 downto 0);
           RXBCAST : in  std_logic;
           RXMCAST : in  std_logic;
           RXUCAST : in  std_logic;
           RXALLF  : in  std_logic;
           DESTOK  : out std_logic;
           FD      : in  std_logic;
           NEXTF   : in  std_logic);
  end component;

begin

  crccomp : crc_combinational
    port map (
      CI => crcl,
      CO => crc,
      D  => datal);

  gmii : GMIIin
    port map (
      CLK     => CLK,
      RX_CLK  => RX_CLK,
      RX_ER   => RX_ER,
      RX_DV   => RX_DV,
      RXD     => RXD,
      NEXTF   => nextf,
      ENDFOUT => endf,
      EROUT   => er,
      OFOUT   => ovf,
      VALID   => dv,
      DOUT    => data);

  maccheck : RXValid
    port map (
      CLK     => CLK,
      RESET   => RESET,
      DATA    => data,
      MACADDR => MACADDR,
      RXBCAST => RXBCAST,
      RXMCAST => RXMCAST,
      RXUCAST => RXUCAST,
      RXALLF  => RXALLF,
      DESTOK  => destok,
      FD      => fd,
      NEXTF   => nextf);

  fd    <= rd and dv and (not endf);
  BPOUT <= lbp;

  main : process(RESET, CLK)
  begin
    if RESET = '1' then
      cs   <= none;
    else
      if rising_edge(CLK) then
        cs <= ns;

        -- data latching
        if cs = b0wr and fd = '1' then
          lm(15 downto 8)   <= data;
        end if;
        if cs = b1wr and fd = '1' then
          lm(7 downto 0)  <= data;
        end if;
        if cs = b2wr and fd = '1' then
          lm(31 downto 24) <= data;
        end if;
        if cs = b3wr and fd = '1' then
          lm(23 downto 16) <= data;
        end if;


        if mwen = '1' and               -- fd = '1' then
          rd = '1' and dv = '1' then
          lml <= lm;
        end if;


        if cs = none then
          bcnt   <= X"0000";
        else
          if fdl = '1' then
            bcnt <= bcnt + 1;
          end if;
        end if;
        bpwenl   <= bpwen;

        if bpwenl = '0' then
          MD <= lml;
        else
          MD <= (X"0000" & bcnt);
        end if;

        if cs = none then
          ofl   <= '0';
        else
          if endf = '1' and dv = '1' then
            ofl <= ovf;
          end if;
        end if;

        if cs = none then
          erl   <= '0';
        else
          if endf = '1' and dv = '1' then
            erl <= er;
          end if;
        end if;



        -- memory address
        if cs = validf then
          lbp <= macnt;
        end if;

        if cs = none then
          macnt   <= lbp;
        else
          if mwen = '1' and fd = '1' then
            macnt <= macnt + 1;
          end if;
        end if;

        if mwen = '1' then
          if bpwen = '1' then
            lma <= lbp;
          else
            lma <= macnt;
          end if;
        end if;

        MA <= lma;

        -- crc code:
        datal    <= data;
        fdl      <= fd;
        if cs = none then
          crcl   <= (others => '1');
        else
          if fdl = '1' then
            crcl <= crc;
          end if;
        end if;

        crcll      <= crcl;
        if crcll = X"C704DD7B" then
          crcvalid <= '1';
        else
          crcvalid <= '0';
        end if;

        -- output signal latches
        if cs = validf then
          RXF <= '1';
        else
          RXF <= '0';
        end if;

        if cs = checkf and ofl = '1' then
          RXOFERR <= '1';
        else
          RXOFERR <= '0';
        end if;

        if cs = checkf and fifofull = '1' then
          RXFIFOWERR <= '1';
        else
          RXFIFOWERR <= '0';
        end if;

        if cs = bpwait3 and crcvalid = '0' then
          RXCRCERR <= '1';
        else
          RXCRCERR <= '0';
        end if;

        if cs = checkf and erl = '1' then
          RXPHYERR <= '1';
        else
          RXPHYERR <= '0';
        end if;

      end if;
    end if;
  end process main;



  fsm : process (cs, ns, dv, data, endf, FIFOFULL,
                 crcvalid)
  begin
    case cs is
      when none    =>
        rd     <= '0';
        mwen   <= '0';
        nextf  <= '1';
        bpwen  <= '0';
        ns     <= waitsfd;
      when waitsfd =>
        rd     <= '0';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        if dv = '1' and data = "11010101" then
          ns   <= b0wr;
        else
          ns   <= waitsfd;
        end if;
      when b0wr    =>
        rd     <= '1';
        mwen   <= '1';
        nextf  <= '0';
        bpwen  <= '0';
        if dv = '1' then
          if endf = '0' then
            ns <= b1wr;
          else
            ns <= wwait0;
          end if;
        else
          ns   <= b0wr;
        end if;
      when b1wr    =>
        rd     <= '1';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        if dv = '1' then
          if endf = '0' then
            ns <= b2wr;
          else
            ns <= wwait1;
          end if;
        else
          ns   <= b1wr;
        end if;
      when b2wr    =>
        rd     <= '1';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        if dv = '1' then
          if endf = '0' then
            ns <= b3wr;
          else
            ns <= wwait2;
          end if;
        else
          ns   <= b2wr;
        end if;
      when b3wr    =>
        rd     <= '1';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        if dv = '1' then
          if endf = '0' then
            ns <= b0wr;
          else
            ns <= checkf;
          end if;
        else
          ns   <= b3wr;
        end if;
      when wwait0  =>
        rd     <= '0';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        ns     <= wwait1;
      when wwait1  =>
        rd     <= '0';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        ns     <= wwait2;
      when wwait2  =>
        rd     <= '0';
        mwen   <= '0';
        nextf  <= '0';
        bpwen  <= '0';
        ns     <= checkf;

      when checkf  =>
        rd    <= '1';
        mwen  <= '1';
        nextf <= '0';
        bpwen <= '0';
        if erl = '1' or ofl = '1'
          or fifofull = '1'
          or destok = '0' then
          ns  <= none;
        else
          ns  <= lastwait0;
        end if;

      when lastwait0 =>
        rd <= '0';
        mwen <= '0';
        nextf <= '0';
        bpwen <= '0';
        ns <= lastwait1;
        
      when lastwait1 =>
        rd <= '0';
        mwen <= '0';
        nextf <= '0';
        bpwen <= '0';
        ns <= lastwait2;
        
      when lastwait2 =>
        rd <= '0';
        mwen <= '0';
        nextf <= '0';
        bpwen <= '0';
        ns <= bpwait0; 
        
      when bpwait0 =>
        rd    <= '0';
        mwen  <= '1';
        nextf <= '0';
        bpwen <= '1';
        ns    <= bpwait1;
        
      when bpwait1 =>
        rd    <= '0';
        mwen  <= '0';
        nextf <= '0';
        bpwen <= '1';
        ns    <= bpwait2;
        
      when bpwait2 =>
        rd    <= '0';
        mwen  <= '0';
        nextf <= '0';
        bpwen <= '1';
        ns    <= bpwait3;
        
      when bpwait3 =>
        rd    <= '0';
        mwen  <= '1';
        nextf <= '0';
        bpwen <= '1';
        if crcvalid = '0' then
          ns  <= none;
        else
          ns  <= validf;
        end if;

      when validf =>
        rd    <= '0';
        mwen  <= '1';
        nextf <= '0';
        bpwen <= '0';
        ns    <= none;
      when others =>
        rd    <= '0';
        mwen  <= '0';
        nextf <= '0';
        bpwen <= '0';
        ns    <= none;
    end case;
  end process;

end Behavioral;
