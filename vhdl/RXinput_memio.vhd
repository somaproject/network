library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXinput_memio is
    Port ( CLK : in std_logic;
    		 RESET : in std_logic;
           CEOUT : out std_logic;
           ENDF : in std_logic;
           INVALID : in std_logic;
           DATA : in std_logic_vector(7 downto 0);
           MA : out std_logic_vector(15 downto 0);
		 	  MD : out std_logic_vector(31 downto 0); 
           BPOUT : out std_logic_vector(15 downto 0);
           RXCRCERR : out std_logic;
           RXOFERR : out std_logic;
           RXPHYERR : out std_logic;
		     RXFIFOWERR : out std_logic;
		     FIFOFULL : in std_logic; 
           RXF : out std_logic);
end RXinput_memio;

architecture Behavioral of RXinput_memio is
-- RXINPUT_MEMIO.VHD -- memory input/output on the internal-clock
-- side of the RX FIFO. 
 
   -- data latches:
   signal dout, doutl, lmd: std_logic_vector(31 downto 0) := 
   					   (others => '0');
   
   signal mnewf, brdy : std_logic := '0';
   signal endbyte: std_logic_vector(7 downto 0) :=(others => '0');

	signal datal: std_logic_vector(7 downto 0) := (others => '0'); 


   -- byte counter
   signal bcnt, bcntl : std_logic_vector(15 downto 0) := (others => '0');
   signal bcnten : std_logic := '0';

   -- crc signals
   signal crc, crcl, crcll: std_logic_vector(31 downto 0) := 
   				 (others => '0');
   constant CRCCONST : std_logic_vector(31 downto 0) := 
   				 X"C704DD7B"; 
   signal crcequal : std_logic := '0'; 
   signal fifofulll : std_logic := '0'; 
	signal crcrst, crcen : std_logic := '0';


   -- memory:
   signal bp, macnt, lma, bpl, lbpout, lbpout2, lbpout3, lbpout4, lbpout5
    : std_logic_vector(15 downto 0) :=
   					  (others => '0');

   signal men, menl, mendelta, wbp, wbpl, newf, bpen: std_logic := '0';
   
   signal ce : std_logic := '0';

   -- fsms:
   type states is (none, byte0, byte1, byte2, byte3, memwait1,
   			    memwait2, memwait3, wait0, wait1, wait2, wait3, errchk,
			    incbp, pktabort, writebp);
   signal cs, ns : states := none;  
   
	 component crc_combinational is
	    Port ( CI : in std_logic_vector(31 downto 0);
	           D : in std_logic_vector(7 downto 0);
	           CO : out std_logic_vector(31 downto 0));
	end component;

