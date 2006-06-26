library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;



entity TXoutput is
  port ( CLK     : in  std_logic;
         RESET   : in  std_logic;
         MQ      : in  std_logic_vector(31 downto 0);
         MA      : out std_logic_vector(15 downto 0);
         BPIN    : in  std_logic_vector(15 downto 0);
         TXD     : out std_logic_vector(7 downto 0);
         TXEN    : out std_logic;
         TXF     : out std_logic;
         FBBP    : out std_logic_vector(15 downto 0);
         CLKEN   : in  std_logic;
         GTX_CLK : out std_logic);
end TXoutput;

architecture Behavioral of TXoutput is

  -- mux counters:
  signal dsel, crcsel, crcsell, outsel, outsell, outselll :
    integer range 0 to 3 := 0;

  -- byte counter
  signal bcnt, bcntl      : std_logic_vector(15 downto 0) := (others => '0');
  signal decbcnt, ldbcnt  : std_logic                     := '0';
  signal bcntlgt10        : std_logic                     := '0';
  -- addr :
  signal addr, bpl, addrl : std_logic_vector(15 downto 0) :=
    (others                                                          => '0');
  signal addrinc, rstaddr : std_logic                     := '0';

  signal ldata, data, datal, rdata : std_logic_vector(7 downto 0) :=
    (others => '0');



  -- crc-related:
  signal crc, crcl, ncrcl      : std_logic_vector(31 downto 0) :=
    (others => '0');
  signal crcrst, crcenl, crcen : std_logic                     := '0';

  -- output
  signal ncrcbyte, ncrcbytel, ncrcbytelflip, ltxd :
    std_logic_vector(7 downto 0)           := (others => '0');
  signal ltxen2, ltxen3, ltxen : std_logic := '0';

  -- FSMs
  type states is (none, incaddr, wait0, wait1, wait2, bcntrdy,
                  wait3, wait4, wait5, databyte0, databyte1,
                  databyte2, databyte3, crc0, crc1, crc2, crc3);
  signal cs, ns : states := none;


  component crc_combinational
    port ( CI : in  std_logic_vector(31 downto 0);
           D  : in  std_logic_vector(7 downto 0);
           CO : out std_logic_vector(31 downto 0));
  end component;



