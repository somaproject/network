library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
    Port (	CLK : in std_logic;
	 			CLKSLEN : in std_logic; 
	 			RESET : in std_logic; 
				SCLK : in std_logic;
				SCS : in std_logic;
				SIN : in std_logic;
				SOUT : out std_logic;
				LEDACT : out std_logic;
				LEDTX : out std_logic;
				LEDRX : out std_logic;			   c0o  
				LED100 : out std_logic;
				LED1000 : out std_logic;
				LEDDPX : out std_logic;
				PHYRESET: out std_logic; 
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
				RXALLF : out std_logic; 
				MACADDR : out std_logic_vector(47 downto 0);
				MDIO : inout std_logic;
				MDC : out std_logic;
				MDEBUGADDR : out std_logic_vector(16 downto 0);
				MDEBUGDATA : in std_logic_vector(31 downto 0);
				RXBP : in std_logic_vector(15 downto 0);
				RXFBBP : in std_logic_vector(15 downto 0);
				TXBP : in std_logic_vector(15 downto 0);
				TXFBBP : in std_logic_vector(15 downto 0));

end control;

architecture Behavioral of control is
-- CONTROL.VHD -- control and management interface. This is the
-- serial interface that takes care of booting the PHY, keeping
-- track of counters, and toggling the blinkenlights . It also
-- lets the external interface deal with all of these things.
-- 
-- now keep in mind that we have EVERYTHING IN THIS MODULE gated
-- to the /8 clock enable-- 

   -- clock-related
   signal sclkl, sclkll, lsclkdelta, sclkdelta, sclkdeltal,
   		sclkdeltall, sclkdeltalll :
   		std_logic := '0';
   signal bitcnt : std_logic_vector(5 downto 0) := (others => '0');
   signal scsl, scsll, scslll : std_logic := '0';
	signal newcmd : std_logic := '0';


   -- data signals
   signal sinl, sinll, sinlll : std_logic := '0'; 
   signal addr, addrl
   		 : std_logic_vector(7 downto 0) := (others => '0');
   signal din, dout : std_logic_vector(31 downto 0) := (others => '0');
   signal douten : std_logic := '0'; 
   signal rw : std_logic := '0';

   -- counters
   signal txf_cnt, rxf_cnt, txfifowerr_cnt, rxfifowerr_cnt,
   		rxphyerr_cnt, rxoferr_cnt, rxcrcerr_cnt :
		std_logic_vector(31 downto 0) := (others => '0');
   signal txf_cntl, rxf_cntl, txfifowerr_cntl, rxfifowerr_cntl,
   		rxphyerr_cntl, rxoferr_cntl, rxcrcerr_cntl :
		std_logic_vector(31 downto 0) := (others => '0');

   signal txf_rst, rxf_rst, txfifowerr_rst, rxfifowerr_rst,
   		rxphyerr_rst, rxoferr_rst, rxcrcerr_rst :
		std_logic := '0';

	-- latches for SR
	signal txf_sr, rxf_sr, txfifowerr_sr, rxfifowerr_sr,
			rxphyerr_sr, rxoferr_sr, rxcrcerr_sr : std_logic := '0';


   -- muxing...
   signal doutmux, doutmuxl
   		 : std_logic_vector(31 downto 0) := (others => '0');

   -- MAC-related address and packet descriptions
   signal lmacaddr : std_logic_vector(47 downto 0) := (others => '0');
   signal lrxbcast, lrxmcast, lrxucast: std_logic := '0';
   signal lrxallf : std_logic := '1';

   signal phyrstcnt : integer := 2000; 


	-- phy status components
	signal phyaddrr, phyaddrw : std_logic := '0';
	signal phyaddr, phydi, phydo, phystat
			 : std_logic_vector(31 downto 0) := (others => '0');

	-- led counters

	signal txf_cross, ledtx_rst : std_logic := '0';
	signal ledtx_cnt : std_logic_vector(11 downto 0) := (others => '0');
	signal rxf_cross, ledrx_rst : std_logic := '0';
	signal ledrx_cnt : std_logic_vector(11 downto 0) := (others => '0');


	-- debug signals
	signal debugaddr : std_logic_vector(16 downto 0) := (others => '0');
	signal debugdata : std_logic_vector(31 downto 0) := (others => '0'); 
	signal rxbpl, txbpl, rxfbbpl, txfbbpl: std_logic_vector(15 downto 0) 
			:= (others => '0'); 

	component PHYstatus is
	    Port ( CLK : in std_logic;
		 		  CLKSLEN : in std_logic; 
	           PHYDIN : in std_logic_vector(15 downto 0);
	           PHYDOUT : out std_logic_vector(15 downto 0);
	           PHYADDRSTATUS : out std_logic;
	           PHYADDR : in std_logic_vector(5 downto 0);
	           PHYADDRR : in std_logic;
	           PHYADDRW : in std_logic;
	           PHYSTAT : out std_logic_vector(31 downto 0);
	           RESET : in std_logic;
				  MDIO : inout std_logic;
				  MDC : out std_logic );
	end component;


