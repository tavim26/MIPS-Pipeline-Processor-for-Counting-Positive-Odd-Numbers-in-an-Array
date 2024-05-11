

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity EX is
  Port (
        ALUSrc: in STD_LOGIC;
        ALUOp: in STD_LOGIC_VECTOR (1 downto 0);
        RD1: in STD_LOGIC_VECTOR (31 downto 0);
        RD2: in STD_LOGIC_VECTOR (31 downto 0);
        Ext_Imm: in STD_LOGIC_VECTOR (31 downto 0);
        sa: in STD_LOGIC_VECTOR(4 downto 0);
        func: in STD_LOGIC_VECTOR (5 downto 0);
        
        PCNext: in STD_LOGIC_VECTOR (31 downto 0);
        RegDst: in std_logic;
        rt: in std_logic_vector(4 downto 0);
        rd: in std_logic_vector(4 downto 0);
        
        Zero: out STD_LOGIC;
        Gtz: out STD_LOGIC;
        ALURes: out STD_LOGIC_VECTOR (31 downto 0);
        BranchAddr: out STD_LOGIC_VECTOR (31 downto 0);
        rWA: out std_logic_vector(4 downto 0)
        
   );
end EX;
 
architecture Behavioral of EX is

    signal ALUCtrl: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal b: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal c: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal a: std_logic_vector(31 downto 0);
    
    signal Ext_Imm_shifted: std_logic_vector(31 downto 0);
    
    
begin



ALU_CONTROL: process(ALUOp,func)
begin
    case ALUOp is
    
        when "10" => 
         case func is
            when "100000" =>  ALUCtrl <= "000"; -- cazul add
            when others => ALUCtrl <= "XXX";
         end case;
        when "00" => ALUCtrl <= "000"; --cazul  addi, lw, sw
        when "11" => ALUCtrl <= "100"; --cazul andi
        when "01" => ALUCtrl <= "001"; --in cazul instr beq, bne, bgtz
        when others => ALUCtrl <="XXX"; --in cazul instr. j, se pune don't care
    
    end case;
end process;

--mux mic pentru intrarea b
MUX2_1: b <= RD2 when ALUSrc = '0' else Ext_Imm;
a <= RD1;

ALU: process(ALUCtrl,a,b)
begin

    case ALUCtrl is
        when "000" => c <= a+b;
        when "100" => c <= a and b;
        when "001" => c <= a-b;
        when others =>
        if a<b then
            c<= X"00000001";
        else 
            c<= X"00000000";
        end if;
   
    end case;
    
end process;

Zero <= '1' when c = X"00000000" else '0';

Gtz <= not c(31);

Ext_Imm_shifted <= Ext_Imm(29 downto 0) & "00";
BranchAddr <= PCNext + Ext_Imm_shifted;

ALURes <= c;

--**
rWA <= rt when RegDst = '0' else rd;

end Behavioral;