begin
  crc_combinational_inst : crc_combinational
    port map (
      CI => crcl,
      CO => crc,
      D  => data);
  
  MA    <= addr;
  ncrcl <= not crcl;

  GTX_CLK <= clk;


  --TXF goes high when a packet is being sent, and
  -- is used both for TX LED and the indicator counter
  TXF <= ltxen3 and not ltxen2;


  clock : process(CLK, RESET)
  begin
    if RESET = '1' then
      ADDR <= (others => '0');
      addr <= (others => '0');
      cs   <= none;
    else
      if rising_edge(CLK) then
        cs <= ns;

        --byte count
        if ldbcnt = '1' then
          bcnt <= MQ(15 downto 0);
        elsif decbcnt = '1' then
          bcnt <= bcnt - 1;
        end if;

        bcntl <= bcnt;

        if bcntl > "0000000000001010" then
          bcntlgt10 <= '1';
        else
          bcntlgt10 <= '0';
        end if;

        -- addr counter
        if addrinc = '1' then
          addr <= addr + 1;
        end if;
        addrl  <= addr;

        -- latches
        data    <= ldata;
        crcenl  <= crcen;
        outsell <= outsel;
        ltxen2  <= ltxen;
        ltxen3  <= ltxen2;
        bpl     <= BPIN;

        -- crc reg:
        if crcrst = '1' then
          crcl <= (others => '1');
        elsif crcenl = '1' then
          crcl <= crc;
        end if;

        -- output latches
        TXEN <= ltxen3;
        TXD  <= ltxd;
        FBBP <= addr;

        -- lame pipelining attempt:
        ncrcbytel <= ncrcbyte;
        datal     <= data;
        outselll  <= outsell;
        crcsell   <= crcsel;
      end if;
    end if;
  end process clock;

  -- combinational muxes:
  ldata <= MQ(15 downto 8)   when dsel = 0 else
           MQ(7 downto 0)  when dsel = 1 else
           MQ(31 downto 24) when dsel = 2 else
           MQ(23 downto 16) when dsel = 3;

  ncrcbyte <= not crcl(7 downto 0)   when crcsell = 0 else
              not crcl(15 downto 8)  when crcsell = 1 else
              not crcl(23 downto 16) when crcsell = 2 else
              not crcl(31 downto 24) when crcsell = 3;

  -- remember that the 802.3 spec shows these transmitted LSB
  -- first, so they look reversed. 
  ltxd <= datal         when outselll = 0 else
          "01010101"    when outselll = 1 else
          "11010101"    when outselll = 2 else
          ncrcbytelflip when outselll = 3;

  -- flip the bits of the latched, negated crcbyte:
  ncrcbytelflip(0) <= ncrcbytel(7);
  ncrcbytelflip(1) <= ncrcbytel(6);
  ncrcbytelflip(2) <= ncrcbytel(5);
  ncrcbytelflip(3) <= ncrcbytel(4);
  ncrcbytelflip(4) <= ncrcbytel(3);
  ncrcbytelflip(5) <= ncrcbytel(2);
  ncrcbytelflip(6) <= ncrcbytel(1);
  ncrcbytelflip(7) <= ncrcbytel(0);



  fsm : process(cs, ns, CLKEN, addr, bpl, bcnt, addrl, bcntl)
  begin
    case cs is
      when none =>
        addrinc <= '0';
        outsel  <= 0;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '0';
        if clken = '1' and (not (bpl = addrl)) then
          ns    <= incaddr;
        else
          ns    <= none;
        end if;

      when incaddr =>
        addrinc <= '1';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '1';
        ltxen   <= '1';
        ns      <= wait0;

      when wait0 =>
        addrinc <= '0';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= wait1;

      when wait1 =>
        addrinc <= '0';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= wait2;

      when wait2 =>
        addrinc <= '0';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= bcntrdy;

      when bcntrdy =>
        addrinc <= '1';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '1';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= wait3;

      when wait3 =>
        addrinc <= '0';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= wait4;

      when wait4 =>
        addrinc <= '0';
        outsel  <= 1;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= wait5;

      when wait5 =>
        addrinc <= '0';
        outsel  <= 2;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= databyte0;

      when databyte0 =>
        if bcntlgt10 = '1' then
          addrinc <= '1';
        else
          addrinc <= '0';
        end if;
        outsel    <= 0;
        crcsel    <= 0;
        dsel      <= 0;
        decbcnt   <= '1';
        ldbcnt    <= '0';
        crcen     <= '1';
        crcrst    <= '0';
        ltxen     <= '1';
        if bcnt = "0000000000000001" then
          ns      <= crc3;
        else
          ns      <= databyte1;
        end if;

      when databyte1 =>
        addrinc <= '0';
        outsel  <= 0;
        crcsel  <= 0;
        dsel    <= 1;
        decbcnt <= '1';
        ldbcnt  <= '0';
        crcen   <= '1';
        crcrst  <= '0';
        ltxen   <= '1';
        if bcnt = "0000000000000001" then
          ns    <= crc3;
        else
          ns    <= databyte2;
        end if;

      when databyte2 =>
        addrinc <= '0';
        outsel  <= 0;
        crcsel  <= 0;
        dsel    <= 2;
        decbcnt <= '1';
        ldbcnt  <= '0';
        crcen   <= '1';
        crcrst  <= '0';
        ltxen   <= '1';
        if bcnt = "0000000000000001" then
          ns    <= crc3;
        else
          ns    <= databyte3;
        end if;

      when databyte3 =>
        addrinc <= '0';
        outsel  <= 0;
        crcsel  <= 0;
        dsel    <= 3;
        decbcnt <= '1';
        ldbcnt  <= '0';
        crcen   <= '1';
        crcrst  <= '0';
        ltxen   <= '1';
        if bcnt = "0000000000000001" then
          ns    <= crc3;
        else
          ns    <= databyte0;
        end if;

      when crc3 =>
        addrinc <= '1';
        outsel  <= 3;
        crcsel  <= 3;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= crc2;

      when crc2 =>
        addrinc <= '0';
        outsel  <= 3;
        crcsel  <= 2;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= crc1;

      when crc1 =>
        addrinc <= '0';
        outsel  <= 3;
        crcsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= crc0;

      when crc0 =>
        addrinc <= '0';
        outsel  <= 3;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '1';
        ns      <= none;

      when others =>
        addrinc <= '0';
        outsel  <= 3;
        crcsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        crcen   <= '0';
        crcrst  <= '0';
        ltxen   <= '0';
        ns      <= none;
    end case;
  end process fsm;
end Behavioral;
