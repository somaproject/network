library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
    Port ( CLK : in std_logic;
    		 CLKSL : in std_logic; 
           SCLK : in std_logic;
           SCS : in std_logic;
           SIN : in std_logic;
           SOUT : out std_logic;
           LEDACT : out std_logic;
           LEDTX : out std_logic;
           LEDRX : out std_logic;
           LED100 : out std_logic;
           LED1000 : out std_logic;
           LEDDPX : out std_logic;
           TXF : in std_logic;
           RXF : in std_logic;
           TXFIFOWERR : in std_logic;
           RXFIFOWERR : in std_logic;
           RXPHYERR : in std_logic;
           RXOFERR : in std_logic;
           RXCRCERR : in std_logic;
		 RXBCAST : out std_logic;
		 RXMCAST : out std_logic;
		 RXUCAST : out std_logic;
		 MACADDR : out std_logic_vector(47 downto 0));
end control;

architecture Behavioral of control is
-- CONTROL.VHD -- control and management interface. This is the
-- serial interface that takes care of booting the PHY, keeping
-- track of counters, and toggling the blinkenlights . It also
-- lets the external interface deal with all of these things.
-- 
-- now keep in mind that we have two clocks here, CLK and CLKSL,
-- where CLKSL is CLK / 4
-- 
--
 

   -- clock-related
   signal sclkl, sclkll, lsclkdelta, sclkdelta, sclkdeltal,
   		sclkdeltall, sclkdeltalll :
   		std_logic := '0';
   signal bitcnt : std_logic_vector(4 downto 0) := (others => '0');
   signal scsl, scsll, scslll : std_logic := '0';

   -- data signals
   signal sinl, sinll, sinlll : std_logic := '0'; 
   signal addr, addrl
   		 : std_logic_vector(7 downto 0) := (others => '0');
   signal din, dout : std_logic_vector(15 downto 0) := (others => '0');

   signal rw : std_logic := '0';

   -- counters
   signal txf_cnt, rxf_cnt, txfifowerr_cnt, rxfifowerr_cnt,
   		rxphyerr_cnt, rxoferr_cnt, rxcrcerr_cnt :
		std_logic_vector(15 downto 0) := (others => '0');
   signal txf_cntl, rxf_cntl, txfifowerr_cntl, rxfifowerr_cntl,
   		rxphyerr_cntl, rxoferr_cntl, rxcrcerr_cntl :
		std_logic_vector(15 downto 0) := (others => '0');

   signal txf_rst, rxf_rst, txfifowerr_rst, rxfifowerr_rst,
   		rxphyerr_rst, rxoferr_rst, rxcrcerr_rst :
		std_logic := '0';


   -- muxing...
   signal doutmux, doutmuxl
   		 : std_logic_vector(15 downto 0) := (others => '0');

   -- MAC-related address and packet descriptions
   signal lmacaddr : std_logic_vector(47 downto 0) := (others => '0');
   signal lrxbcast, lrxmcast, lrxucast : std_logic := '0';



