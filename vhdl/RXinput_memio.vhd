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
           CE : out std_logic;
           ENDF : in std_logic;
           INVALID : in std_logic;
           DATA : in std_logic_vector(7 downto 0);
           MA : out std_logic_vector(15 downto 0);
		 MD : out std_logic_vector(31 downto 0); 
           BPOUT : out std_logic_vector(15 downto 0);
           CRCERR : out std_logic;
           OFERR : out std_logic;
           PHYERR : out std_logic;
           RXF : out std_logic);
end RXinput_memio;

architecture Behavioral of RXinput_memio is
-- RXINPUT_MEMIO.VHD -- memory input/output on the internal-clock
-- side of the RX FIFO. 
 
   -- data latches:
   signal dout, doutl, lmd: std_logic_vector(31 downto 0) := 
   					   (others => '0');
   
   signal mnewf, brdy : std_logic := '0';

   -- byte counter
   signal bcnt : std_logic_vector(15 downto 0) := (others => '0');
   
   -- crc signals
   signal crc, crcl: std_logic_vector(31 downto 0) := 
   				 (others => '0');
   
   -- memory:
   signal bp, macnt, lma : std_logic_vector(15 downto 0) :=
   					  (others => '0');

   signal men, menl, mendelta, wbp, newf: std_logic := '0';

   -- fsms:
   type states is (none, byte0, byte1, byte2, byte3, memwait1,
   			    memwait2, memwait3, wait0, wait1, wait2, errchk,
			    writebp);
   signal cs, ns : states := none;  
   
	 component crc_combinational is
	    Port ( CI : in std_logic_vector(31 downto 0);
	           D : in std_logic_vector(7 downto 0);
	           CO : out std_logic_vector(31 downto 0));
	end component;
begin
    crccomb: crc_combinational port map (
			CI => crcl,
			CO => crc,
			D => data);	
    
    clock: process(CLK, RESET) is
    begin
    	   if RESET = '1' then
	   	 cs <= none;
		 macnt <= (others => '0');
		 bcnt <= (others => '0');

	   else
	      if rising_edge(CLK) then
		 	cs <= ns; 
			
			-- memory signals
			if wbp = '1' then
			   bp <= macnt;
			end if; 
			
			MA <= lma;
			MD <= lmd;
			
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
			   doutl <= dout; 
			end if; 
			
			
			-- crc:
			if newf = '1' then
			   crcl <= (others => '0');
			else
			   if brdy = '1' then 
			      crcl <= crc;
			   end if; 
		     end if; 
			
			-- byte count
			if newf = '1' then
			   bcnt <= (others => '0');
			else
			   if brdy = '1' then 
			      bcnt <= bcnt + 1;
			   end if; 
		     end if; 				  
		 end if; 
	   end if; 

    end process clock;

    -- memory combinational
    mendelta <= men and (not menl); 
    lma <= bp when wbp = '1' else macnt; 

    -- data combinational 
    lmd <= doutl when wbp = '0' else ("0000000000000000" & bcnt); 

    brdy <= not(ENDF or INVALID);

    BPOUT <= bp; 

    fsm : process(CS, NS, ENDF, INVALID, CRCL, DATA) is
    begin
       case cs is
	      when none => 
		      men <= '1'; 
			 CE <= '1'; 
			 newf <= '1';
			 wbp <= '0'; 
			 if INVALID = '0' and DATA = "11010101" and ENDF = '0' then
			    ns <= byte0;
  			 else
			    ns <= none; 
			 end if; 
	      when byte0 => 
		      men <= '1'; 
			 CE <= '1'; 
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
			 CE <= '1'; 
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
			 CE <= '1'; 
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
			 CE <= '1'; 
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
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0'; 
			 ns <= memwait2; 
	      when memwait2 => 
		      men <= '0'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0'; 
			 ns <= memwait3; 
	      when memwait3 => 
		      men <= '1'; 
			 CE <= '0'; 
			 newf <= '0'; 
			 wbp <= '0';
			 ns <= wait0; 
	      when wait0 => 
		      men <= '1'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0'; 
			 ns <= wait1; 
	      when wait1 => 
		      men <= '1'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0'; 
			 ns <= errchk; 
	      when errchk => 
		      men <= '1'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0'; 
			 if DATA(2) = '0' and CRCL = X"00000000" then
			    ns <= wait2;
			 else
			    ns <= none; 
			 end if; 
	      when wait2 => 
		      men <= '0'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0';
			 ns <= writebp; 
	      when writebp => 
		      men <= '1'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '1';  
			 ns <= none; 
	      when others => 
		      men <= '0'; 
			 CE <= '0'; 
			 newf <= '0';
			 wbp <= '0';  
			 ns <= none; 
	 end case; 


    end process fsm; 
  
end Behavioral;
