library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity CPU is
    Port ( CLK : in std_logic;
           CLKEN : in std_logic;
           IMDIN : in std_logic_vector(15 downto 0);
           IMADDRW : in std_logic_vector(8 downto 0);
			  RESET : in std_logic;
           IMWE : in std_logic;
           YOUT : out std_logic_vector(31 downto 0);
			  MD: out std_logic_vector(31 downto 0);
			  MQ : in std_logic_vector(31 downto 0);
			  MWE : out std_logic			  
			  );
end CPU;

architecture Behavioral of CPU is
-- CPU.vhd -- Network System Central Processing Unit
--  This is the master file for all the CPU components. See CPU.ai
--  under docs/hardware/network for a good overview of what this does.

-- necessary signals
	signal id: std_logic_vector(31 downto 0)  := (others=> '0');
	signal imsel : std_logic := '0';
	signal sfrout : std_logic_vector(31 downto 0)  := (others=> '0'); 
	signal z, zout, n, nout, c, cout : std_logic := '0'; 
	signal af: std_logic_vector(2 downto 0) := "000"; 
	signal ra, rb, rc : std_logic_vector(5 downto 0) := (others=> '0'); -- renamed lines of id
	signal dataa, datab, a, b, y: std_logic_vector(31 downto 0)  := (others=> '0');
	signal mdql : std_logic;


-- ALU component definition
	component ALU is
	    Port ( A : in std_logic_vector(31 downto 0);
	           B : in std_logic_vector(31 downto 0);
	           Y : out std_logic_vector(31 downto 0);
	           AF : in std_logic_vector(2 downto 0);
	           Z : out std_logic;
	           N : out std_logic;
	           CIN : in std_logic;
	           COUT : out std_logic);
	end component;
	component instructions is
	    Port ( CLK : in std_logic;
	           CLKEN : in std_logic;
	           ID : out std_logic_vector(31 downto 0);
	           Z : in std_logic;
	           IMDIN : in std_logic_vector(15 downto 0);
	           IMADDRW : in std_logic_vector(8 downto 0);
				  RESET : in std_logic;
				  IMSEL : out std_logic;
				  AF : out std_logic_vector(2 downto 0);
				  MWE : out std_logic;
				  MDQL : out std_logic;  
	           IMWE : in std_logic);
	end component;

	 component regfile is 
	 port (CLK  : in std_logic;
	 		CLKEN : in std_logic;  
			RESET : in std_logic; 
	 		WE   : in std_logic; 
	 		ADDRA   : in std_logic_vector(4 downto 0);
			ADDRB	  : in std_logic_vector(4 downto 0);  
	 		ADDRW   : in std_logic_vector(4 downto 0); 
	 		DATAA   : out std_logic_vector(31 downto 0); 
	 		DATAB  : out std_logic_vector(31 downto 0); 
	 		DATAW  : in std_logic_vector(31 downto 0)); 
	 end component;

	component SFR is
	    Port ( CLK : in std_logic;
	           CLKEN : in std_logic;
	           Y : in std_logic_vector(31 downto 0);
	           SFROUT : out std_logic_vector(31 downto 0);
			 	  MDD: out std_logic_vector(31 downto 0);
			 	  MDQ: in std_logic_vector(31 downto 0);
			     MDQL: in std_logic; 
	           Rb : in std_logic_vector(5 downto 0));
	end component;
begin

	-- decode ID lines into standard register address lines. 
	-- This isn't really necessary but (IMHO) makes design easier
	-- to understand. 
	ra <= id(15 downto 10);
	rb <= id(21 downto 16);
	rc <= id(27 downto 22); 


	-- instantiate instructions and decoder
	instructions_inst: instructions port map (
				CLK => CLK,
				CLKEN => CLKEN,
				ID => id,
				Z => z,
				IMDIN => IMDIN,
				IMADDRW => IMADDRW,
				RESET => RESET,
				IMSEL => imsel,
				AF => af,
				MDQL => mdql,
				MWE => mwe, 
				IMWE => IMWE);

	-- instantiate register file:
	regfile_inst: regfile port map (
				CLK => CLK,
				CLKEN => CLKEN,
				RESET => RESET,
				WE => rc(5),
				ADDRA => ra(4 downto 0),
				ADDRB => rb(4 downto 0),
				ADDRW => rc(4 downto 0),
				DATAA => dataa,
				DATAB => datab,
				DATAW => y);

	-- instantiate ALU :
	ALU_inst : ALU port map (
				A => a,
				B => b,
				Y => y,
				AF => af, 
				z => zout,
				n => nout,
				cin => c,
				cout => cout);


	-- instantiate, connect special function registers. 
	SFR_inst : SFR port map (
				CLK => CLK,
				CLKEN => CLKEN, 
				Y => y,
				SFROUT => sfrout,
				MDD => MD,
				MDQ => MQ,
				MDQL => mdql,
				Rb => rb);
		  	
	-- combinational selection of inputs for ALU
	a <= dataa when imsel = '0' else
			(id(15) & id(15) & id(15) & id(15) & id(15) & id(15) & id(15) & id(15) & 
			id(15) & id(15) & id(15) & id(15) & id(15) & id(15) & id(15) & id(15) & 
				id(15 downto 0));
	b <= datab when rb(5) = '0' else
			sfrout;

	-- miscellaneous glue logic
	YOUT <= y; 
				 
	glue: process(imsel, CLK, id, dataa, datab, sfrout, rb, zout, nout, cout) is
	begin 



		-- latch bits for flags;
		if rising_edge(CLK) then
			if clken = '1' then
				if reset = '0' then
					z <= '0';
					n <= '0';
					c <= '0';
				else

					z <= zout;
					n <= nout;
					c <= cout;
				end if; 
			end if;
		end if; 

	end process glue; 




end Behavioral;
