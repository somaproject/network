library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXoutput is
    Port ( CLK : in std_logic;
    		 CLKEN : in std_logic; 
    		 RESET : in std_logic;
           BPIN : in std_logic_vector(15 downto 0);
           MA : out std_logic_vector(15 downto 0);
           MQ : in std_logic_vector(31 downto 0);
           CLKOUT : in std_logic;
		 NEXTFRAME : in std_logic; 
           DOUT : out std_logic_vector(15 downto 0);
           DOUTEN : out std_logic);
end RXoutput;

architecture Behavioral of RXoutput is
-- RXOUTPUT.VHD -- system for implementing the post-RAM FIFO
-- side of the receiving system. Lots of clock-boundary crossing
-- here, be careful!

   --MA code
   signal bp, macnt, lbp, bpl, len: std_logic_vector(15 downto 0) := 
   					(others => '0');	
   signal lenen, bpen, mainc, mald, lmasel: std_logic := '0';

   -- data registers
   signal mdl : std_logic_vector(31 downto 0) := (others => '0');
   signal lma : std_logic_vector(15 downto 0) := (others => '0');

   -- fifo signals
   signal fifodin, fifodout: std_logic_vector(15 downto 0) := 
   					   (others =>'0');
   signal fifo_full, fifo_nearfull, cein: std_logic := '0';
   signal fifo_wrcount : std_logic_vector(1 downto 0) := "00";
   signal fifo_reset : std_logic := '0'; 
   signal ceout, invalid, ceinl : std_logic := '0';
   signal fe, ff : std_logic := '0'; 


   -- new-frame signals
   signal nf, nfl, nfdelta : std_logic :=  '0';
   signal den, denl, denll, ldouten : std_logic := '0';
   
   -- state machine
   type states is (none, waitclken, swait0, swait1, swait2, swait3, 
   			    latchlen, wait0, wait1, startw, lowbyte,
			    highbyte, nextw, fifonop, reincmac, waitdone,
			    latchbp); 
   signal cs, ns : states := none; 

	component rxoutput_async_fifo IS
		port (
		din: IN std_logic_VECTOR(15 downto 0);
		wr_en: IN std_logic;
		wr_clk: IN std_logic;
		rd_en: IN std_logic;
		rd_clk: IN std_logic;
		ainit: IN std_logic;
		dout: OUT std_logic_VECTOR(15 downto 0);
		full: OUT std_logic;
		empty: OUT std_logic;
		wr_count: OUT std_logic_VECTOR(1 downto 0);
		rd_err: OUT std_logic);
	END component;

begin

   fifo : rxoutput_async_fifo port map (
   		din => fifodin,
		wr_en => ceinl,
		wr_clk => clk,
		rd_en => denll,
		rd_clk => CLKOUT,
		ainit => fifo_reset,
		dout => fifodout,
		full => ff,
		empty => fe,
		wr_count => fifo_wrcount,
		rd_err => invalid);


   int_clock: process(RESET, CLK) is
   begin
     if RESET = '1' then
	   cs <= none;
     else
	   if rising_edge(CLK) then
	      cs <= ns; 

		 mdl <= MQ; 

		 if lenen = '1' then 
		    len <= mdl(15 downto 0);
 		 end if; 

		 if bpen = '1' then 
		    bp <= lbp;
           end if; 	  

		 if mald = '1' then 
		    macnt <= bp;
		 else
		    if mainc = '1' then
		       macnt <= macnt + '1';
		    end if; 
           end if; 

		 MA <= macnt;

		 fifodin <= lma;
		 ceinl <= cein; 

		 if fifo_wrcount = "11" then 
		 	fifo_full <= '1';
		 else
		 	fifo_full <= '0';
		 end if; 
		 bpl <= bp; 

		 if fifo_wrcount = "10" or fifo_wrcount = "11" then
		     fifo_nearfull <= '1';
		 else
		 	fifo_nearfull <=  '0';
		 end if; 
		 
		 nfl <= nf;  

        end if; 
	end if; 
   end process int_clock;


   -- general combinational for internal clock
   lma <= mdl(15 downto 0) when lmasel = '0'
   		else mdl(31 downto 16); 
   lbp <= len + bp + X"0001"; 
   nfdelta <= nf and (not nfl);

   ext_clock: process(CLKOUT) is
   begin
      if rising_edge(CLKOUT) then
	    DOUT <= fifodout;
	    DOUTEN <= ldouten;
	    nf <= NEXTFRAME;
	    denl <= den;
	    denll <= denl;
	 end if;
   
   end process ext_clock;


   -- combinational for external clock
   ldouten <= denll and (not invalid); 


   -- state machine!!!
   fsm : process(cs, nfdelta, nf, bp, BPIN, bpl, CLKEN, FIFO_FULL,
			  FIFO_NEARFULL, macnt, lbp) is
   begin
      case cs is
	    when none => 
	        mald <= '1';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '1';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';  
		   if nfdelta = '1' then
		      ns <= waitclken;
		   else
		      ns <= none;
	        end if;
	    when waitclken => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';    
	        if (not (bpl = BPIN)) and clken ='1' then
		      ns <= swait0;
	  	   else
		      ns <= waitclken;
		   end if;

	    when swait0 => 
	        mald <= '0';
		   mainc <= '1';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   ns <= swait1;
	    when swait1 => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   ns <= swait2;	    	    
	    when swait2 => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   ns <= swait3;
	    when swait3 => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   ns <= latchlen;
	    when latchlen => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '1';
		   bpen <= '0';   
		   ns <= wait0;
	    when wait0 => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      ns <= wait1;
 		   end if; 
	    when wait1 => 
	        mald <= '0';
		   mainc <= '1';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      ns <= startw;
 		   end if; 
	    when startw => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      ns <= lowbyte;
 		   end if; 
	    when lowbyte => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '1';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      ns <= highbyte;
 		   end if; 
	    when highbyte => 
	        mald <= '0';
		   mainc <= '1';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '1';
		   cein <= '1';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      if fifo_full = '1' then
			    ns <= fifonop;
 			 else
			    ns <= nextw;
			 end if;
 		   end if; 
	    when nextw => 
	        mald <= '0';
		   mainc <= '1';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      if macnt = bpl then
			    ns <= waitdone;
 			 else
			    ns <= startw;
			 end if;
 		   end if; 
	    when fifonop => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      if fifo_nearfull = '1' then
			    ns <= reincmac;
 			 else
			    ns <= fifonop; 
			 end if;
 		   end if; 
	    when reincmac => 
	        mald <= '0';
		   mainc <= '1';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
		   if nf = '0' then 
		      ns <= latchbp;
   		   else
		      ns <= startw;
 		   end if; 
	    when waitdone => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '1'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0'; 
		   bpen <= '0';  
             if nf = '0'  then
			    ns <= latchbp;
 		   else
			    ns <= waitdone;
		   end if;
	    when latchbp => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '1';   
             ns <= none;
	    when others  => 
	        mald <= '0';
		   mainc <= '0';
		   den <= '0'; 
		   fifo_reset <= '0';
		   lmasel <= '0';
		   cein <= '0';
		   lenen <= '0';
		   bpen <= '0';   
             ns <= none;

 	end case; 
   end process fsm; 
end Behavioral;