begin
    CEOUT <= ce; 

    crccomb: crc_combinational port map (
			CI => crcl,
			CO => crc,
			D => datal);	
    
    clock: process(CLK, RESET) is
    begin
    	   if RESET = '1' then
	   	 cs <= none;
		 macnt <= (others => '0');
		 bcnt <= (others => '0');
		 MA <= (others => '0');
		 MD <= (others => '0');
		  
	   else
	      if rising_edge(CLK) then
		 	cs <= ns; 
			
			-- memory signals
			if wbp = '1' then

			   bpl <= bp; 
			   bcntl <= bcnt -4; 
			end if;
			 
			MA <= lma;
			MD <= lmd;

			if bpen = '1' then
			   bp <= macnt -1;

			end if; 			
			bpen <= wbp; 
			
			if ENDF='1' then
			    endbyte <= DATA;
			end if; 
			
			fifofulll <= FIFOFULL; 
							
			if mendelta = '1' then
				doutl <= dout;
				wbpl <= wbp; 

			end if; 
			
			if newf = '1' then
			   macnt <= bp;
			else
			   if mendelta = '1' then
			      macnt <= macnt + 1;
		        end if;
			end if; 
			
			menl <= men; 
			
			-- byte data
			if cs = byte0 then
			   dout(7 downto 0) <= data;
			end if; 

			if cs = byte1 then
			   dout(15 downto 8) <= data;
			end if; 

			if cs = byte2 then
			   dout(23 downto 16) <= data;
			end if; 

			if cs = byte3 then
			   dout(31 downto 24) <= data;
			end if; 

			if mendelta = '1' then
			   
			end if; 
			
			
			-- crc:
			if crcrst = '1' then
			   crcl <= (others => '1');
			else
			   if crcen = '1' then 
			      crcl <= crc;
			   end if; 
		     end if; 
			crcll <= crcl; 

			crcrst <= newf; 
			crcen <= brdy and ce;

			datal <= data; 

			-- byte count
			if newf = '1' then
			   bcnt <= (others => '0');
			else
			   if brdy = '1' and ce = '1' then 
			      bcnt <= bcnt + 1;
			   end if; 
		     end if; 	
			
			-- error reporting:
			if endbyte(2 downto 0) = "101" and cs = errchk then
			   RXPHYERR <= '1';
			else
			   RXPHYERR <= '0';
			end if; 
		    	
			if endbyte(2 downto 0) = "110" and cs = errchk then
			   RXOFERR <= '1'; 
			else
			   RXOFERR <= '0'; 
			end if; 
		
		     -- because of the 32-bit wide comparison with
			-- CRC, this is really pipelined. 
			-- but we only get a CRC error when it would be
			-- a valid frame except for a bad CRC. 
			if crcll = CRCCONST then
				crcequal <= '1'; 
			else
				crcequal <= '0';
			end if;
			  
			if crcequal = '0' and cs = errchk and 
				endbyte(2) = '0' then
			   RXCRCERR <= '1';
		     else
			   RXCRCERR <= '0';
			end if;

			-- fifo full error : otherwise, its a
			-- great frame, we just can't write it. 
			if cs = errchk and crcequal = '1' and 
			   endbyte(2) = '0' and FIFOFULL = '1' then
			   RXFIFOWERR <= '1';
			else
			   RXFIFOWERR <= '0';
			end if; 	
			 
			lbpout <= bp;
			lbpout2 <= lbpout;
			lbpout3 <= lbpout2;
			lbpout4 <= lbpout3;  
			BPOUT <= lbpout4; 

			if cs = writebp then
			   RXF <= '1';
			else
			   RXF <= '0';
			end if; 			  
		 end if; 
	   end if; 

    end process clock;

    -- memory combinational
    mendelta <= men and (not menl); 
    lma <= bpl when wbpl = '1' else macnt; 
    
    -- data combinational 
    lmd <= doutl when wbpl = '0' else ("0000000000000000" & bcntl); 

    brdy <= not(ENDF or INVALID);

    

    fsm : process(CS, NS, ENDF, INVALID, CRCLl, endbyte, data, fifofulll) is
    begin
       case cs is
	      when none => 
		      men <= '1'; 
			 ce <= '1'; 
			 newf <= '1';
			 wbp <= '0';
			 if INVALID = '0' and DATA = "11010101" and ENDF = '0' then
			    ns <= byte0;
  			 else
			    ns <= none; 
			 end if; 
	      when byte0 => 
		      men <= '1'; 
			 ce <= '1'; 
			 newf <= '0';
			 wbp <= '0';
			 if INVALID = '0' then
			    if ENDF = '0' then
			       ns <= byte1;
 			    else
			       ns <= wait0;
 			    end if; 
			 else
			    ns <= byte0; 
			 end if; 
	      when byte1 => 
		      men <= '0'; 
			 ce <= '1'; 
			 newf <= '0'; 
			 wbp <= '0';
			 if INVALID = '0' then
			    if ENDF = '0' then
			       ns <= byte2;
 			    else
			       ns <= memwait1;
 			    end if; 
			 else
			    ns <= byte1; 
			 end if; 
	      when byte2 => 
		      men <= '0'; 
			 ce <= '1'; 
			 newf <= '0'; 
			 wbp <= '0';
			 if INVALID = '0' then
			    if ENDF = '0' then
			       ns <= byte3;
 			    else
			       ns <= memwait2;
 			    end if; 
			 else
			    ns <= byte2; 
			 end if; 
	      when byte3 => 
		      men <= '0'; 
			 ce <= '1'; 
			 newf <= '0';
			 wbp <= '0';
			 if INVALID = '0' then
			    if ENDF = '0' then
			       ns <= byte0;
 			    else
			       ns <= memwait3;
 			    end if; 
			 else
			    ns <= byte3; 
			 end if; 
	      when memwait1 => 
		      men <= '0'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= memwait2; 
	      when memwait2 => 
		      men <= '0'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= memwait3; 
	      when memwait3 => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0'; 
			 wbp <= '0';
			 ns <= wait0; 
	      when wait0 => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= wait1; 
	      when wait1 => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= wait2; 
	      when wait2 => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= errchk; 

	      when errchk => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 if fifofulll = '0' and endbyte(2) = '0' and 
			 	crcequal = '1' then --crcll = CRCCONST then 
				ns <= wait3; 
			 else 
				 ns <= pktabort; 
			 end if;  
	      when wait3=> 
		      men <= '0'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= incbp; 
	      when incbp => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '1';
			 ns <= writebp; 
	      when pktabort => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= none; 
	      when writebp => 
		      men <= '1'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0'; 
			 ns <= none; 
	      when others => 
		      men <= '0'; 
			 ce <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= none; 
	 end case; 


    end process fsm; 
  
end Behavioral;
