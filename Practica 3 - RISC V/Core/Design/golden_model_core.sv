// `include "./Basic Components/memory.sv"
// `include "./Basic Components/register_bank.sv"
// `include "./Controllers/main_controller.sv"
// `include "./Controllers/alu_controller.sv"
// `include "./Golden Components/pc_golden.sv"
// `include "./Basic Components/ADDER.sv"
// `include "./Basic Components/immgen.sv"
// `include "./Basic Components/mux_2_input.sv"
// `include "./Basic Components/mux_3_input.sv"
// `include "./Basic Components/jump_controller.sv"


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



    // ========== DEFINE ALL WIRES ========== //
    // Wiring for ADDER_SUM
    wire [data_bits - 1 : 0] adder_sum_input_1;
    wire [data_bits - 1 : 0] adder_sum_input_2;
    wire [data_bits - 1 : 0] adder_sum_output;

    // Wiring for ADDER_PC
    wire [data_bits - 1 : 0] adder_pc_input_1;
    wire [data_bits - 1 : 0] adder_pc_input_2;
    wire [data_bits - 1 : 0] adder_pc_output;

    // Wiring for PC
    wire [data_bits - 1 : 0] pc_register_input;
    wire [data_bits - 1 : 0] pc_register_output;
    wire pc_register_clk;
    wire pc_register_reset;

    // Wiring for Instruction Memory (ROM)
    wire instruction_memory_clk;
    wire instruction_memory_write_enable;
    wire instruction_memory_read_enable;
    wire [data_bits - 1 : 0] instruction_memory_input_data;
    wire [data_bits - 1 : 0] instruction_memory_output_data;
    wire [memory_address_bits - 1 : 0] instruction_memory_read_address;

    // Wiring for Data Memory (RAM)
    wire data_memory_clk;
    wire data_memory_write_enable;
    wire data_memory_read_enable;
    wire [data_bits - 1 : 0] data_memory_input_data;
    wire [data_bits - 1 : 0] data_memory_output_data;
    wire [memory_address_bits - 1 : 0] data_memory_read_address;

    // Wiring for Register Bank
    wire register_bank_clk;
    wire [4 : 0] register_bank_read_register_1_address;
    wire [4 : 0] register_bank_read_register_2_address;
    wire [4 : 0] register_bank_write_register_address;
    wire [data_bits - 1 : 0] register_bank_write_data;
    wire register_bank_write_enable;
    wire [data_bits - 1 : 0] register_bank_read_data_1;
    wire [data_bits - 1 : 0] register_bank_read_data_2;

    // Wiring for Immediate number generator
    wire [data_bits - 1 : 0] immediate_generator_input;
    wire [data_bits - 1 : 0] immediate_generator_output;

    // Wiring for MUX_THREE
    wire [data_bits - 1 : 0] mux_three_input_1;
    wire [data_bits - 1 : 0] mux_three_input_2;
    wire [data_bits - 1 : 0] mux_three_input_3;
    wire [data_bits - 1 : 0] mux_three_output;
    wire [1 : 0] mux_three_select;

    // Wiring for ALU
    wire [data_bits - 1 : 0] alu_input_1;
    wire [data_bits - 1 : 0] alu_input_2;
    wire [3 : 0] alu_operation;
    wire [data_bits - 1 : 0] alu_result;
    wire alu_zero;                

    // Wiring for MUX_TWO_ALU
    wire [data_bits - 1 : 0] mux_two_alu_input_1;
    wire [data_bits - 1 : 0] mux_two_alu_input_2;
    wire [data_bits - 1 : 0] mux_two_alu_output;
    wire mux_two_alu_select;

    // Wiring for MUX_TWO_DATA_MEM
    wire [data_bits - 1 : 0] mux_two_data_mem_input_1;
    wire [data_bits - 1 : 0] mux_two_data_mem_input_2;
    wire [data_bits - 1 : 0] mux_two_data_mem_output;
    wire mux_two_data_mem_select;

    // Wiring for MUX_TWO_PC
    wire [data_bits - 1 : 0] mux_two_pc_input_1;
    wire [data_bits - 1 : 0] mux_two_pc_input_2;
    wire [data_bits - 1 : 0] mux_two_pc_output;
    wire mux_two_pc_select;

    // Wiring for JUM_CONTROLLER
    wire jump_controller_branch;
    wire [2:0] jump_controller_func_3_bits;
    wire jump_controller_zero;
    wire [31:0] jump_controller_alu_result;
    wire jump_controller_select;

    // Wiring for Main Controller
    wire [6 : 0] main_controller_opcode;
    wire main_controller_branch;
    wire main_controller_memory_read;
    wire main_controller_memory_to_register;
    wire [3 : 0] main_controller_alu_option;
    wire main_controller_memory_write;
    wire main_controller_alu_source;
    wire main_controller_register_write;
    wire [1 : 0] main_controller_AuipcLui;

    // Wiring for ALU controller
    wire [6 : 0] alu_controller_func_7_bits;
    wire [2 : 0] alu_controller_func_3_bits;
    wire [3 : 0] alu_controller_alu_option;
    wire [3 : 0] alu_controller_alu_operation;

    // ========== ASSIGN CABLES ========== //
    // ADDER SUM connections
    assign adder_sum_input_1 = pc_register_output;
    assign adder_sum_input_2 = immediate_generator_output;

    // ADDER PC connections
    assign adder_pc_input_1 = pc_register_output;
    assign adder_pc_input_2 = 4;

    // MUX TWO PC connections
    assign mux_two_pc_input_1   = adder_pc_output;
    assign mux_two_pc_input_2   = adder_sum_output;
    assign mux_two_pc_select    = jump_controller_select;

    // JUMP CONTROLLER connections
    assign jump_controller_branch       = main_controller_branch;
    assign jump_controller_func_3_bits  = alu_controller_func_3_bits;
    assign jump_controller_alu_result   = alu_result;
    assign jump_controller_zero         = alu_zero;

    // PC connections
    assign pc_register_input    = mux_two_pc_output;
    assign pc_register_clk      = clk;
    assign pc_register_reset    = reset;

    // Instruction Memory connections
    assign instruction_memory_clk           = 1'b0;
    assign instruction_memory_write_enable  = 1'b0;
    assign instruction_memory_read_enable   = 1'b1;
    assign instruction_memory_input_data    = {32{1'b0}};
    assign instruction_memory_read_address  = pc_register_output[memory_address_bits - 1 : 2];
  
    // Main controller connections
    assign main_controller_opcode = instruction_memory_output_data[6 : 0];

    // Register Bank connections
    assign register_bank_clk                        = clk;
    assign register_bank_read_register_1_address    = instruction_memory_output_data[19 : 15];
    assign register_bank_read_register_2_address    = instruction_memory_output_data[24 : 20];
    assign register_bank_write_register_address     = instruction_memory_output_data[11 : 7 ];
    assign register_bank_write_data                 = mux_two_data_mem_output;
    assign register_bank_write_enable               = main_controller_register_write;

    // Immediate generator connections
    assign immediate_generator_input = instruction_memory_output_data;

    // MUX_THREE connections
    assign mux_three_input_1    = pc_register_output;
    assign mux_three_input_2    = 32'd0;
    assign mux_three_input_3    = register_bank_read_data_1;
    //assign mux_three_select     = main_controller_AuipcLui; 
    assign mux_three_select     = 2; 

    // MUX_TWO_ALU connections
    assign mux_two_alu_input_1 = register_bank_read_data_2;
    assign mux_two_alu_input_2 = immediate_generator_output;
    assign mux_two_alu_select  = main_controller_alu_source;

    // MUX_TWO_MEM connections
    assign mux_two_data_mem_input_1 = alu_result;
    assign mux_two_data_mem_input_2 = data_memory_output_data;
    assign mux_two_data_mem_select  = main_controller_memory_to_register;

    // ALU controller connections
    assign alu_controller_alu_option    = main_controller_alu_option;
    assign alu_controller_func_7_bits   = instruction_memory_output_data[31 : 25];
    assign alu_controller_func_3_bits   = instruction_memory_output_data[14 : 12];

    // ALU connections
    assign alu_input_1      = mux_three_output;
    assign alu_input_2      = mux_two_alu_output;
    assign alu_operation    = alu_controller_alu_operation;

    // Data memory connections
    assign data_memory_clk          = clk;
    assign data_memory_read_address = alu_result[data_bits - 1 : 2];
    assign data_memory_input_data   = register_bank_read_data_2;
    assign data_memory_write_enable = main_controller_memory_write;
    assign data_memory_read_enable  = main_controller_memory_read;

    // Configure Adders and PC
    
    ADDER ADDER_SUM (                  
        .adder_wiring               (wires.adder_sum_wiring)    
    );

    
    ADDER ADDER_PC (                 
        .adder_wiring               (wires.adder_pc_wiring)  
    );

    
    mux_2_input mux_pc (  
        .mux_2_input_pc_wiring      (wires.mux_pc_wiring)   
    );

    
    PC PC (
        .pc_wiring                  (wires.pc_wiring)
    );

    
    jump_controller jump_controller(
        .jump_controler_wiring      (wires.jump_controler_wiring)
    );


    ALU ALU (                      
        .alu_wiring                 (wires.alu_wiring);
    );

   
    memory data_memory (         
        .memory_wiring              (wires.data_memory_wiring)
    );
    defparam data_memory.sintetizable = 1'b1;

    
    memory #(.input_file(program_file), .charge_file(1'b1)) instruction_memory  (
        .memory_wiring              (wires.instruction_memory_wiring)
    );
    defparam instruction_memory.sintetizable = 1'b1;

    
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
        .register_banck_wiring      (wires.register_bank_wiring)
    );
    defparam register_bank.sintetizable = 1'b1;

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
