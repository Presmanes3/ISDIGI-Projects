`include "./Basic Components/memory.sv"
`include "./Basic Components/register_bank.sv"
`include "./Controllers/main_controller.sv"
`include "./Controllers/alu_controller.sv"
`include "./Golden Components/pc_golden.sv"
`include "./Basic Components/ADDER.sv"
`include "./Basic Components/immgen.sv"
`include "./Basic Components/mux_2_input.sv"
`include "./Basic Components/mux_3_input.sv"
`include "./Basic Components/jump_controller.sv"
`include "./golden_interface.sv"


module golden_model_core 
#(
    parameter data_bits = 32,
    parameter memory_size = 1024,
    parameter memory_address_bits = $clog2(memory_size),
    parameter program_file  = ""
)
(
    golden_interface wires
); 

    // Configure Adders and PC
    
    ADDER ADDER_SUM (                  
        .adder_wiring               (wires.adder_sum_wiring)    
    );

    ADDER ADDER_PC (                 
        .adder_wiring               (wires.adder_pc_wiring)  
    );

    mux_2_input mux_pc (  
        .mux_2_input_wiring      (wires.mux_pc_wiring)   
    );

    PC PC (
        .pc_wiring                  (wires.pc_wiring)
    );

    jump_controller jump_controller(
        .jump_controller_wiring      (wires.jump_controller_wiring)
    );

    ALU ALU (                      
        .alu_wiring                 (wires.alu_wiring)
    );

    memory data_memory (         
        .memory_wiring              (wires.data_memory_wiring)
    );
    defparam data_memory.sintetizable = 1'b0;

    memory #(.input_file(program_file), .charge_file(1'b1)) instruction_memory  (
        .memory_wiring              (wires.instruction_memory_wiring)
    );
    defparam instruction_memory.sintetizable = 1'b0;

    mux_3_input mux_alu1 (
        .mux_3_input_wiring         (wires.mux_alu1_wiring)
    );

    mux_2_input mux_alu2(                   
        .mux_2_input_wiring         (wires.mux_alu2_wiring)
    );
    
    mux_2_input mux_mem (                        
        .mux_2_input_wiring         (wires.mux_mem_wiring)
    );

    register_bank register_bank (
        .register_bank_wiring      (wires.register_bank_wiring)
    );
    defparam register_bank.sintetizable = 1'b0;

    imm_gen imm_gen (
        .imm_gen_wiring             (wires.imm_gen_wiring)
    );
                
    // Instanciate the control module
    main_controller controller(
    .main_controller_wiring         (wires.main_controller_wiring)
    );
    
    alu_controller alu_control(
        .alu_controller_wiring       (wires.alu_controller_wiring)
    );


// Check correctly working of the ADD instruction

//   property SWp;
//    @(posedge clk)
//    main_controller_alu_option==4'b0100 && alu_controller_func_3_bits== 3'b010 |-> main_controller_memory_write==1'b1|-> main_controller_register_write==1'b0|-> main_controller_alu_source==1'b1|-> main_controller_branch==1'b0|-> main_controller_memory_to_register==1'b0 |-> main_controller_memory_read==1'b0;
//    endproperty

//    property BEQp;
//    @(posedge clk)
//    main_controller_alu_option==4'b1100 && alu_controller_func_3_bits== 3'b000 |-> main_controller_memory_write == 1'b0|-> main_controller_register_write == 1'b0|-> main_controller_alu_source == 1'b0|-> main_controller_branch == 1'b1 |->main_controller_memory_to_register==1'b0 |->main_controller_memory_read==1'b0;
//    endproperty
   
//    property RFORMAT;
//     @(posedge clk)
//    main_controller_alu_option==4'b0110 |-> main_controller_memory_write == 1'b0|-> main_controller_register_write == 1'b1|-> main_controller_alu_source == 1'b1|-> main_controller_branch == 1'b0|-> main_controller_memory_to_register==1'b0|-> main_controller_memory_read==1'b0;
//    endproperty

//    property IFORMAT;
//    @(posedge clk)
//     main_controller_alu_option==4'b0010 |-> main_controller_memory_write == 1'b0|-> main_controller_register_write == 1'b1|-> main_controller_alu_source == 1'b1|-> main_controller_branch == 1'b0|-> main_controller_memory_to_register==1'b0|->main_controller_memory_read==1'b0;
//    endproperty

//    property LWp;
//     @(posedge clk)
//      main_controller_alu_option==4'b0000 && alu_controller_func_3_bits==3'b010 |-> main_controller_memory_write == 1'b0|-> main_controller_register_write == 1'b1|-> main_controller_alu_source == 1'b1|-> main_controller_branch == 1'b0|-> main_controller_memory_to_register==1'b1|->main_controller_memory_read==1'b1;
//    endproperty

//     property BNEp;
//    @(posedge clk)
//    main_controller_alu_option==4'b1100 && alu_controller_func_3_bits== 3'b001 |-> main_controller_memory_write == 1'b0|-> main_controller_register_write == 1'b0|-> main_controller_alu_source == 1'b0|-> main_controller_branch == 1'b1 |->main_controller_memory_to_register==1'b0 |->main_controller_memory_read==1'b0;
//    endproperty

//    property LUIp;
//    @(posedge clk) 
//     main_controller_alu_option==4'b0111 && alu_controller_func_3_bits== 3'b000 |-> main_controller_memory_write == 1'b0|-> main_controller_register_write == 1'b1|-> main_controller_alu_source == 1'b0|-> main_controller_branch == 1'b0|->main_controller_memory_to_register==1'b0|->main_controller_memory_read==1'b0;
//    endproperty

// LW: assert property(@(posedge clk) main_controller_alu_option==4'b0000 |-> alu_controller_func_3_bits== 3'b010 |-> alu_controller_alu_operation == 4'b0000 |-> LWp) else $display("LW NOT CORRECT");

// ADDI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b000 |-> alu_controller_alu_operation == 4'b0000|->IFORMAT) else $display("ADDI NOT CORRECT");
// SLTI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b010 |-> alu_controller_alu_operation == 4'b1010|->IFORMAT) else $display("SLTI NOT CORRECT");
// SLTIU: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b011 |-> alu_controller_alu_operation == 4'b1001|->IFORMAT) else $display("SLTIU NOT CORRECT");
// XORI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b100 |-> alu_controller_alu_operation == 4'b0100|->IFORMAT) else $display("XORI NOT CORRECT");
// ORI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b110 |-> alu_controller_alu_operation ==  4'b0011|->IFORMAT) else $display("ORI NOT CORRECT");
// ANDI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b111 |-> alu_controller_alu_operation ==  4'b0010|->IFORMAT) else $display("ANDI NOT CORRECT");
// SLLI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b001 |-> alu_controller_alu_operation ==  4'b1101|->IFORMAT) else $display("SLLI NOT CORRECT");
// SRLI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b101 |-> alu_controller_func_7_bits[5]== 1'b1 |-> alu_controller_alu_operation ==  4'b1110|->IFORMAT) else $display("SRLI NOT CORRECT");
// SRAI: assert property(@(posedge clk) main_controller_alu_option==4'b0010|-> alu_controller_func_3_bits== 3'b101 |-> alu_controller_func_7_bits[5]== 1'b0 |-> alu_controller_alu_operation ==  4'b1111|->IFORMAT) else $display("SRAI NOT CORRECT");

// AUIPC: assert property(@(posedge clk) main_controller_alu_option==4'b0011 |-> alu_controller_alu_operation == 4'b0000) else $display("AUIPC NOT CORRECT");

// SW: assert property(@(posedge clk) main_controller_alu_option==4'b0100|-> alu_controller_func_3_bits== 3'b010 |-> alu_controller_alu_operation == 4'b0000|->SWp) else $display("SW NOT CORRECT");

// ADD: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b000 |-> alu_controller_alu_operation == 4'b0000|->RFORMAT) else $display("ADD NOT CORRECT");
// SLT: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b010 |-> alu_controller_alu_operation == 4'b1010|->RFORMAT) else $display("SLT NOT CORRECT");
// SLTU: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b011 |-> alu_controller_alu_operation == 4'b1001|->RFORMAT) else $display("SLTU NOT CORRECT");
// XOR: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b100 |-> alu_controller_alu_operation == 4'b0100|->RFORMAT) else $display("XOR NOT CORRECT");
// OR: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b110 |-> alu_controller_alu_operation ==  4'b0011|->RFORMAT) else $display("OR NOT CORRECT");
// AND: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b111 |-> alu_controller_alu_operation ==  4'b0010|->RFORMAT) else $display("AND NOT CORRECT");
// SUB: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b1 |-> alu_controller_func_3_bits== 3'b000 |-> alu_controller_alu_operation ==  4'b0001|->RFORMAT) else $display("SUB NOT CORRECT");
// SLL: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b001 |-> alu_controller_alu_operation ==  4'b1101|->RFORMAT) else $display("SLL NOT CORRECT");
// SRL: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b0 |-> alu_controller_func_3_bits== 3'b101 |-> alu_controller_alu_operation ==  4'b1110|->RFORMAT) else $display("SRL NOT CORRECT");
// SRA: assert property(@(posedge clk) main_controller_alu_option==4'b0110|-> alu_controller_func_7_bits[5] == 1'b1 |-> alu_controller_func_3_bits== 3'b101 |-> alu_controller_alu_operation ==  4'b1111|->RFORMAT) else $display("SRA NOT CORRECT");

// LUI: assert property(@(posedge clk) main_controller_alu_option==4'b0111|-> alu_controller_func_3_bits== 3'b000 |-> alu_controller_alu_operation == 4'b0000 |->LUIp) else $display("LUI NOT CORRECT");

// BEQ: assert property(@(posedge clk) main_controller_alu_option==4'b1100|-> alu_controller_func_3_bits== 3'b000 |-> alu_controller_alu_operation ==  4'b0001|->BEQp) else $display("BEQ NOT CORRECT");
// BNE: assert property(@(posedge clk) main_controller_alu_option==4'b1100|-> alu_controller_func_3_bits== 3'b001 |-> alu_controller_alu_operation == 4'b0100|->BNEp) else $display("BNE NOT CORRECT");
// BGEU: assert property(@(posedge clk) main_controller_alu_option==4'b1100|-> alu_controller_func_3_bits== 3'b111 |-> alu_controller_alu_operation ==  4'b0111|->BNEp) else $display("BGEU NOT CORRECT");
// BGE: assert property(@(posedge clk) main_controller_alu_option==4'b1100|-> alu_controller_func_3_bits== 3'b101 |-> alu_controller_alu_operation ==  4'b1000|->BNEp) else $display("BGE NOT CORRECT");
// BLTU: assert property(@(posedge clk) main_controller_alu_option==4'b1100|-> alu_controller_func_3_bits== 3'b110 |-> alu_controller_alu_operation ==  4'b1001|->BNEp) else $display("BLTU NOT CORRECT");
// BLT: assert property(@(posedge clk) main_controller_alu_option==4'b1100|-> alu_controller_func_3_bits== 3'b100 |-> alu_controller_alu_operation ==  4'b1010|->BNEp) else $display("BLT NOT CORRECT");

// JAL: assert property(@(posedge clk) main_controller_alu_option==4'b1101|-> alu_controller_alu_operation ==  4'b0000|->BNEp) else $display("JAR OR JALR NOT CORRECT");

endmodule
