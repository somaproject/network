library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity instructions is
    Port ( CLK : in std_logic;
           CLKEN : in std_logic;
           ID : out std_logic_vector(31 downto 0);
           Z : in std_logic;
           IMDIN : in std_logic_vector(15 downto 0);
           IMADDRW : in std_logic_vector(8 downto 0);
			  RESET : in std_logic;
			  IMSEL : out std_logic;
			  AF : out std_logic_vector(2 downto 0); 
           IMWE : in std_logic);
end instructions;

architecture Behavioral of instructions is
-- INSTRUCTIONS.VHD -- this contains the program counter control logic
--   and the instruction ram (code memory)
-- 
--  We use 2 dual-ported chunks of BlockSelect+ SRAM for the interface
--  each in with a 16-bit read port and a 8-bit write port. The write
--  port is configured such that an external agent (like the debugger)
--  can write to the memory. 			 


	signal addrr, pcin, pcout : std_logic_vector(7 downto 0) := "00000000";
	signal dout : std_logic_vector(31 downto 0) := (others => '0');
	signal pcmux, pcsel, jtype : std_logic; 
	signal afsrc: std_logic; 
	signal caf : std_logic_vector(2 downto 0);

	component RAMB4_S8_S16
	  generic (
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
	       INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
			 ); 
	  port (DIA    : in STD_LOGIC_VECTOR (7 downto 0);
	        DIB    : in STD_LOGIC_VECTOR (15 downto 0);
	        ENA    : in STD_logic;
	        ENB    : in STD_logic;
	        WEA    : in STD_logic;
	        WEB    : in STD_logic;
	        RSTA   : in STD_logic;
	        RSTB   : in STD_logic;
	        CLKA   : in STD_logic;
	        CLKB   : in STD_logic;
	        ADDRA  : in STD_LOGIC_VECTOR (8 downto 0);
	        ADDRB  : in STD_LOGIC_VECTOR (7 downto 0);
	        DOA    : out STD_LOGIC_VECTOR (7 downto 0);
	        DOB    : out STD_LOGIC_VECTOR (15 downto 0)); 
	end component;

begin

	ID <= DOUT; 
	
	-- program counter logic
	PC: process (CLK, CLKEN, PCSEL, JTYPE, Z, pcout, pcmux, dout, addrr, pcin) is
	begin
	 	-- PC multiplexor control
		pcmux <= pcsel AND (jtype OR Z);
		if pcmux = '0' then
			addrr <= pcout;
		else
			addrr <= dout(7 downto 0);
		end if; 

		pcin <= addrr + 1;

		if rising_edge(CLK) then
			if CLKEN = '1' then
				if RESET = '1' then 
				     pcout <= (others => '0');
				else
					pcout <= pcin;
				end if; 
			end if;
		end if; 
	end process PC; 

	-- special decoding 
	IMSEL <= DOUT(28);
	AFSRC <= '1' when DOUT(31 downto 28) = "1000" else
				'0';
	pcsel <= '1' when DOUT(31 downto 28) = "1001" else
				'0'; 
	jtype <= DOUT(16);
	 

	AF <= CAF when AFSRC = '0' else
			DOUT(15 downto 13);

	process(DOUT) is
	begin
		case DOUT(31 downto 28) is
			when "0000" => CAF <= "000";
			when "0001" => CAF <= "001";
			when "0010" => CAF <= "010";
			when "0011" => CAF <= "011";
			when "0100" => CAF <= "000";
			when "0101" => CAF <= "001";
			when "0110" => CAF <= "010";
			when "0111" => CAF <= "011";
			when "1000" => CAF <= "100";
			when "1001" => CAF <= "000";
			when "1010" => CAF <= "100";
			when "1011" => CAF <= "100";
			when "1100" => CAF <= "100";
			when "1101" => CAF <= "100";
			when "1110" => CAF <= "100";
			when "1111" => CAF <= "100";
			when others => NULL;
		end case; 
	end process;
	 	
		

	-- RAMs
	RAMh:  RAMB4_S8_S16
	  generic map (
	       INIT_00 => X"0000000000000000000000000000000000000000000000010000000300020001",
	       INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
			 ) 
	  port map (
	  		  DIA  => IMDIN(15 downto 8),
	        DIB  => "0000000000000000",
	        ENA  => '1',
	        ENB  => CLKEN,
	        WEA  => IMWE,
	        WEB  => '0',
	        RSTA   => RESET,
	        RSTB   => RESET,
	        CLKA => CLK,
	        CLKB => CLK,
	        ADDRA => IMADDRW,
	        ADDRB => ADDRR,
	        DOA   => open, 
	        DOB   => DOUT(31 downto 16) 
			  ); 


	RAMl:  RAMB4_S8_S16
	  generic map (
	       INIT_00 => X"000000000000000000000000000000000000000000000001000D000C000B000A",
	       INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
	       INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
			 ) 
	  port map (
	  		  DIA  => IMDIN(7 downto 0),
	        DIB  => "0000000000000000",
	        ENA  => '1',
	        ENB  => CLKEN,
	        WEA  => IMWE,
	        WEB  => '0',
	        RSTA   => RESET,
	        RSTB   => RESET,
	        CLKA => CLK,
	        CLKB => CLK,
	        ADDRA => IMADDRW,
	        ADDRB => ADDRR,
	        DOA   => open, 
	        DOB   => DOUT(15 downto 0) 
			  ); 


end Behavioral;
