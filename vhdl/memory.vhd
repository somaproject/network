library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity memory is
    Port ( CLK : in std_logic;
           CLKOUT : out std_logic;
		 RESET : in std_logic;
           DQEXT : inout std_logic_vector(31 downto 0) ;
           WEEXT : out std_logic;
           ADDREXT : out std_logic_vector(16 downto 0);
           ADDR1 : in std_logic_vector(16 downto 0);
           ADDR2 : in std_logic_vector(16 downto 0);
           ADDR3 : in std_logic_vector(16 downto 0);
           ADDR4 : in std_logic_vector(16 downto 0);
           D1 : in std_logic_vector(31 downto 0);
           D2 : in std_logic_vector(31 downto 0);
           D3 : in std_logic_vector(31 downto 0);
           D4 : in std_logic_vector(31 downto 0);
           Q1 : out std_logic_vector(31 downto 0);
           Q2 : out std_logic_vector(31 downto 0);
           Q3 : out std_logic_vector(31 downto 0);
           Q4 : out std_logic_vector(31 downto 0);
           WE1 : in std_logic;
           WE2 : in std_logic;
           WE3 : in std_logic;
           WE4 : in std_logic;
           CLKEN1 : out std_logic;
           CLKEN2 : out std_logic;
           CLKEN3 : out std_logic;
           CLKEN4 : out std_logic);
end memory;

architecture Behavioral of memory is
-- MEMORY.VHD -- multiplexed memory controller
   signal wen, we : std_logic := '0';
   signal addrn, addr : std_logic_vector(16 downto 0) := (others => '0');
   signal oe, oel, ts: std_logic := '0';
   signal dn, dnl1, dnl2, dnout : std_logic_vector(31 downto 0) :=
   							(others => '0');
   signal qn, q : std_logic_vector(31 downto 0) := (others => '0');
   
   signal clk1, clk2, clk3, clk4: std_logic := '0';
   signal clknum : integer range 0 to 3 := 0; 


	component IOBUF
	      port (I, T: in std_logic; 
	            O: out std_logic; 
	            IO: inout std_logic);
	end component;       

	component OBUF
	      port (I: in std_logic; O: out std_logic);
	end component;   
	 
begin

   -- maybe we'll do some sort of funky de-skew
   CLKOUT <= CLK; 

   weout: obuf port map (
   		I=> we, O=> WEEXT);
		
   datablock: for i in 0 to 31 generate 
	   qdout: iobuf port map (
	   		I => dnout(i), 
			 O => q(i), 
			 T => ts,
			 IO => DQEXT(i)); 
   end generate;
   
   addrblock: for i in 0 to 16 generate
	   addrout: obuf port map (
	   		I=> addr(i), O=> ADDREXT(i));     	   	
   end generate; 

   clock: process(CLK) is
   begin
      if rising_edge(CLK) then
	    if clknum =3 then 
	       clknum <= 0;
 	    else
	       clknum <= clknum  + 1; 
  	    end if; 

	    oe <= wen;
	    oel <= oe; 
	    ts <= not oel; 
	    dnl1 <= dn;
	    dnl2 <= dnl1;
	    dnout <= dnl2;

	    qn <= q;
	    we <= wen; 
	    addr <= addrn; 

	    if clknum = 1 then
	    	  Q1 <= qn;
	    end if; 
	    if clknum = 2 then
	    	  Q2 <= qn;
	    end if; 
	    if clknum = 3 then
	    	  Q3 <= qn;
	    end if; 
	    if clknum = 0 then
	    	  Q4 <= qn;
	    end if; 


	 end if;
   end process clock; 

   addrn <= addr1 when clknum = 0 else
   		  addr2 when clknum = 1 else
		  addr3 when clknum = 2 else
		  addr4; 
   wen <= we1 when clknum = 0 else
    		we2 when clknum = 1 else
		we3 when clknum = 2 else
		we4;
	
   dn <= d1 when clknum = 0 else
   	    d2 when clknum = 1 else
	    d3 when clknum = 2 else
	    d4;
   CLKEN1 <= '1' when clknum = 0 else '0';
   CLKEN2 <= '1' when clknum = 1 else '0';
   CLKEN3 <= '1' when clknum = 2 else '0';
   CLKEN4 <= '1' when clknum = 3 else '0';

	     
end Behavioral;
