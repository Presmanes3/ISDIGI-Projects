module golden_model_autochecks (
    golden_interface wires
);

  property SWp;
   @(posedge wires.clk)
   wires.main_controller_wiring.alu_option==4'b0100 && wires.alu_controller_wiring.func_3_bits== 3'b010 |-> wires.main_controller_wiring.memory_write==1'b1|-> wires.main_controller_wiring.register_write==1'b0|-> wires.main_controller_wiring.alu_source==1'b1|-> wires.main_controller_wiring.branch==1'b0|-> wires.main_controller_wiring.memory_to_register==1'b0 |-> wires.main_controller_wiring.memory_read==1'b0;
   endproperty

   property BEQp;
   @(posedge wires.clk)
   wires.main_controller_wiring.alu_option==4'b1100 && wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.main_controller_wiring.memory_write == 1'b0|-> wires.main_controller_wiring.register_write == 1'b0|-> wires.main_controller_wiring.alu_source == 1'b0|-> wires.main_controller_wiring.branch == 1'b1 |->wires.main_controller_wiring.memory_to_register==1'b0 |->wires.main_controller_wiring.memory_read==1'b0;
   endproperty
   
   property RFORMAT;
    @(posedge wires.clk)
   wires.main_controller_wiring.alu_option==4'b0110 |-> wires.main_controller_wiring.memory_write == 1'b0|-> wires.main_controller_wiring.register_write == 1'b1|-> wires.main_controller_wiring.alu_source == 1'b1|-> wires.main_controller_wiring.branch == 1'b0|-> wires.main_controller_wiring.memory_to_register==1'b0|-> wires.main_controller_wiring.memory_read==1'b0;
   endproperty

   property IFORMAT;
   @(posedge wires.clk)
    wires.main_controller_wiring.alu_option==4'b0010 |-> wires.main_controller_wiring.memory_write == 1'b0|-> wires.main_controller_wiring.register_write == 1'b1|-> wires.main_controller_wiring.alu_source == 1'b1|-> wires.main_controller_wiring.branch == 1'b0|-> wires.main_controller_wiring.memory_to_register==1'b0|->wires.main_controller_wiring.memory_read==1'b0;
   endproperty

   property LWp;
    @(posedge wires.clk)
     wires.main_controller_wiring.alu_option==4'b0000 && wires.alu_controller_wiring.func_3_bits==3'b010 |-> wires.main_controller_wiring.memory_write == 1'b0|-> wires.main_controller_wiring.register_write == 1'b1|-> wires.main_controller_wiring.alu_source == 1'b1|-> wires.main_controller_wiring.branch == 1'b0|-> wires.main_controller_wiring.memory_to_register==1'b1|->wires.main_controller_wiring.memory_read==1'b1;
   endproperty

    property BNEp;
   @(posedge wires.clk)
   wires.main_controller_wiring.alu_option==4'b1100 && wires.alu_controller_wiring.func_3_bits== 3'b001 |-> wires.main_controller_wiring.memory_write == 1'b0|-> wires.main_controller_wiring.register_write == 1'b0|-> wires.main_controller_wiring.alu_source == 1'b0|-> wires.main_controller_wiring.branch == 1'b1 |->wires.main_controller_wiring.memory_to_register==1'b0 |->wires.main_controller_wiring.memory_read==1'b0;
   endproperty

   property LUIp;
   @(posedge wires.clk) 
    wires.main_controller_wiring.alu_option==4'b0111 && wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.main_controller_wiring.memory_write == 1'b0|-> wires.main_controller_wiring.register_write == 1'b1|-> wires.main_controller_wiring.alu_source == 1'b0|-> wires.main_controller_wiring.branch == 1'b0|->wires.main_controller_wiring.memory_to_register==1'b0|->wires.main_controller_wiring.memory_read==1'b0;
   endproperty

LW: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0000 |-> wires.alu_controller_wiring.func_3_bits== 3'b010 |-> wires.alu_controller_wiring.alu_operation == 4'b0000 |-> LWp) else $display("LW NOT CORRECT");

