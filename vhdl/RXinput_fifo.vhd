library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXinput_fifo is
    Port ( RX_CLK : in std_logic;
    		 RESET : in std_logic; 
           ENDFIN : in std_logic;
           DIN : in std_logic_vector(7 downto 0);
           NEARF : out std_logic;
           CEIN : in std_logic;
           CLK : in std_logic;
           CE : in std_logic;
           DATA : out std_logic_vector(7 downto 0);
           ENDF : out std_logic;
           INVALID : out std_logic);
end RXinput_fifo;

architecture Behavioral of RXinput_fifo is
-- RXINPUT_FIFO.vhd -- FIFO and additional control logic. 


     
	signal dout: std_logic_vector(9 downto 0) := (others => '0');
	signal fifodin, fifodout : std_logic_vector(15 downto 0) :=
		  (others => '0');
	signal invout : std_logic := '0'; 
	signal rd_en : std_logic := '0';
	signal wr_count : std_logic_vector(1 downto 0) := "00";
	

	component async_fifo IS
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

	component rxinput_fifocontrol is
	    Port ( CLK : in std_logic;
	    		 RESET : in std_logic; 
	           CEOUT : out std_logic;
			 CE : in std_logic; 
	           DIN : in std_logic_vector(9 downto 0);
	           DATA : out std_logic_vector(7 downto 0);
	           ENDF : out std_logic;
	           INVALID : out std_logic);
	end component;

begin
    fifodin <= "0000000" & ENDFIN & DIN;
    dout <= invout & fifodout(8 downto 0);     

    NEARF <= '1' when wr_count = "10" or wr_count = "11" else '0';


    fifo: async_fifo port map(
    		din => fifodin, 
		wr_en =>	CEIN, 
		wr_clk => RX_CLK,
		rd_en => rd_en, 
		rd_clk => CLK,
		ainit => RESET,
		dout => fifodout,
		full => open,
		empty => open,
		wr_count => wr_count, 
		rd_err => invout );
	
    control: rxinput_fifocontrol port map (
    		CLK => CLK,
		RESET => RESET,
		CEOUT => rd_en, 
		CE => CE,
		DIN => dout, 
		DATA =>  DATA,
		ENDF =>  ENDF, 
		INVALID => INVALID
		);  


end Behavioral;
