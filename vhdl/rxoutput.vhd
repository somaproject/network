library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library UNISIM;
use UNISIM.VComponents.all;

entity RXoutput is
  port ( CLK       : in  std_logic;
         CLKEN     : in  std_logic;
         RESET     : in  std_logic;
         BPIN      : in  std_logic_vector(15 downto 0);
         FBBP      : out std_logic_vector(15 downto 0);
         MA        : out std_logic_vector(15 downto 0);
         MQ        : in  std_logic_vector(31 downto 0);
         MEMCRCERR : out std_logic; 
         CLKIO     : in  std_logic;
         NEXTFRAME : in  std_logic;
         DOUT      : out std_logic_vector(15 downto 0);
         DOUTEN    : out std_logic);
end RXoutput;

architecture Behavioral of RXoutput is

  -- output side
  signal do : std_logic_vector(15 downto 0)
 := (others => '0');

  signal nfl, nextd, ldouten, aeq : std_logic := '0';

  signal ao, ail, aill : std_logic_vector(9 downto 0)
 := (others => '0');

  -- input side
  signal mdl     : std_logic_vector(31 downto 0) := (others => '0');
  signal ldi, di : std_logic_vector(15 downto 0) := (others => '0');
  signal lai, ai : std_logic_vector(9 downto 0)  := (others => '0');

  signal fifowe, fifowel, we, nfll, halffull, nearfull,
    lhalffull, lnearfull, mdsel, mdsell, lenen : std_logic := '0';

  -- macaddr
  signal bpinl, bpinl1, len, lenr, llbp, lbp, bp, macnt :
    std_logic_vector(15 downto 0)
                                 := (others => '0');
  signal mainc, bpen : std_logic := '0';

  type states is (none, waitclken, swait0, swait1,
                  swait2, swait3, swait4, latchlen, wait0,
                  startw, loww, highw, fifonop, nextw,
                  rewait0, rewait1, reincmac, waitdone, latchbp);

  signal cs, ns : states := none;

  -- overflow
  signal addrmsbs : std_logic_vector(3 downto 0)
 := (others => '0');

  component RAMB16_S18_S18
    generic (
      INIT_B    :     bit_vector := X"00000";
      SRVAL_B   :     bit_vector := X"00000";
      SIM_COLLISION_CHECK : string);
    port (DIA   : in  std_logic_vector (15 downto 0);
          DIB   : in  std_logic_vector (15 downto 0);
          DIPA  : in  std_logic_vector (1 downto 0);
          DIPB  : in  std_logic_vector (1 downto 0);
          ENA   : in  std_logic;
          ENB   : in  std_logic;
          WEA   : in  std_logic;
          WEB   : in  std_logic;
          SSRA  : in  std_logic;
          SSRB  : in  std_logic;
          CLKA  : in  std_logic;
          CLKB  : in  std_logic;
          ADDRA : in  std_logic_vector (9 downto 0);
          ADDRB : in  std_logic_vector (9 downto 0);
          DOA   : out std_logic_vector (15 downto 0);
          DOB   : out std_logic_vector (15 downto 0);
          DOPA  : out std_logic_vector (1 downto 0);
          DOPB  : out std_logic_vector (1 downto 0)
          );

  end component;