ADDI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.alu_controller_wiring.alu_operation == 4'b0000|->IFORMAT) else $display("ADDI NOT CORRECT");
SLTI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b010 |-> wires.alu_controller_wiring.alu_operation == 4'b1010|->IFORMAT) else $display("SLTI NOT CORRECT");
SLTIU: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b011 |-> wires.alu_controller_wiring.alu_operation == 4'b1001|->IFORMAT) else $display("SLTIU NOT CORRECT");
XORI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b100 |-> wires.alu_controller_wiring.alu_operation == 4'b0100|->IFORMAT) else $display("XORI NOT CORRECT");
ORI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b110 |-> wires.alu_controller_wiring.alu_operation ==  4'b0011|->IFORMAT) else $display("ORI NOT CORRECT");
ANDI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b111 |-> wires.alu_controller_wiring.alu_operation ==  4'b0010|->IFORMAT) else $display("ANDI NOT CORRECT");
SLLI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b001 |-> wires.alu_controller_wiring.alu_operation ==  4'b1101|->IFORMAT) else $display("SLLI NOT CORRECT");
SRLI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b101 |-> wires.alu_controller_wiring.func_7_bits[5]== 1'b1 |-> wires.alu_controller_wiring.alu_operation ==  4'b1110|->IFORMAT) else $display("SRLI NOT CORRECT");
SRAI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0010|-> wires.alu_controller_wiring.func_3_bits== 3'b101 |-> wires.alu_controller_wiring.func_7_bits[5]== 1'b0 |-> wires.alu_controller_wiring.alu_operation ==  4'b1111|->IFORMAT) else $display("SRAI NOT CORRECT");

AUIPC: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0011 |-> wires.alu_controller_wiring.alu_operation == 4'b0000) else $display("AUIPC NOT CORRECT");

SW: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0100|-> wires.alu_controller_wiring.func_3_bits== 3'b010 |-> wires.alu_controller_wiring.alu_operation == 4'b0000|->SWp) else $display("SW NOT CORRECT");

ADD: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.alu_controller_wiring.alu_operation == 4'b0000|->RFORMAT) else $display("ADD NOT CORRECT");
SLT: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b010 |-> wires.alu_controller_wiring.alu_operation == 4'b1010|->RFORMAT) else $display("SLT NOT CORRECT");
SLTU: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b011 |-> wires.alu_controller_wiring.alu_operation == 4'b1001|->RFORMAT) else $display("SLTU NOT CORRECT");
XOR: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b100 |-> wires.alu_controller_wiring.alu_operation == 4'b0100|->RFORMAT) else $display("XOR NOT CORRECT");
OR: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b110 |-> wires.alu_controller_wiring.alu_operation ==  4'b0011|->RFORMAT) else $display("OR NOT CORRECT");
AND: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b111 |-> wires.alu_controller_wiring.alu_operation ==  4'b0010|->RFORMAT) else $display("AND NOT CORRECT");
SUB: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b1 |-> wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.alu_controller_wiring.alu_operation ==  4'b0001|->RFORMAT) else $display("SUB NOT CORRECT");
SLL: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b001 |-> wires.alu_controller_wiring.alu_operation ==  4'b1101|->RFORMAT) else $display("SLL NOT CORRECT");
SRL: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b0 |-> wires.alu_controller_wiring.func_3_bits== 3'b101 |-> wires.alu_controller_wiring.alu_operation ==  4'b1110|->RFORMAT) else $display("SRL NOT CORRECT");
SRA: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0110|-> wires.alu_controller_wiring.func_7_bits[5] == 1'b1 |-> wires.alu_controller_wiring.func_3_bits== 3'b101 |-> wires.alu_controller_wiring.alu_operation ==  4'b1111|->RFORMAT) else $display("SRA NOT CORRECT");

LUI: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b0111|-> wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.alu_controller_wiring.alu_operation == 4'b0000 |->LUIp) else $display("LUI NOT CORRECT");

BEQ: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1100|-> wires.alu_controller_wiring.func_3_bits== 3'b000 |-> wires.alu_controller_wiring.alu_operation ==  4'b0001|->BEQp) else $display("BEQ NOT CORRECT");
BNE: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1100|-> wires.alu_controller_wiring.func_3_bits== 3'b001 |-> wires.alu_controller_wiring.alu_operation == 4'b0100|->BNEp) else $display("BNE NOT CORRECT");
BGEU: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1100|-> wires.alu_controller_wiring.func_3_bits== 3'b111 |-> wires.alu_controller_wiring.alu_operation ==  4'b0111|->BNEp) else $display("BGEU NOT CORRECT");
BGE: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1100|-> wires.alu_controller_wiring.func_3_bits== 3'b101 |-> wires.alu_controller_wiring.alu_operation ==  4'b1000|->BNEp) else $display("BGE NOT CORRECT");
BLTU: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1100|-> wires.alu_controller_wiring.func_3_bits== 3'b110 |-> wires.alu_controller_wiring.alu_operation ==  4'b1001|->BNEp) else $display("BLTU NOT CORRECT");
BLT: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1100|-> wires.alu_controller_wiring.func_3_bits== 3'b100 |-> wires.alu_controller_wiring.alu_operation ==  4'b1010|->BNEp) else $display("BLT NOT CORRECT");

JAL: assert property(@(posedge wires.clk) wires.main_controller_wiring.alu_option==4'b1101|-> wires.alu_controller_wiring.alu_operation ==  4'b0000|->BNEp) else $display("JAR OR JALR NOT CORRECT");
    
endmodule