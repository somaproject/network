library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity GMIIin is
    Port ( CLK : in std_logic;
           RX_CLK : in std_logic;
           RX_ER : in std_logic;
           RX_DV : in std_logic;
           RXD : in std_logic_vector(7 downto 0);
           NEXTF : in std_logic;
           ENDFOUT : out std_logic;
           EROUT : out std_logic;
           OFOUT : out std_logic;
		 VALID : out std_logic; 
           DOUT : out std_logic_vector(7 downto 0));
end GMIIin;

architecture Behavioral of GMIIin is
-- GMIIin.vhd -- Dual-clock-domain fifo for reading in data off of the GMII
-- interface and transitioning into the internal CLK domain. 

	--RX_CLK domain signals 
	signal erl, dvl, dvll, erin, endfin, wein, ff,
		we, wel : std_logic := '0';

	signal rxdl, din : std_logic_vector(7 downto 0) 
		:= (others => '0'); 
	
	signal ain, al : std_logic_vector(9 downto 0) 
		:= (others => '0'); 

	signal di : std_logic_vector(15 downto 0) 
		:= (others => '0'); 

    	-- CLK domain signals:
	signal aeq, endfo, val, lvalid, nfl, ffs, efv :
		std_logic := '0';
	signal ao, aol, al2, al2l : std_logic_vector(9 downto 0)
		:= (others => '0');
	signal do : std_logic_vector(15 downto 0)
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

	we <= (not erin) and (dvll) and (not ff); 
	endfin <= wel and (not we); 
	wein <= we or wel; 

	di <= endfin & erin & ff & "00000" & din; 


	rxclk_domain: process (RX_CLK) is
	begin
		if rising_edge(RX_CLK) then
			erl <= RX_ER;
			dvl <= RX_DV;
			rxdl <= RXD;
			din <= rxdl; 
			dvll <= dvl; 
			wel <= we; 

			if dvl = '0' then
				erin <= '0';
			else
				if erl = '1' then
					erin <= '1';
				end if;
			end if; 

			if dvl = '0' then
				ff <= '0';
			else
				if ffs = '1' then
					ff <= '1';
				end if;
			end if; 
			if wein = '1' then
				ain <= ain + 1;
			end if; 

			al <= ain;

		end if;
	end process rxclk_domain;


	fifo: RAMB16_S18_S18 port map (
		DIA => di,
		DIB => X"0000",
		DIPA => "00", 
		DIPB => "00",
		ENA => '1',
		ENB => '1',
		WEA => wein,
		WEB => '0',
		SSRA => '0',
		SSRB => '0',
		CLKA => RX_CLK,
		CLKB => CLK,
		ADDRA => ain,
		ADDRB => ao,
		DOA => open,
		DOB => do,
		DOPA => open,
		DOPB => open); 

	EROUT <= do(14);
	DOUT <= do(7 downto 0);
	OFOUT <= do(13);

	endfo <= do(15); 

	aeq <= '1' when al2 = ao else '0';

	efv <= val and endfo; 	
	lvalid <= nfl and (not aeq) and (not efv); 
	VALID <= val;
	ENDFOUT <= endfo; 

	clk_domain: process(CLK) is
	begin
		if rising_edge(CLK) then
			val <= lvalid; 

			al2 <= al; 

			if lvalid = '1' then 
				ao <= ao + 1;
			end if; 
			
			if NEXTF = '1' then
				nfl <= '1';
			else
				if efv = '1' then
					nfl <= '0';
				end if;
			end if; 

			-- code for fifo overflow
			if al2l - aol > 128 or al2l = aol then
				ffs <= '0';
			else
				ffs <= '1';
			end if;
				
	    end if; 
	end process clk_domain; 
		

end Behavioral;
