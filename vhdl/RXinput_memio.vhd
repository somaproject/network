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
           EMPTY : in std_logic;
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
  
   -- data 
   signal dout, lmd : std_logic_vector(31 downto 0) := (others => '0');
   
   -- CE-related signals:
   signal ceforce, brdy, drdy, newf : std_logic := '0';

   -- memory-address signals
   signal men, menl, mendelta : std_logic := '0';
   signal macnt, lma, bp: std_logic_vector(15 downto 0) := (others =>'0');
   signal wbp: std_logic := '0';

   -- byte count
   signal bcnt : std_logic_vector(15 downto 0) := 
   			(others => '0');

   -- crc
   signal crc, crcl : std_logic_vector(31 downto 0) :=
   			(others => '0');
   
   -- FSM
   type states is ( none, byte0, byte1, byte2, byte3, memwait1,
   				memwait2, memwait3, errchk, wait1, wait2, 
				writebp);
   signal cs, ns : states := none;

   component crc_combinational is
    Port ( CI : in std_logic_vector(31 downto 0);
           D : in std_logic_vector(7 downto 0);
           CO : out std_logic_vector(31 downto 0));
   end component;



begin
   crcinst: crc_combinational port map (
   		CI => crcl,
		CO => crc,
		D => data);	
   
   clock: process(CLK, RESET) is
   begin

      if RESET ='1' then
	 	cs <= none;
	 else
	     if rising_edge(CLK) then
		   cs <= ns; 

		   -- memory address-related
		   if cs = writebp then
		      bp <= macnt;
		   end if;

		   if newf = '1' then
		   	  macnt <= bp;
		   else
		   	  if mendelta = '1' then
			  	macnt <= macnt + 1;
		   	  end if;
		   end if; 

		   menl <= men;

		   if mendelta = '1' then
		   	 MA <= lma;
		   end if; 


		   -- data registers
		   if cs = byte0 then 
		   	 dout(7 downto 0) <= DATA;
		   end if; 
		   if cs = byte1 then 
		   	 dout(15 downto 8) <= DATA;
		   end if; 
		   if cs = byte2 then 
		   	 dout(23 downto 16) <= DATA;
		   end if; 
		   if cs = byte3 then 
		   	 dout(31 downto 24) <= DATA;
		   end if; 

		   if mendelta = '1' then
		      MD <= lmd;
 		   end if;


		   -- crc
		   if newf = '1' then
		      crcl <= (others => '0');
		   else
		      if brdy = '1' then 
			    crcl <= crc;
  	           end if;
             end if; 


		   -- byte counter
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

   -- combinational stuff
   mendelta <= (not menl) and men;
   lma <= bp when wbp = '1' else macnt;
   BPOUT <= bp; 

   CEOUT <= ceforce or brdy;
   brdy <= (not ENDF) and drdy;
   drdy <= not EMPTY; 

   lmd <= dout when wbp ='0' else ("0000000000000000" & bcnt);


   fsm: process(CS, drdy, data, brdy, ENDF, crcl) is
   begin
       case cs is 
 	  	when none => 
		    men <= '1';
		    newf <= '1';
		    ceforce <= '1';
		    wbp <= '0';
		    if brdy = '1' and data = "11010101" then
		    	  ns <= byte0;
		    else
		    	  ns <= none;
		    end if;
 	  	when byte0 => 
		    men <= '1';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    if endf = '1' then 
		       ns <= errchk;
		    else
		       if brdy = '1' then
			  	ns <= byte1;
			  else
			  	ns <= byte0;
			  end if;
		    end if; 
 	  	when byte1 => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    if endf = '1' then 
		       ns <= memwait1;
		    else
		       if brdy = '1' then
			  	ns <= byte2;
			  else
			  	ns <= byte1;
			  end if;
		    end if; 
 	  	when byte2 => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    if endf = '1' then 
		       ns <= memwait2;
		    else
		       if brdy = '1' then
			  	ns <= byte3;
			  else
			  	ns <= byte2;
			  end if;
		    end if; 
  	  	when byte3 => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    if endf = '1' then 
		       ns <= memwait3;
		    else
		       if brdy = '1' then
			  	ns <= byte0;
			  else
			  	ns <= byte3;
			  end if;
		    end if; 
  	  	when memwait1 => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    ns <= memwait2;
  	  	when memwait2 => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    ns <= memwait3;
  	  	when memwait3 => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    ns <= errchk;
  	  	when errchk => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    if data(2) = '0' and crcl = X"00000000" then
		    	  ns <= wait1;
		    else
		       ns <= none; 
		    end if; 		
  	  	when wait1 =>
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    ns <= wait2; 
  	  	when wait2 =>
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '0';
		    ns <= writebp;
  	  	when writebp => 
		    men <= '1';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '1';
		    ns <= none;
  	  	when others  => 
		    men <= '0';
		    newf <= '0';
		    ceforce <= '0';
		    wbp <= '1';
		    ns <= none; 
	 end case; 
   end process fsm; 
 
end Behavioral;