begin


	PHY_status : PHYstatus port map (
					CLK => CLK,
					CLKSLEN => CLKSLEN, 
					PHYDIN => phydi(15 downto 0),
					PHYDOUT => phydo(15 downto 0),
					PHYADDRSTATUS => phyaddr(31),
					PHYADDR => phyaddr(5 downto 0),
					PHYADDRR => phyaddrr, 
					PHYADDRW => phyaddrw,
					PHYSTAT => phystat,
					RESET => RESET,
					MDIO => MDIO,
					MDC => MDC);


   douten <= '1' when sclkdeltall = '1' and bitcnt = 8 else '0'; 
   slow_clock: process(CLK, RESET) is
   begin
		if RESET = '1' then
			lrxallf <= '1';
		else
	   	if rising_edge(CLK) then
				if CLKSLEN = '1' then 
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
				    SOUT <= dout(31); 



				    if scslll = '1' then
				    	   bitcnt <= "000000";
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
				    	  din <= din(30 downto 0) & sinlll;
				    end if; 


				    -- data in register
				    if douten = '1' then
					  dout <= doutmux; 
				    else
				       if sclkdelta = '1' and bitcnt > 7 and rw = '0' then
						dout <= dout(30 downto 0)  & '0'; 
					  end if; 
				    end if;
	    
	    

				    -- resetting the counters
					if DIN(0) = '1' and newcmd = '1' and
				    	  addr(4 downto 0) = "10000" then
							txf_rst <= '1'; 
				    else
				    	  txf_rst <= '0';
				    end if;

				    if DIN(1) = '1' and newcmd = '1' and
				    	  addr(4 downto 0) = "10000" then
					  rxf_rst <= '1'; 
				    else
				    	  rxf_rst <= '0';
				    end if;

				    if DIN(2) = '1' and newcmd = '1' and
				    	  addr(4 downto 0) = "10000" then
					  txfifowerr_rst <= '1'; 
				    else
				    	  txfifowerr_rst <= '0';
				    end if;

				    if DIN(3) = '1' and newcmd = '1' and
				    	  addr(4 downto 0) = "10000" then
					  rxfifowerr_rst <= '1'; 
				    else
				    	  rxfifowerr_rst <= '0';
				    end if;

				    if DIN(4) = '1' and newcmd = '1' and
				    	  addr(4 downto 0) = "10000" then
					     rxphyerr_rst <= '1'; 
				    else
				    	  rxphyerr_rst <= '0';
				    end if;

				    if DIN(5) = '1' and newcmd = '1' and
				    	  	addr(4 downto 0) = "10000" then
					  		rxoferr_rst <= '1'; 
				    else
				    	  rxoferr_rst <= '0';
				    end if;

				    if DIN(6) = '1' and newcmd = '1' and
				    	  	addr(4 downto 0) = "10000" then
					  		rxcrcerr_rst <= '1'; 
				    else
				    	  rxcrcerr_rst <= '0';
				    end if;


				 -- phy-related registers
					if addr(4 downto 0) = "01000" and rw = '1' and
						newcmd = '1' then 
				  		phyaddr(30 downto 0) <= din(30 downto 0);
			    	end if; 

					if addr(4 downto 0) = "01001" and rw = '1' and
						newcmd = '1' then 
				  		phydi(31 downto 0) <= din(31 downto 0);
			    	end if;
			 


				    -- latching the counters into our time frame


				    -- mac packet types
				    if addr(4 downto 0) = "11010" and rw = '1' and
				    	  newcmd = '1' then 
					  lrxbcast <= din(0);
				    end if; 
				    if addr(4 downto 0) = "11011" and rw = '1' and
				    	  newcmd = '1' then 
					  lrxmcast <= din(0);
				    end if; 
				    if addr(4 downto 0) = "11100" and rw = '1' and
				    	  newcmd = '1' then 
					  lrxucast <= din(0);
				    end if; 
				    if addr(4 downto 0) = "11001" and rw = '1' and
				    	  newcmd = '1' then 
					  		lrxallf <= din(0);
				    end if; 

				    -- mac address parts
				    if addr(4 downto 0) = "11101" and rw = '1' and
				    	  newcmd = '1' then 
					  		lmacaddr(15 downto 0) <= din(15 downto 0);
				    end if; 
				    if addr(4 downto 0) = "11110" and rw = '1' and
				    	  newcmd = '1' then 
					  	lmacaddr(31 downto 16) <= din(15 downto 0);
				    end if; 
				    if addr(4 downto 0) = "11111" and rw = '1' and
				    	  newcmd = '1' then 
					  lmacaddr(47 downto 32) <= din(15 downto 0);
				    end if;
					 
					 -- debugging
					 if addr(4 downto 0) = "00100" and rw = '1' and
					 		newcmd = '1' then
								debugaddr <= din(16 downto 0); 
					 end if; 

					 MDEBUGADDR <= debugaddr; 
					 debugdata <= MDEBUGDATA; 
					  

				    -- phy reset
					if din(0) = '1' and addr(4 downto 0) = "00001" and 
		   			rw = '1' and newcmd = '1' then
						phyrstcnt <= 2000;
			    	else
			    		if phyrstcnt >0 then
			    			phyrstcnt <= phyrstcnt - 1;
					    	PHYRESET <= '0';  
						else
							PHYRESET <= '1';
						end if; 	
					end if; 


					-- LEDS
					LED1000 <= phystat(4) and (not phystat(3));
					LED100 <= phystat(3) and (not phystat(4));
					LEDDPX <= phystat(1);
					LEDACT <= phystat(2); 

					ledtx_rst <= txf_cross; 
					if ledtx_rst = '1' then
						ledtx_cnt <= X"FFF";
					else
						if not (ledtx_cnt = X"000") then
							ledtx_cnt <= ledtx_cnt - 1;
						end if;
					end if; 

					if ledtx_cnt = X"000" then
						LEDTX <= '0';
					else
						LEDTX <= '1';
					end if;  					  	

					ledrx_rst <= rxf_cross; 
					if ledrx_rst = '1' then
						ledrx_cnt <= X"FFF";
					else
						if not (ledrx_cnt = X"000") then
							ledrx_cnt <= ledrx_cnt - 1;
						end if;													  
					end if; 

					if ledrx_cnt = X"000" then
						LEDRX <= '0';
					else
						LEDRX <= '1';
					end if;

					-- pointers
					rxbpl <= RXBP;
					txbpl <= TXBP;
					rxfbbpl <= RXFBBP; 
					txfbbpl <= TXFBBP; 

			end if;   					  	
	  end if; 
	end if; 
   end process slow_clock; 

				    txf_cntl <= txf_cnt;
				    rxf_cntl <= rxf_cnt;
				    txfifowerr_cntl <= txfifowerr_cnt;
				    rxfifowerr_cntl <= rxfifowerr_cnt;
				    rxphyerr_cntl <= rxphyerr_cnt;
				    rxoferr_cntl <= rxoferr_cnt;
				    rxcrcerr_cntl <= rxcrcerr_cnt;

   lsclkdelta <= (not sclkll) and (sclkl);
   rw <= addr(7); 
   
	phyaddrw <=  '1' when addr(4 downto 0) = "01000" and rw = '1' and
						newcmd = '1' else '0';

	phyaddrr <=  '1' when addr(4 downto 0) = "01000" and rw = '0' and
						douten ='1' else '0';
	newcmd <= '1' when sclkdeltal = '1' and bitcnt = 40 else
				 '0'; 



   -- address decoding!!
   addr_mux : process(addr, rxcrcerr_cntl, rxoferr_cntl, 
   				  rxphyerr_cntl, txfifowerr_cntl, lmacaddr,
				  rxfifowerr_cntl, txf_cntl, rxf_cntl, phystat, phyaddr, phydi, phydo,
				  debugaddr, debugdata, lrxallf, lrxbcast, lrxmcast, lrxucast) is
   begin
		case addr(5 downto 0) is
			when "000000" => doutmux <= X"01234567"; 
	 		when "000010" => doutmux <= phystat;
			when "000011" => doutmux <= X"89ABCDEF";
			when "000100" => doutmux <= X"000" & "000" & debugaddr; 
			when "000101" => doutmux <= debugdata;
			when "000110" => doutmux <= rxbpl  & rxfbbpl;
			when "000111" => doutmux <= txbpl & txfbbpl; 
			when "001000" => doutmux <= phyaddr; 
			when "001001" => doutmux <= phydi;
			when "001010" => doutmux <= phydo; 
			when "010001" => doutmux <= txf_cntl;
			when "010010" => doutmux <= rxf_cntl; 
			when "010011" => doutmux <= txfifowerr_cntl; 
			when "010100" => doutmux <= rxfifowerr_cntl; 
			when "010101" => doutmux <= rxphyerr_cntl; 
			when "010110" => doutmux <= rxoferr_cntl; 
			when "010111" => doutmux <= rxcrcerr_cntl;
			when "011001" => doutmux <= X"0000000" & "000" & lrxallf;
			when "011010" => doutmux <= X"0000000" & "000" & lrxbcast;
			when "011011" => doutmux <= X"0000000" & "000" & lrxmcast;
			when "011100" => doutmux <= X"0000000" & "000" & lrxucast;
			when "011101" => doutmux <= X"0000" & lmacaddr(15 downto 0);
			when "011110" => doutmux <= X"0000" & lmacaddr(31 downto 16);
			when "011111" => doutmux <= X"0000" & lmacaddr(47 downto 32);
			when others =>  doutmux <= (others => '0');
		end case;  
	end process addr_mux; 


   counters: process(CLK) is
   begin
   	if rising_edge(CLK) then
			if CLKSLEN = '1' then
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

	   
			   RXBCAST <= lrxbcast;
			   RXMCAST <= lrxmcast;
			   RXUCAST <= lrxucast;
				RXALLF  <= lrxallf; 
			   MACADDR <= lmacaddr; 

				-- LED-based clock transfer
				txf_cross <= TXF;
				rxf_cross <= RXF; 
		  end if; 
		end if; 
   end process counters; 

end Behavioral;
