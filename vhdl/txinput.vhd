library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library UNISIM;
use UNISIM.VComponents.all;

entity txinput is
  port ( CLK        : in  std_logic;
         CLKIO      : in  std_logic;
         RESET      : in  std_logic;
         DIN        : in  std_logic_vector(15 downto 0);
         NEWFRAME   : in  std_logic;
         MD         : out std_logic_vector(31 downto 0) := (others => '0');
         MWEN       : out std_logic;
         MA         : out std_logic_vector(15 downto 0) := (others => '0'); 
         FIFOFULL   : in  std_logic;
         BPOUT      : out std_logic_vector(15 downto 0);
         TXFIFOWERR : out std_logic;
         TXIOCRCERR : out std_logic;
         DONE       : out std_logic);
end txinput;

architecture Behavioral of txinput is

  signal dh, dl : std_logic_vector(15 downto 0) := (others => '0');
  signal lmd    : std_logic_vector(31 downto 0) := (others => '0');

  signal dlen, dhen : std_logic := '0';
  signal cpen       : std_logic := '0';
  signal mrw, men   : std_logic := '0';

  signal addr, bp : std_logic_vector(15 downto 0) := (others => '0');
  signal bpen     : std_logic                     := '0';
  signal CNT      : std_logic_vector(15 downto 0);

  type states is (none, newf, low_w, low, high_w, high, waitlow,
                  lowmemw, pktdone1, pktdone2, crcinchk, pktdone3,
                  abortfifo, abortcrc);
  
  signal cs, ns : states := none;

  -- signals for clock-boundary-crossing logic
  signal nenable, enable, enableint, enableintl, den, lden :
    std_logic                                     := '0';
  signal dinl, dinint, ldinint        : std_logic_vector(15 downto 0)
                                                  := (others => '0');
  signal newframel, newfint, lnewfint : std_logic := '0';

  -- fifo control
  signal fifofulll : std_logic := '0';

  -- crc signals
  signal crcreset, crcvalid, crcdone, crcen : std_logic := '0';

  -- error signals
  signal ltxiocrcerr, ltxfifowerr : std_logic := '0';
  
  component SRL16
    generic (
      INIT    :     bit_vector := X"0000");
    port (D   : in  std_logic;
          CLK : in  std_logic;
          A0  : in  std_logic;
          A1  : in  std_logic;
          A2  : in  std_logic;
          A3  : in  std_logic;
          Q   : out std_logic);
  end component;

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

  lmd   <= dh & dl;
  BPOUT <= bp;

  crcreset <= '1' when newfint = '0' else '0';
  crcen <= (dhen or dlen) and den; 
  
  crcverify_inst : crcverify
    port map (
      CLK      => CLK,
      DIN      => dinint,
      DINEN    => crcen,
      RESET    => crcreset,
      CRCVALID => crcvalid,
      DONE     => crcdone);

  -- clocks to outside:
  clock_external : process(CLKIO)
  begin
    if rising_edge(CLKIO) then
      enable <= not enable;

      --dinl <= DIN;

      --newframel <= NEWFRAME;
    end if;
  end process clock_external;

  srl16_enable    : srl16 port map (
    D     => enable,
    CLK   => clk,
    A0    => '0',
    A1    => '0',
    A2    => '1',
    A3    => '0',
    Q     => enableint);
  srl16_newframe  : srl16 port map (
    D     => newframel,
    CLK   => clk,
    A0    => '0',
    A1    => '0',
    A2    => '1',
    A3    => '0',
    Q     => lnewfint);
  srl16_din       : for i in 0 to 15 generate
    srl16_din_bit : srl16 port map (
      D   => dinl(i),
      CLK => clk,
      A0  => '0',
      A1  => '0',
      A2  => '1',
      A3  => '0',
      Q   => ldinint(i));
  end generate;

  lden <= enableintl xor enableint;

  ltxiocrcerr <= '1' when cs = abortcrc else '0';
  ltxfifowerr <= '1' when cs = abortfifo else '0';
  

  clock : process(CLK, RESET)
  begin
    if RESET = '1' then
      cs     <= none;
      MD     <= (others => '0');
      MWEN   <= '0';
      MA     <= (others => '0');
    else
      if rising_edge(CLK) then
        dinl <= DIN;

        TXIOCRCERR <= ltxiocrcerr;
        
        newframel <= NEWFRAME;
        cs        <= ns;

        -- enable code
        enableintl <= enableint;

        -- data latching
        if den = '1' and (cs = none or dlen = '1') then
          dl <= dinint;
        end if;

        if den = '1' and dhen = '1' then
          dh <= dinint;
        elsif cs = none then
          dh <= (others => '0');        -- zero high bytes of 
          -- address-containign memory word; purely cosmetic 
        end if;

        -- byte counter
        if den = '1' then
          if cs = none then
            cnt <= dinint;
          else
            cnt <= cnt - 2;
          end if;
        end if;

        -- memory-pointer associated code:
        if cs = none then
          addr <= bp;
        elsif cpen = '1' then
          addr <= addr + 1;
        end if;

        if bpen = '1' then
          bp      <= addr;
        end if;
        -- fifo concerns
        fifofulll <= FIFOFULL;

        -- extra registers at output
        dinint  <= ldinint;
        newfint <= lnewfint;
        den     <= lden;

        -- memory interface
        if MEN = '1' then
          MD   <= lmd;
          MWEN <= mrw;
          MA   <= addr;
        end if;

        -- error signals
        TXIOCRCERR <= ltxiocrcerr;
        TXFIFOWERR <= ltxfifowerr; 
      end if;
    end if;
  end process clock;


  fsm : process(cs, ns, den, din, dinint, newfint, cnt, crcdone,
                fifofulll)
  begin
    case cs is
      when none =>
        dlen       <= '1';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        if den = '1' and newfint = '1' then
          ns       <= newf;
        else
          ns       <= none;
        end if;

      when newf  =>
        dlen       <= '1';
        dhen       <= '0';
        mrw        <= '1';
        men        <= '1';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        if newfint = '0' then
          ns       <= none;
        else
          ns       <= low_w;
        end if;

      when low_w =>
        dlen       <= '1';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        if newfint = '0' then
          ns       <= none;
        else
          if den = '1' then
            ns     <= low;
          else
            ns     <= low_w;
          end if;
        end if;

      when low =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '1';
        DONE       <= '0';
        if cnt = 0 or cnt = 65535 then  --i.e. 0 or -1
          ns       <= waitlow;
        else
          ns       <= high_w;
        end if;

      when high_w =>
        dlen       <= '0';
        dhen       <= '1';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        if newfint = '0' then
          ns       <= none;
        else
          if den = '1' then
            ns     <= high;
          else
            ns     <= high_w;
          end if;
        end if;

      when high =>
        dlen       <= '0';
        dhen       <= '1';
        mrw        <= '1';
        men        <= '1';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';

        if cnt = 0 or cnt = 65535 then  --i.e. 0 or -1
          ns <= pktdone1;
        else
          ns <= low_w;
        end if;

      when waitlow =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        ns         <= lowmemw;

      when lowmemw =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '1';
        men        <= '1';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        ns         <= pktdone1;

      when pktdone1 =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '1';
        DONE       <= '0';
        if fifofulll = '1' then
          ns       <= abortfifo;
        else
          ns       <= crcinchk;
        end if;

      when crcinchk =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        if crcdone = '1' then
          if crcvalid = '1' then
            ns <= pktdone2;
          else
            ns <= abortcrc; 
          end if;
        else
          ns <= crcinchk; 
        end if;

      when pktdone2 =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '1';
        cpen       <= '0';
        DONE       <= '0';
        ns         <= pktdone3;

      when abortfifo =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        ns         <= none;

      when abortcrc =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        ns         <= none;

      when pktdone3 =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '1';
        if newfint = '1' then
          ns       <= pktdone3;
        else
          ns       <= none;
        end if;

      when others =>
        dlen       <= '0';
        dhen       <= '0';
        mrw        <= '0';
        men        <= '0';
        bpen       <= '0';
        cpen       <= '0';
        DONE       <= '0';
        ns         <= none;
    end case;


  end process fsm;



end Behavioral;
