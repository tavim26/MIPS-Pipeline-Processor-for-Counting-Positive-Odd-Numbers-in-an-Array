
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
     Port ( Instr: in std_logic_vector(5 downto 0);
     
            RegDst: out std_logic;
            ExtOp: out std_logic;            
            ALUSrc: out std_logic; 
            Branch: out std_logic; 
            Brne: out std_logic;
            Brgtz: out std_logic;
            Jump: out std_logic;
            ALUOp: out std_logic_vector(1 downto 0);
            MemWrite: out std_logic;
            MemtoReg: out std_logic;
            RegWrite: out std_logic
        );
end UC;

architecture Behavioral of UC is

begin
    process(Instr)
    begin 
    
    
    RegDst <= '0'; 
    ExtOp <= '0'; 
    ALUSrc <= '0';
    Branch <= '0'; 
    Brne <='0';
    Brgtz <='0';
    Jump <='0'; 
    MemWrite <= '0';
    MemtoReg <= '0'; 
    RegWrite <= '0'; 
    ALUOp <= "00";
    
    
    case Instr is
    
        when "000000" => --ADD
        
         RegDst <= '1'; 
         ExtOp <= 'X'; 
         ALUSrc <= '0';
         Branch <= '0'; 
         Brne <='0';
         Brgtz <='0';
         Jump <='0'; 
         MemWrite <= '0';
         MemtoReg <= '0'; 
         RegWrite <= '1'; 
         ALUOp <= "10";
        
        
        when "001000" => --ADDI
        
        RegDst <= '0';
        ExtOP<='1';
        ALUSrc<='1';
        Branch <= '0';
        Brne <='0';
        Brgtz <='0';
        Jump <= '0';
        MemWrite <='0';
        MemtoReg <='0';
        RegWrite <='1';
        ALUOp<="00";
        
        when "001100" => --ANDI
        
        RegDst <= '0';
        ExtOP<='1';
        ALUSrc<='1';
        Branch <= '0';
        Brne <='0';
        Brgtz <='0';
        Jump <= '0';
        MemWrite <='0';
        MemtoReg <='0';
        RegWrite <='1';
        ALUOp<="11";
        
        when "100011" => --lw
        
        RegDst <= '0';
        ExtOP<='1';
        ALUSrc<='1';
        Branch <= '0';
        Brne <='0';
        Brgtz <='0';
        Jump <= '0';
        MemWrite <='0';
        MemtoReg <='1';
        RegWrite <='1';
        ALUOp<="00";
        
        when "101011" => --sw
        
        RegDst <= 'X';
        ExtOP<='1';
        ALUSrc<='1';
        Branch <= '0';
        Brne <='0';
        Brgtz <='0';
        Jump <= '0';
        MemWrite <='1';
        MemtoReg <='X';
        RegWrite <='0';
        ALUOp<="00";
        
        when "000100" => --BEQ
        
        RegDst <= 'X';
        ExtOP<='1';
        ALUSrc<='0';
        Branch <= '1';
        Brne <='0';
        Brgtz <='0';
        Jump <= '0';
        MemWrite <='0';
        MemtoReg <='X';
        RegWrite <='0';
        ALUOp<="01";
        
        
        when "000101" => --BNE
        
        RegDst <= 'X';
        ExtOP<='1';
        ALUSrc<='0';
        Branch <= '0';
        Brne <='1';
        Brgtz <='0';
        Jump <= '0';
        MemWrite <='0';
        MemtoReg <='X';
        RegWrite <='0';
        ALUOp<="01";
        
        when "000010" => --J
        
        RegDst <= 'X';
        ExtOP<='X';
        ALUSrc<='0';
        Branch <= '0';
        Brne <='0';
        Brgtz <='0';
        Jump <= '1';
        MemWrite <='0';
        MemtoReg <='X';
        RegWrite <='0';
        ALUOp<="XX";
        
        when "000111" => --BGTZ
        
        RegDst <= 'X';
        ExtOP<='1';
        ALUSrc<='0';
        Branch <= '0';
        Brne <='0';
        Brgtz <='1';
        Jump <= '0';
        MemWrite <='0';
        MemtoReg <='X';
        RegWrite <='0';
        ALUOp<="01";
        
        
        when others =>
        
        RegDst <= 'X';
        ExtOP<='X';
        ALUSrc<='X';
        Branch <= 'X';
        Brne <='X';
        Brgtz <='X';
        Jump <= 'X';
        MemWrite <='X';
        MemtoReg <='X';
        RegWrite <='X';
        ALUOp<="XX";
        
    end case;
        
    end process;    

end Behavioral;