begin

   slow_clock: process(CLKSL) is
   begin
   	if rising_edge(CLKSL) then
	    -- sclk:
	    sclkl <= SCLK;
	    sclkll <= sclkl;
	    sclkdelta <= lsclkdelta; 
	    sclkdeltal <= sclkdelta; 
	    sclkdeltall <= sclkdeltal; 

	    -- cs:
	    scsl <= SCS;
	    scsll <= scsl;
	    scslll <= scsll; 

	    -- sin
	    sinl <= sin;
	    sinll <= sinl;
	    sinlll <= sinll;

	    -- dout
	    SOUT <= dout(15); 



	    if scslll = '1' then
	    	   bitcnt <= "00000";
	    else
	        if sclkdelta = '1' then 
		      bitcnt <= bitcnt + 1;
		   end if; 
	    end if; 

	    -- address register
	    if sclkdelta = '1' and bitcnt < 8 then
	    	  addr <= addr(6 downto 0) & sinlll;
	    end if; 

	    -- data in register
	    if sclkdelta = '1' and bitcnt > 7 then
	    	  din <= din(14 downto 0) & sinlll;
	    end if; 


	    -- data in register
	    if sclkdeltall = '1' and bitcnt = 8 then
		  dout <= doutmux; 
	    else
	       if sclkdelta = '1' and bitcnt > 7 and rw = '0' then
			dout <= dout(14 downto 0)  & '0'; 
		  end if; 
	    end if;
	    
	    

	    -- resetting the counters
	    if DIN(0) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  txf_rst <= '1'; 
	    else
	    	  txf_rst <= '0';
	    end if;

	    if DIN(1) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  rxf_rst <= '1'; 
	    else
	    	  rxf_rst <= '0';
	    end if;

	    if DIN(2) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  txfifowerr_rst <= '1'; 
	    else
	    	  txfifowerr_rst <= '0';
	    end if;

	    if DIN(3) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  rxfifowerr_rst <= '1'; 
	    else
	    	  rxfifowerr_rst <= '0';
	    end if;

	    if DIN(4) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  rxphyerr_rst <= '1'; 
	    else
	    	  rxphyerr_rst <= '0';
	    end if;

	    if DIN(5) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  rxoferr_rst <= '1'; 
	    else
	    	  rxoferr_rst <= '0';
	    end if;

	    if DIN(6) = '1' and sclkdeltal = '1' and
	    	  addr(4 downto 0) = "10000" then
		  rxcrcerr_rst <= '1'; 
	    else
	    	  rxcrcerr_rst <= '0';
	    end if;

	    -- latching the counters into our time frame
	    txf_cntl <= txf_cnt;
	    rxf_cntl <= rxf_cnt;
	    txfifowerr_cntl <= txfifowerr_cnt;
	    rxfifowerr_cntl <= rxfifowerr_cnt;
	    rxphyerr_cntl <= rxphyerr_cnt;
	    rxoferr_cntl <= rxoferr_cnt;
	    rxcrcerr_cntl <= rxcrcerr_cnt;


	    -- mac packet types
	    if addr(4 downto 0) = "11010" and rw = '1' and
	    	  sclkdeltal = '1' then 
		  lrxbcast <= din(0);
	    end if; 
	    if addr(4 downto 0) = "11011" and rw = '1' and
	    	  sclkdeltal = '1' then 
		  lrxmcast <= din(0);
	    end if; 
	    if addr(4 downto 0) = "11100" and rw = '1' and
	    	  sclkdeltal = '1' then 
		  lrxucast <= din(0);
	    end if; 

	    -- mac address parts
	    if addr(4 downto 0) = "11101" and rw = '1' and
	    	  sclkdeltal = '1' then 
		  lmacaddr(15 downto 0) <= din;
	    end if; 
	    if addr(4 downto 0) = "11110" and rw = '1' and
	    	  sclkdeltal = '1' then 
		  lmacaddr(31 downto 16) <= din;
	    end if; 
	    if addr(4 downto 0) = "11111" and rw = '1' and
	    	  sclkdeltal = '1' then 
		  lmacaddr(47 downto 32) <= din;
	    end if; 

	end if; 
   end process slow_clock; 


   lsclkdelta <= (not sclkll) and (sclkl);
   rw <= addr(7); 
   
    
   -- address decoding!!
   addr_mux : process(addr, rxcrcerr_cntl, rxoferr_cntl, 
   				  rxphyerr_cntl, txfifowerr_cntl,
				  rxfifowerr_cntl, txf_cntl, rxf_cntl) is
   begin
   	case addr(5 downto 0) is
		when "010001" => doutmux <= txf_cntl;
		when "010010" => doutmux <= rxf_cntl; 
		when "010011" => doutmux <= txfifowerr_cntl; 
		when "010100" => doutmux <= rxfifowerr_cntl; 
		when "010101" => doutmux <= rxphyerr_cntl; 
		when "010110" => doutmux <= rxoferr_cntl; 
		when "010111" => doutmux <= rxcrcerr_cntl;
		when others =>  doutmux <= (others => '0');
	end case;  


   end process addr_mux; 

   counters: process(CLK) is
   begin
   	if rising_edge(CLK) then

	   if txf_rst = '1' then
	   	txf_cnt <= (others => '0'); 
	   else
	   	if TXF = '1' then
		   txf_cnt <= txf_cnt + 1;
		end if;
	   end if;

	   if rxf_rst = '1' then
	   	rxf_cnt <= (others => '0'); 
	   else
	   	if RXF = '1' then
		   rxf_cnt <= rxf_cnt + 1;
		end if;
	   end if;

	   if txfifowerr_rst = '1' then
	   	txfifowerr_cnt <= (others => '0'); 
	   else
	   	if TXFIFOWERR = '1' then
		   txfifowerr_cnt <= txfifowerr_cnt + 1;
		end if;
	   end if;

	   if rxfifowerr_rst = '1' then
	   	rxfifowerr_cnt <= (others => '0'); 
	   else
	   	if RXFIFOWERR = '1' then
		   rxfifowerr_cnt <= rxfifowerr_cnt + 1;
		end if;
	   end if;

	   if rxphyerr_rst = '1' then
	   	rxphyerr_cnt <= (others => '0'); 
	   else
	   	if RXPHYERR = '1' then
		   rxphyerr_cnt <= rxphyerr_cnt + 1;
		end if;
	   end if;

	   if rxoferr_rst = '1' then
	   	rxoferr_cnt <= (others => '0'); 
	   else
	   	if RXOFERR = '1' then
		   rxoferr_cnt <= rxoferr_cnt + 1;
		end if;
	   end if;

	   if rxcrcerr_rst = '1' then
	   	rxcrcerr_cnt <= (others => '0'); 
	   else
	   	if RXCRCERR = '1' then
		   rxcrcerr_cnt <= rxcrcerr_cnt + 1;
		end if;
	   end if;

	   -- clock-boundary transfer
	   RXBCAST <= lrxbcast;
	   RXMCAST <= lrxmcast;
	   RXUCAST <= lrxucast;
	   MACADDR <= lmacaddr; 

	end if; 
   end process counters; 

end Behavioral;