-- CRC signals
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

  crcverify_inst: crcverify
    port map (
      CLK      => CLK,
      DIN      => LDI,
      DINEN    => fifowel, 
      RESET    => bpen,
      CRCVALID => crcvalid,
      DONE     => crcdone); 

  -- ram instantiation
  fifo : RAMB16_S18_S18
    generic map (
      SIM_COLLISION_CHECK => "NONE")
    port map (
    DIA   => di,
    DIB   => X"0000",
    DIPA  => "00",
    DIPB  => "00",
    ENA   => '1',
    ENB   => nfl,
    WEA   => we,
    WEB   => '0',
    SSRA  => '0',
    SSRB  => '0',
    CLKA  => clk,
    CLKB  => clkio,
    ADDRA => ai,
    ADDRB => ao,
    DOA   => open,
    DOB   => do,
    DOPA  => open,
    DOPB  => open);

  -- the output side
  nextd <= nfl and (not aeq);
  aeq   <= '1' when aill = ao else '0';

  addrmsbs <= ao(9 downto 8) & aill(9 downto 8);



  output : process(CLKIO)
  begin
    if rising_edge(CLKIO) then
      DOUT    <= do;
      nfl     <= NEXTFRAME;
      if nfl = '0' then
        AO    <= (others => '0');
      else
        if nextd = '1' then
          ao  <= ao + 1;
        end if;
      end if;
      if nfl = '0' then
        aill  <= (others => '0');
      else
        aill  <= ail;
      end if;
      ldouten <= nextd;
      DOUTEN  <= ldouten;


    end if;
  end process output;

  -- input
  ldi <= mdl(15 downto 0) when mdsell = '0' else mdl(31 downto 16);

  MA <= macnt;

  input : process(RESET, CLK)
  begin
    if RESET = '1' then
      cs    <= none;
      MACNT <= (others => '0');
    else
      if rising_edge(CLK) then

        -- state machine
        cs <= ns;

        -- input latching
        bpinl <= BPIN; 
        
        mdl   <= MQ;
        -- addresses
        if lenen = '1' then
          len <= mdl(15 downto 0);
        end if;

        if bpen = '1' then
          bp <= lbp;
        end if;

        if crcvalid = '0' and crcdone = '1'  then
          MEMCRCERR <= '1';
        else
          MEMCRCERR <= '0'; 
        end if;

        if cs = none then
          macnt   <= bp;
        else
          if mainc = '1' then
            macnt <= macnt + 1;
          end if;
        end if;

        -- data
        di <= ldi;

        ai      <= lai;
        mdsell  <= mdsel;
        fifowel <= fifowe;
        we      <= fifowel;

        if nfll = '0' then
          lai   <= (others => '0');
        else
          if fifowel = '1' then
            lai <= lai + 1;
          end if;
        end if;

        if len(1 downto 0) = "00" then
          lenr <= "00" & len(15 downto 2);
        else
          lenr <= "00" & (len(15 downto 2) +1);
        end if;

        lbp <= lenr + bp + 1;

        if nfll = '0' then
          ail <= (others => '0');
        else
          ail <= lai;
        end if;
        nfll  <= nfl;


        FBBP <= bp;

        -- fifo status?

        halffull <= lhalffull;
        nearfull <= lnearfull;
      end if;
    end if;
  end process input;


  lhalffull <= '0' when addrmsbs = "0000" else
               '0' when addrmsbs = "0001" else
               '1' when addrmsbs = "0010" else
               '1' when addrmsbs = "0011" else
               '1' when addrmsbs = "0100" else
               '0' when addrmsbs = "0101" else
               '0' when addrmsbs = "0110" else
               '1' when addrmsbs = "0111" else
               '1' when addrmsbs = "1000" else
               '1' when addrmsbs = "1001" else
               '0' when addrmsbs = "1010" else
               '0' when addrmsbs = "1011" else
               '0' when addrmsbs = "1100" else
               '1' when addrmsbs = "1101" else
               '1' when addrmsbs = "1110" else
               '0';

  lnearfull <= '0' when addrmsbs = "0000" else
               '0' when addrmsbs = "0001" else
               '0' when addrmsbs = "0010" else
               '1' when addrmsbs = "0011" else
               '1' when addrmsbs = "0100" else
               '0' when addrmsbs = "0101" else
               '0' when addrmsbs = "0110" else
               '0' when addrmsbs = "0111" else
               '0' when addrmsbs = "1000" else
               '1' when addrmsbs = "1001" else
               '0' when addrmsbs = "1010" else
               '0' when addrmsbs = "1011" else
               '0' when addrmsbs = "1100" else
               '0' when addrmsbs = "1101" else
               '1' when addrmsbs = "1110" else
               '0';

  fsm : process(CS, nfll, lbp, macnt,
                bpinl, bp, clken, nearfull, halffull)
  begin
    case cs is
      when none      =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        if nfll = '1' then
          ns   <= waitclken;
        else
          ns   <= none;
        end if;
      when waitclken =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        if BPINL /= bp and clken = '1' then
          ns   <= swait0;
        else
          ns   <= waitclken;
        end if;
      when swait0    =>
        lenen  <= '0';
        mainc  <= '1';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= swait1;
      when swait1    =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= swait2;
      when swait2    =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= swait3;
      when swait3    =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= swait4;
      when swait4    =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= latchlen;
      when latchlen  =>
        lenen  <= '1';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '1';
        bpen   <= '0';
        ns     <= wait0;
      when wait0     =>
        lenen  <= '0';
        mainc  <= '1';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= startw;
      when startw    =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= loww;
      when loww      =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '1';
        bpen   <= '0';
        ns     <= highw;
      when highw     =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '1';
        fifowe <= '1';
        bpen   <= '0';
        if nearfull = '1' then
          ns   <= fifonop;
        else
          ns   <= nextw;
        end if;
      when nextw     =>
        lenen  <= '0';
        mainc  <= '1';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        if lbp = macnt then
          ns   <= waitdone;
        else
          ns   <= startw;
        end if;
        -- now the detour states
      when fifonop   =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        if nearfull = '0' and halffull = '0'
          and clken = '1' then
          ns   <= rewait0;
        else
          ns   <= fifonop;
        end if;

      when rewait0  =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= rewait1;
      when rewait1  =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= reincmac;
      when reincmac =>
        lenen  <= '0';
        mainc  <= '1';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        if lbp = macnt then
          ns   <= waitdone;
        else
          ns   <= startw;
        end if;


      when waitdone =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        if nfll = '0' then
          ns   <= latchbp;
        else
          ns   <= waitdone;
        end if;
      when latchbp  =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '1';
        ns     <= none;
      when others   =>
        lenen  <= '0';
        mainc  <= '0';
        mdsel  <= '0';
        fifowe <= '0';
        bpen   <= '0';
        ns     <= none;
    end case;
  end process fsm;


end Behavioral;
