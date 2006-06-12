library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity RXoutput is
    Port ( CLK : in std_logic;
    		 CLKEN : in std_logic; 
    		 RESET : in std_logic;
           BPIN : in std_logic_vector(15 downto 0);
		 FBBP : out std_logic_vector(15 downto 0);
           MA : out std_logic_vector(15 downto 0);
           MQ : in std_logic_vector(31 downto 0);
           CLKIO : in std_logic;
		 NEXTFRAME : in std_logic; 
           DOUT : out std_logic_vector(15 downto 0);
           DOUTEN : out std_logic);
end RXoutput;

architecture Behavioral of RXoutput is
-- RXOUTPUT.VHD -- system for implementing the post-RAM FIFO
-- side of the receiving system. Lots of clock-boundary crossing
-- here, be careful!

	-- output side
	signal do : std_logic_vector(15 downto 0)
		:= (others => '0');
	signal nfl, nextd, ldouten, aeq : std_logic := '0';
	signal ao, ail, aill : std_logic_vector(9 downto 0)
		:= (others => '0');
		
	-- input side
	signal mdl : std_logic_vector(31 downto 0)
		:= (others => '0');
	signal ldi, di : std_logic_vector(15 downto 0)
		:= (others => '0');
	signal lai, ai : std_logic_vector(9 downto 0)
		:= (others => '0');
	signal fifowe, fifowel, we, nfll, halffull, nearfull,
		lhalffull, lnearfull, mdsel, mdsell, lenen : std_logic := '0';
		
	-- macaddr
	signal bpinl, len, lenr, llbp, lbp, bp, macnt :
		 std_logic_vector(15 downto 0)
		:= (others => '0');
	signal mainc, bpen : std_logic := '0';

	type states is (none, waitclken, swait0, swait1, 
		swait2, swait3, swait4, latchlen, wait0,
		startw, loww, highw, fifonop, nextw,
		rewait0, rewait1,reincmac, waitdone, latchbp); 

	signal cs, ns : states := none; 

	-- overflow
	signal addrmsbs : std_logic_vector(3 downto 0)
		:= (others => '0'); 

	component RAMB16_S18_S18 
	  generic (
	       WRITE_MODE_A : string := "WRITE_FIRST";
	       WRITE_MODE_B : string := "WRITE_FIRST";
	       INIT_A : bit_vector  := X"00000";
	       SRVAL_A : bit_vector := X"00000";

	       INIT_B : bit_vector  := X"00000";
	       SRVAL_B : bit_vector := X"00000";

	       INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
	       INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
	  port (DIA    : in STD_LOGIC_VECTOR (15 downto 0);
	        DIB    : in STD_LOGIC_VECTOR (15 downto 0);
	        DIPA    : in STD_LOGIC_VECTOR (1 downto 0);
	        DIPB    : in STD_LOGIC_VECTOR (1 downto 0);
	        ENA    : in STD_logic;
	        ENB    : in STD_logic;
	        WEA    : in STD_logic;
	        WEB    : in STD_logic;
	        SSRA   : in STD_logic;
	        SSRB   : in STD_logic;
	        CLKA   : in STD_logic;
	        CLKB   : in STD_logic;
	        ADDRA  : in STD_LOGIC_VECTOR (9 downto 0);
	        ADDRB  : in STD_LOGIC_VECTOR (9 downto 0);
	        DOA    : out STD_LOGIC_VECTOR (15 downto 0);
	        DOB    : out STD_LOGIC_VECTOR (15 downto 0);
	        DOPA    : out STD_LOGIC_VECTOR (1 downto 0);
	        DOPB    : out STD_LOGIC_VECTOR (1 downto 0)
	       ); 

	end component;

begin
	
	-- ram instantiation
	fifo : RAMB16_S18_S18 port map (
		DIA => di,
		DIB => X"0000",
		DIPA => "00",
		DIPB => "00",
		ENA => '1',
		ENB => nfl,
		WEA => we, 
		WEB => '0',
		SSRA => '0',
		SSRB => '0',
		CLKA => clk,
		CLKB => clkio,
		ADDRA => ai,
		ADDRB => ao,
		DOA => open,
		DOB => do,
		DOPA => open,
		DOPB => open);
		
	-- the output side
	nextd <= nfl and (not aeq); 
	aeq <= '1' when aill = ao else '0';
	
	addrmsbs <= ao(9 downto 8) & aill(9 downto 8);
	 
	

	output : process(CLKIO) is
	begin
		if rising_edge(CLKIO) then
			DOUT <= do;
			nfl <= NEXTFRAME;
			if nfl = '0' then
				AO <= (others => '0');
			else
				if nextd = '1' then
					ao <= ao + 1;
				end if; 
			end if;
			if nfl = '0' then
				aill <= (others => '0');
			else 
				aill <= ail;
			end if;  
			ldouten <= nextd;
			DOUTEN <= ldouten;


		end if;	
	end process output;  	

	-- input
	ldi <= mdl(15 downto 0) when mdsell = '0' else mdl(31 downto 16);

	MA <= macnt; 

	input : process(RESET, CLK) is
	begin
		if RESET = '1' then
			cs <= none;
			MACNT <= (others => '0');
		else
			if rising_edge(CLK) then
				
				-- state machine
				cs <= ns;

				-- input latching
				bpinl <= BPIN;
				mdl <= MQ;
				-- addresses
				if lenen = '1' then
					len <= mdl(15 downto 0);
				end if; 

				if bpen = '1' then
					bp <= lbp;
				end if; 

				

				if cs = none then
					macnt <= bp;
				else
					if mainc = '1' then
						macnt <= macnt + 1;
					end if;
				end if; 

				-- data
				di <= ldi; 

				ai <= lai; 
				mdsell <= mdsel; 
				fifowel <= fifowe; 
				we <= fifowel;

				if nfll = '0' then
					lai <= (others => '0');
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
				nfll <= nfl;


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

	fsm: process(CS, nfll, bpinl, bp, clken, nearfull, halffull) is
	begin
		case cs is
			when none=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				if nfll = '1' then
					ns <= waitclken;
				else
					ns <= none;
				end if; 
			when waitclken=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				if BPINL /= bp and clken = '1' then
					ns <= swait0;
				else
					ns <= waitclken;
				end if; 
			when swait0 =>
				lenen <= '0';
				mainc <= '1';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= swait1;
			when swait1 =>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= swait2;
			when swait2 =>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= swait3;
			when swait3 =>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= swait4;
			when swait4 =>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';	
				bpen <= '0'; 
				ns <= latchlen;
			when latchlen =>
				lenen <= '1';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '1';
				bpen <= '0'; 
				ns <= wait0;
			when wait0 =>
				lenen <= '0';
				mainc <= '1';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= startw;
			when startw=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= loww;
			when loww=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '1';
				bpen <= '0'; 
				ns <= highw;
			when highw=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '1';
				fifowe <= '1';
				bpen <= '0'; 
				if nearfull = '1' then
					ns <= fifonop;
				else
					ns <= nextw;
				end if; 
			when nextw=>
				lenen <= '0';
				mainc <= '1';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				if lbp = macnt then
					ns <= waitdone;
				else
					ns <= startw;
				end if; 
			-- now the detour states
			when fifonop=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				if nearfull = '0' and halffull = '0'
					and clken = '1' then
					ns <= rewait0;
				else
					ns <= fifonop;
				end if; 

			when rewait0=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= rewait1; 
			when rewait1=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= reincmac; 
			when reincmac=>
				lenen <= '0';
				mainc <= '1';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				if lbp = macnt then 
					ns <= waitdone;
				else
					ns <= startw; 
				end if; 


			when waitdone=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				if nfll = '0'  then
					ns <= latchbp;
				else
					ns <= waitdone;
				end if; 
			when latchbp=>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '1'; 
				ns <= none; 
			when others =>
				lenen <= '0';
				mainc <= '0';
				mdsel <= '0';
				fifowe <= '0';
				bpen <= '0'; 
				ns <= none;
		end case; 
	end process fsm; 


end Behavioral;