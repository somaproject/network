library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;



entity txoutput is
  port ( CLK     : in  std_logic;
         RESET   : in  std_logic;
         MQ      : in  std_logic_vector(31 downto 0);
         MA      : out std_logic_vector(15 downto 0);
         BPIN    : in  std_logic_vector(15 downto 0);
         TXD     : out std_logic_vector(7 downto 0);
         TXEN    : out std_logic;
         TXF     : out std_logic;
         FBBP    : out std_logic_vector(15 downto 0);
         MEMCRCERR : out std_logic; 
         CLKEN   : in  std_logic);
end txoutput;

architecture Behavioral of txoutput is

  -- mux counters:
  signal dsel, outsel, outsell, outselll :
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

  signal ltxd : std_logic_vector(7 downto 0) := (others => '0');

  -- crc signals
  signal crcdin          : std_logic_vector(15 downto 0) := (others => '0');
  signal crcsel          : integer range 0 to 1          := 0;
  signal crcen, crcreset : std_logic                     := '0';


  -- output
  signal ltxen2, ltxen3, ltxen : std_logic := '0';

  -- FSMs
  type states is (none, incaddr, wait0, wait1, wait2, bcntrdy,
                  wait3, wait4, wait5, databyte0, databyte1,
                  databyte2, databyte3, crc0, crc1, crc2, crc3 );

  signal cs, ns : states := none;

  signal crcvalid, crcdone : std_logic := '0';


  component crcverify
    port (
      CLK      : in  std_logic;
      DIN      : in  std_logic_vector(15 downto 0);
      DINEN    : in  std_logic;
      RESET    : in  std_logic;
      CRCVALID : out std_logic;
      DONE     : out std_logic);
  end component;


begin

  MA <= addr;

  MEMCRCERR <= crcdone and (not crcvalid );
  
--   crcverify_inst : crcverify
--     port map (
--       CLK      => CLK,
--       DIN      => crcdin,
--       DINEN    => crcen,
--       RESET    => crcreset,
--       CRCVALID => crcvalid,
--       DONE     => crcdone);
  crcvalid <= '1';
  crcdone <= '1';
  
  --TXF goes high when a packet is being sent, and
  -- is used both for TX LED and the indicator counter


  crcreset <= '1' when cs = incaddr else '0';

  crcdin <= MQ(15 downto 0) when crcsel = 0 else
            MQ(31 downto 16);

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
          bcnt <= MQ(15 downto 0);      -- - X"0004";
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
        outsell <= outsel;
        ltxen2  <= ltxen;
        ltxen3  <= ltxen2;
        bpl     <= BPIN;

        -- output latches
        TXEN <= ltxen3;
        TXD  <= ltxd;
        FBBP <= addr;

        -- lame pipelining attempt:

        datal    <= data;
        outselll <= outsell;

        if ltxen3 = '1' and ltxen2 = '0' then
          TXF <= '1';
        else
          TXF <= '0'; 
        end if;

      end if;
    end if;
  end process clock;

  -- combinational muxes:
  ldata <= MQ(15 downto 8)  when dsel = 0 else
           MQ(7 downto 0)   when dsel = 1 else
           MQ(31 downto 24) when dsel = 2 else
           MQ(23 downto 16) when dsel = 3;

  -- remember that the 802.3 spec shows these transmitted LSB
  -- first, so they look reversed. 
  ltxd <= datal      when outselll = 0 else
          "01010101" when outselll = 1 else
          "11010101";

  fsm : process(cs, ns, CLKEN, addr, bpl, bcnt, addrl, bcntl,
                bcntlgt10)
  begin
    case cs is
      when none =>
        addrinc <= '0';
        outsel  <= 0;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '0';
        crcen   <= '0';
        crcsel  <= 0;
        if clken = '1' and (bpl /= addrl) then
          ns    <= incaddr;
        else
          ns    <= none;
        end if;

      when incaddr =>
        addrinc <= '1';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= wait0;

      when wait0 =>
        addrinc <= '0';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= wait1;

      when wait1 =>
        addrinc <= '0';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= wait2;

      when wait2 =>
        addrinc <= '0';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= bcntrdy;

      when bcntrdy =>
        addrinc <= '1';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '1';
        ltxen   <= '1';
        crcen   <= '1';
        crcsel  <= 0;
        ns      <= wait3;

      when wait3 =>
        addrinc <= '0';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= wait4;

      when wait4 =>
        addrinc <= '0';
        outsel  <= 1;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= wait5;

      when wait5 =>
        addrinc <= '0';
        outsel  <= 2;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= databyte0;

      when databyte0 =>
        if bcntlgt10 = '1' then
          addrinc <= '1';
        else
          addrinc <= '0';
        end if;
        outsel    <= 0;
        dsel      <= 0;
        decbcnt   <= '1';
        ldbcnt    <= '0';
        ltxen     <= '1';
        crcen     <= '1';
        crcsel    <= 0;
        if bcnt = "0000000000000001" then
          ns      <= crc3;
        else
          ns      <= databyte1;
        end if;

      when databyte1 =>
        addrinc <= '0';
        outsel  <= 0;
        dsel    <= 1;
        decbcnt <= '1';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        if bcnt = "0000000000000001" then
          ns    <= crc3;
        else
          ns    <= databyte2;
        end if;

      when databyte2 =>
        addrinc <= '0';
        outsel  <= 0;
        dsel    <= 2;
        decbcnt <= '1';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '1';
        crcsel  <= 1;
        if bcnt = "0000000000000001" then
          ns    <= crc3;
        else
          ns    <= databyte3;
        end if;

      when databyte3 =>
        addrinc <= '0';
        outsel  <= 0;
        dsel    <= 3;
        decbcnt <= '1';
        ldbcnt  <= '0';
        ltxen   <= '1';
        crcen   <= '0';
        crcsel  <= 0;
        if bcnt = "0000000000000001" then
          ns    <= crc3;
        else
          ns    <= databyte0;
        end if;

      when crc3 =>
        addrinc <= '1';
        outsel  <= 3;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '0';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= crc2;

      when crc2 =>
        addrinc <= '0';
        outsel  <= 3;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '0';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= crc1;

      when crc1 =>
        addrinc <= '0';
        outsel  <= 3;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '0';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= crc0;

      when crc0 =>
        addrinc <= '0';
        outsel  <= 3;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '0';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= none;                -- extraread0;

      when others =>
        addrinc <= '0';
        outsel  <= 3;
        dsel    <= 0;
        decbcnt <= '0';
        ldbcnt  <= '0';
        ltxen   <= '0';
        crcen   <= '0';
        crcsel  <= 0;
        ns      <= none;
    end case;
  end process fsm;
end Behavioral;
