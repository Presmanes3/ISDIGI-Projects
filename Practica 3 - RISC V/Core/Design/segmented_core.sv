`include "./Basic Components/memory.sv"
`include "./Basic Components/register_bank.sv"
`include "./Controllers/main_controller.sv"
`include "./Controllers/alu_controller.sv"
`include "./Segmented Components/pc_segmented.sv"
`include "./Basic Components/ADDER.sv"
`include "./Basic Components/immgen.sv"
`include "./Basic Components/mux_2_input.sv"
`include "./Basic Components/mux_3_input.sv"
`include "./Basic Components/jump_controller.sv"

`include "./Segmented Registers/register_ex_mem.sv"
`include "./Segmented Registers/register_id_ex.sv"
`include "./Segmented Registers/register_if_id.sv"
`include "./Segmented Registers/register_mem_wb.sv"

`include "./Risk Detectors/clear_pipeline.sv"
`include "./Risk Detectors/data_forwarding.sv"
`include "./Risk Detectors/hazard_detection_unit.sv"

`include "./Segmented Components/ALU_encapsulator.sv"

module segmented_core
#(
    parameter data_bits = 32,
    parameter memory_size = 1024,
    parameter memory_address_bits = $clog2(memory_size),
    parameter program_file  = ""
)
(
    input clk,
    input reset
);

    // ========== DEFINE ALL WIRES ========== //
    //Wiring MEM/WB
    wire [data_bits - 1 : 0] reg_mem_wb_alu_result_in;
    wire [data_bits - 1 : 0] reg_mem_wb_alu_result_out;
    wire [data_bits - 1 : 0] reg_mem_wb_data_memory_out_in;
    wire [data_bits - 1 : 0] reg_mem_wb_data_memory_out_out;
    wire [4:0] reg_mem_wb_instruction_11_7_in;
    wire [4:0] reg_mem_wb_instruction_11_7_out;

    //Wiring EX/MEM
    wire reg_ex_mem_clear_pipeline;
    wire [data_bits - 1 : 0] reg_ex_mem_adder_sum_in;
    wire [data_bits - 1 : 0] reg_ex_mem_adder_sum_out;
    wire [data_bits - 1 : 0] reg_ex_mem_alu_result_in;
    wire [data_bits - 1 : 0] reg_ex_mem_alu_result_out;
    wire [data_bits - 1 : 0] reg_ex_mem_alu_read_data_2_in;
    wire [data_bits - 1 : 0] reg_ex_mem_alu_read_data_2_out;
    wire [4:0] reg_ex_mem_instruction_11_7_in;
    wire [4:0] reg_ex_mem_instruction_11_7_out;

    //Wiring ID/EX
    wire reg_id_ex_clear_pipeline;
    wire [data_bits - 1 : 0] reg_id_ex_pc_in;
    wire [data_bits - 1 : 0] reg_id_ex_pc_out;
    wire [data_bits - 1 : 0] reg_id_ex_read_data_1_in;
    wire [data_bits - 1 : 0] reg_id_ex_read_data_1_out;
    wire [data_bits - 1 : 0] reg_id_ex_read_data_2_in;
    wire [data_bits - 1 : 0] reg_id_ex_read_data_2_out;
    wire [data_bits - 1 : 0] reg_id_ex_immediate_gen_in;
    wire [data_bits - 1 : 0] reg_id_ex_immediate_gen_out;
    wire [4:0] reg_id_ex_instruction_11_7_in;
    wire [4:0] reg_id_ex_instruction_11_7_out;
    wire [2:0] reg_id_ex_instruction_14_12_in;
    wire [2:0] reg_id_ex_instruction_14_12_out;
    wire reg_id_ex_instruction_30_in;
    wire reg_id_ex_instruction_30_out;
    wire [5:0] reg_id_ex_instruction_in;
    wire [5:0] reg_id_ex_instruction_out;

    //Wiring IF/ID
    wire reg_if_id_pc_write_id_enable;
    wire [data_bits - 1 : 0] reg_if_id_pc_in;
    wire [data_bits - 1 : 0] reg_if_id_pc_out;
    wire [data_bits - 1 : 0] reg_if_id_instruction_in;
    wire [data_bits - 1 : 0] reg_if_id_instruction_out;
    wire  reg_if_if_pc_write_enable;
    wire  reg_if_id_flush_adder_enable;
    wire  reg_if_id_flush_pc_enable;

    // Wiring Hazard detection unit
    wire hazard_detect_hazard_mux;
    wire hazard_detect_pc_write_id;
    wire hazard_detect_flush;
    wire hazard_detect_flush_pc;
    wire hazard_detect_flush_adder;
    wire hazard_detect_force_jump_wb;
    wire hazard_detect_branch_mux_mem;
    wire hazard_detect_mem_read_ex;
    wire hazard_detect_rd_addr_ex;
    wire hazard_detect_rs1_addr_id;
    wire hazard_detect_rs2_addr_id;
    wire hazard_detect_force_jump_id;
    wire hazard_detect_foce_jump_ex;
    wire hazard_detect_force_jump_mem;

    // Wiring clear pipeline
    wire clear_pipeline_branch_mux_mem;
    wire clear_pipeline_jump_pc_mem;
    wire clear_pipeline_clk;
    wire clear_pipeline_reset;
    wire clear_pipeline_clear_pipeline;

    // Wiring data forwarding
    wire [1:0] data_forwarding_forward1;
    wire [1:0] data_forwarding_forward2;
    wire [4:0] data_forwarding_rs1_addr_ex;
    wire [4:0] data_forwarding_rs2_addr_ex;
    wire data_forwarding_reg_write_mem;
    wire data_forwarding_reg_write_wb;
    wire [4:0] data_forwarding_rd_addr_mem;
    wire [4:0] data_forwarding_rd_addr_wb;


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
    wire pc_register_pc_write_id_enable;

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

    wire [data_bits - 1 : 0] alu_encapsulator_register_data_1_in;
    wire [data_bits - 1 : 0] alu_encapsulator_register_data_2_in;
    wire [1:0] alu_encapsulator_forward_controller_1;
    wire [1:0] alu_encapsulator_forward_controller_2;
    wire [data_bits - 1 : 0] alu_encapsulator_prev_result_from_mux;
    wire [data_bits - 1 : 0] alu_encapsulator_prev_result_from_reg;
    wire [3:0] alu_encapsulator_alu_operation;
    wire [data_bits - 1 : 0] alu_encapsulator_alu_result;
    wire alu_encapsulator_alu_zero;             

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
    wire main_controller_hazard_mux_enable;

    // Wiring for ALU controller
    wire [6 : 0] alu_controller_func_7_bits;
    wire [2 : 0] alu_controller_func_3_bits;
    wire [3 : 0] alu_controller_alu_option;
    wire [3 : 0] alu_controller_alu_operation;
    
    // ========== INTERFACES FOR REGISTERS ========== //
    // Interface for IF/ID

    // Interface for ID/EX
    register_ex_interface reg_id_ex_ex_wiring();
    register_m_interface  reg_id_ex_m_wiring();
    register_wb_interface reg_id_ex_wb_wiring();

    // Interface for EX/MEM
    register_m_interface  reg_ex_mem_m_wiring();
    register_wb_interface reg_ex_mem_wb_wiring();

    // Interface for MEM/WB
    register_wb_interface reg_mem_wb_wb_wiring();

    // ========== ASSIGN CABLES ========== //

    // REGISTER ID/EX WIRING connections
    // SMALL REGISTER EX
   // assign reg_id_ex_ex_wiring.clk = clk;

    // SMALL REGISTER M
    //assign reg_id_ex_m_wiring.clk = clk;

    // SMALL REGISTER WB
    //assign reg_id_ex_wb_wiring.clk = clk;

    // REGISTER EX/MEM WIRING connections
    // SMALL REGISTER M
    //assign reg_ex_mem_m_wiring.clk = clk;

    // SMALL REGISTER WB
    //assign reg_ex_mem_wb_wiring.clk = clk;

    // REGISTER MEM/WB WIRING connections
    // SMALL REGISTER WB
    //assign reg_mem_wb_wb_wiring.clk = clk;

    // ADDER SUM connections
    assign adder_sum_input_1 = reg_id_ex_pc_out;
    assign adder_sum_input_2 = reg_id_ex_immediate_gen_out;//hay que shiftear 1 pero nome deja 

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
    assign register_bank_read_register_1_address    = reg_if_id_instruction_out[19 : 15];
    assign register_bank_read_register_2_address    = reg_if_id_instruction_out[24 : 20];
    assign register_bank_write_register_address     = reg_if_id_instruction_out[11 : 7 ];
    assign register_bank_write_data                 = mux_two_data_mem_output;
    assign register_bank_write_enable               = main_controller_register_write;

    // Immediate generator connections
    assign immediate_generator_input = reg_if_id_instruction_out;

    // MUX_THREE connections
    assign mux_three_input_1    = pc_register_output;
    assign mux_three_input_2    = 32'd0;
    assign mux_three_input_3    = register_bank_read_data_1;
    //assign mux_three_select     = main_controller_AuipcLui; 
    assign mux_three_select     = 2; 

    // MUX_TWO_ALU connections
    assign mux_two_alu_input_1 = reg_id_ex_read_data_2_out;
    assign mux_two_alu_input_2 = reg_id_ex_immediate_gen_out;
    assign mux_two_alu_select  = main_controller_alu_source;

    // MUX_TWO_MEM connections
    assign mux_two_data_mem_input_1 = reg_mem_wb_alu_result_out;
    assign mux_two_data_mem_input_2 = reg_mem_wb_data_memory_out_out;
    assign mux_two_data_mem_select  = main_controller_memory_to_register;

    // ALU controller connections
    assign alu_controller_alu_option    = main_controller_alu_option;
    assign alu_controller_func_7_bits   = instruction_memory_output_data[31 : 25];
    assign alu_controller_func_3_bits   = instruction_memory_output_data[14 : 12];

    // ALU connections
    assign alu_operation    = alu_controller_alu_operation;

    // Data memory connections
    assign data_memory_clk          = clk;
    assign data_memory_read_address = reg_ex_mem_alu_result_out[data_bits - 1 : 2];
    assign data_memory_input_data   = register_bank_read_data_2;
    assign data_memory_write_enable = reg_ex_mem_alu_read_data_2_out;
    assign data_memory_read_enable  = main_controller_memory_read;

    //interface ex assign
    assign ex_wiring.clk = clk;
    assign ex_wiring.alu_op_in = alu_controller_alu_operation;
    assign ex_wiring.alu_src_in = main_controller_alu_source;

    assign ex_wiring.alu_op_out = alu_controller_alu_operation;
    assign ex_wiring.alu_src_out = main_controller_alu_source;


   //interface m assign

    assign m_wiring.clk = clk;

    assign m_wiring.jump_pc_in =clear_pipeline_jump_pc_mem;
    assign m_wiring.instruction_func_in =reg_id_ex_instruction_in;
    assign m_wiring.force_jump_in = hazard_detect_foce_jump_ex;
    assign m_wiring.branch_in = hazard_detect_branch_mux_mem;
    assign m_wiring.mem_write_in = main_controller_memory_write;
    assign m_wiring.mem_read_in = hazard_detect_mem_read_ex;

    assign m_wiring.jump_pc_out = clear_pipeline_jump_pc_mem;
    assign m_wiring.instruction_func_out = reg_id_ex_instruction_out;
    assign m_wiring.force_jump_out = hazard_detect_foce_jump_ex;
    assign m_wiring.branch_out = hazard_detect_branch_mux_mem;
    assign m_wiring.mem_write_out = main_controller_memory_write;
    assign m_wiring.mem_read_out = hazard_detect_mem_read_ex;


    //interace wb assign

    assign wb_wiring.clk = clk;

    assign wb_wiring.reg_write_in = data_forwarding_reg_write_wb;
    assign wb_wiring.jump_rd_in = data_forwarding_rd_addr_wb;
    assign wb_wiring.mem_to_reg_in = main_controller_memory_to_register;

    assign wb_wiring.reg_write_out= data_forwarding_reg_write_wb;
    assign wb_wiring.jump_rd_out = data_forwarding_rd_addr_wb;
    assign wb_wiring.mem_to_reg_out = main_controller_memory_to_register;


    // Configure Adders and PC
    ADDER ADDER_SUM (                   // Adder cuya out es la entrada 1 del multiplexor conectado a PC
        .input1 (adder_sum_input_1),    // Entrada a salida del generador de inmediatos
        .input2 (adder_sum_input_2),    // Entrada a salida del pc
        .out    (adder_sum_output)      // Salida al multiplexor de suma
    );

    ADDER ADDER_PC (                    // Adder cuya ouput es la entrada 0 del multiplexor conectado a PC
        .input1 (adder_pc_input_1),     // Entrada a salida del pc 
        .input2 (adder_pc_input_2),     // Entrada forzada a 4
        .out    (adder_pc_output)       // Salida a
    );

    mux_2_input mux_pc (                // multiplexor cuya salida está conectada a PC
        .input1 (mux_two_pc_input_1),   // Entrada a salida del sumador 1
        .input2 (mux_two_pc_input_2),   // Entrada a salida del sumador 'SUM'
        .control(mux_two_pc_select),    // Control proveniente de la puerta AND
        .out    (mux_two_pc_output)     // Salida a la entrada del pc
    );

    PC PC (
        .in                 (pc_register_input),    // Entrada del pc
        .out                (pc_register_output),    // Salida del pc
        .pc_write_id_enable (pc_register_pc_write_id_enable),
        .clk                (pc_register_clk),
        .reset              (pc_register_reset)
    );

    jump_controller jump_controller_(
        .branch(jump_controller_branch),
        .func_3_bits(jump_controller_func_3_bits),
        .zero(jump_controller_zero),
        .alu_result(jump_controller_alu_result),
        .select(jump_controller_select)
    );

    assign alu_encapsulator_register_data_1_in = 0;     // Entrada al registro ID/EX
    assign alu_encapsulator_register_data_2_in = 0;     // Entrada al registro ID/EX
    assign alu_encapsulator_forward_controller_1 = 0;   //

    alu_encapsulator alu_encapsulator(
        .register_data_1_in     (alu_encapsulator_register_data_1_in),
        .register_data_2_in     (alu_encapsulator_register_data_2_in),
        .forward_controller_1   (alu_encapsulator_forward_controller_1),
        .forward_controller_2   (alu_encapsulator_forward_controller_2),
        .prev_result_from_mux   (alu_encapsulator_prev_result_from_mux),
        .prev_result_from_reg   (alu_encapsulator_prev_result_from_reg),
        .alu_operation          (alu_encapsulator_alu_operation),
        .alu_result             (alu_encapsulator_alu_result),
        .alu_zero               (alu_encapsulator_alu_zero)
    );

    memory data_memory (         
        .clk            (data_memory_clk),          // Clock del sistema
        .write_enable   (data_memory_write_enable),   
        .read_enable    (data_memory_read_enable),
        .address        (data_memory_read_address),
        .input_data     (data_memory_input_data),
        .output_data    (data_memory_output_data)
    );

    memory #(.input_file(program_file), .charge_file(1'b1)) instruction_memory  (
        .clk            (instruction_memory_clk),
        .write_enable   (instruction_memory_write_enable),  // Forzamos el bit de escritura a 0 para evitar su escritura
        .read_enable    (instruction_memory_read_enable),   // Forzamos el bit de lectura a 1 para forzar solo lectura
        .address        (instruction_memory_read_address),  // Direccion de entrada a salida del pc
        .input_data     (instruction_memory_input_data),    // Forzamos datos de entrada a 0
        .output_data    (instruction_memory_output_data)    // La salida es la instruccion del sistema
    );

    mux_2_input mux_mem (                        // multiplexor a la salida de la memoria de datos
        .input1     (mux_two_data_mem_input_1),  // Entrada a la salida de la memoria de datos
        .input2     (mux_two_data_mem_input_2),  // Entrada a la salida del multiplexor
        .control    (mux_two_data_mem_select),   //
        .out        (mux_two_data_mem_output)
    );

    register_bank register_bank (
        .clk                    (register_bank_clk),
        .read_register_1_addr   (register_bank_read_register_1_address),
        .read_register_2_addr   (register_bank_read_register_2_address),
        .write_register_addr    (register_bank_write_register_address),
        .write_data             (register_bank_write_data),
        .write_enable           (register_bank_write_enable),
        .read_data_1            (register_bank_read_data_1),
        .read_data_2            (register_bank_read_data_2)
    );

    imm_gen imm_gen (
        .instruction    (immediate_generator_input),
        .out            (immediate_generator_output)
    );
                
    // Instanciate the control module
    main_controller controller(
        .opcode             (main_controller_opcode),
        .branch             (main_controller_branch),
        .memory_read        (main_controller_memory_read),
        .hazard_mux_enable  (main_controller_hazard_mux_enable),
        .memory_to_register (main_controller_memory_to_register),
        .alu_option         (main_controller_alu_option),
        .memory_write       (main_controller_memory_write),
        .alu_source         (main_controller_alu_source),
        .register_write     (main_controller_register_write),
        .AuipcLui           (main_controller_AuipcLui)
    );

    alu_controller alu_control(
        .func_7_bits    (alu_controller_func_7_bits),
        .func_3_bits    (alu_controller_func_3_bits),
        .alu_option     (alu_controller_alu_option),
        .alu_operation  (alu_controller_alu_operation)
    );

    // ========== ========== REGISTERS ========== ========== //

    register_if_id register_if_id(
        .clk                    (clk),
        .pc_write_id_enable     (reg_if_id_pc_write_id_enable),
        .pc_in                  (reg_if_id_pc_in),
        .pc_out                 (reg_if_id_pc_out),
        .instruction_in         (reg_if_id_instruction_in),
        .instruction_out        (reg_if_id_instruction_out),
        .flush_adder_enable     (reg_if_id_flush_adder_enable),
        .flush_pc_enable        (reg_if_id_flush_pc_enable),
        .pc_write_enable        (reg_if_if_pc_write_enable)
    );

    register_id_ex register_id_ex(
        .clk                    (clk),
        .clear_pipeline         (reg_id_ex_clear_pipeline),
        .ex_wiring              (reg_id_ex_ex_wiring),
        .m_wiring               (reg_id_ex_m_wiring),
        .wb_wiring              (reg_id_ex_wb_wiring),
        .instruction_in         (reg_id_ex_instruction_in),
        .instruction_out        (reg_id_ex_instruction_out),
        .pc_in                  (reg_id_ex_pc_in),
        .pc_out                 (reg_id_ex_pc_out),
        .read_data_1_in         (reg_id_ex_read_data_1_in),
        .read_data_1_out        (reg_id_ex_read_data_1_out),
        .read_data_2_in         (reg_id_ex_read_data_2_in),
        .read_data_2_out        (reg_id_ex_read_data_2_out),
        .immediate_gen_in       (reg_id_ex_immediate_gen_in),
        .immediate_gen_out      (reg_id_ex_immediate_gen_out),
        .instruction_11_7_in    (reg_id_ex_instruction_11_7_in),
        .instruction_11_7_out   (reg_id_ex_instruction_11_7_out),
        .instruction_14_12_in   (reg_id_ex_instruction_14_12_in),
        .instruction_14_12_out  (reg_id_ex_instruction_14_12_out),
        .instruction_30_in      (reg_id_ex_instruction_30_in),
        .instruction_30_out     (reg_id_ex_instruction_30_out)

    );

    register_ex_mem register_ex_mem(
        .clk                    (clk),
        .clear_pipeline         (reg_ex_mem_clear_pipeline),
        .m_wiring               (reg_ex_mem_m_wiring),
        .wb_wiring              (reg_ex_mem_wb_wiring),
        .adder_sum_in           (reg_ex_mem_adder_sum_in),
        .adder_sum_out          (reg_ex_mem_adder_sum_out),
        .alu_result_in          (reg_ex_mem_alu_result_in),
        .alu_result_out         (reg_ex_mem_alu_result_out),
        .alu_read_data_2_in     (reg_ex_mem_alu_read_data_2_in),
        .alu_read_data_2_out    (reg_ex_mem_alu_read_data_2_out),
        .instruction_11_7_in    (reg_ex_mem_instruction_11_7_in),
        .instruction_11_7_out   (reg_ex_mem_instruction_11_7_out)
    );

    register_mem_wb register_mem_wb(
        .clk                    (clk),
        .wb_wiring              (reg_mem_wb_wb_wiring),
        .alu_result_in          (reg_mem_wb_alu_result_in),
        .alu_result_out         (reg_mem_wb_alu_result_out),
        .data_memory_out_in     (reg_mem_wb_data_memory_out_in),
        .data_memory_out_out    (reg_mem_wb_data_memory_out_out),
        .instruction_11_7_in    (reg_mem_wb_instruction_11_7_in),
        .instruction_11_7_out   (reg_mem_wb_instruction_11_7_out)
    );

    // ========== ========== RISK DETECTORS ========== ========== //
    hazard_detection_unit hazard_detection_unit(
        .pc_write_id    (hazard_detect_pc_write_id),
        .hazard_mux     (hazard_detect_hazard_mux),
        .flush          (hazard_detect_flush),
        .flush_pc       (hazard_detect_flush_pc),
        .flush_adder    (hazard_detect_flush_adder),
        .force_jump_wb  (hazard_detect_force_jump_wb),
        .branch_mux_mem (hazard_detect_branch_mux_mem),
        .mem_read_ex    (hazard_detect_mem_read_ex),
        .rd_addr_ex     (hazard_detect_rd_addr_ex),
        .rs1_addr_id    (hazard_detect_rs1_addr_id),
        .rs2_addr_id    (hazard_detect_rs2_addr_id),
        .force_jump_id  (hazard_detect_force_jump_id),
        .force_jump_ex  (hazard_detect_foce_jump_ex),
        .force_jump_mem (hazard_detect_force_jump_mem)
    );

    clear_pipeline clear_pipeline(
        .branch_mux_mem (clear_pipeline_branch_mux_mem),
        .jump_pc_mem    (clear_pipeline_jump_pc_mem),
        .clk            (clear_pipeline_clk),
        .reset          (clear_pipeline_reset),
        .clear_pipeline (clear_pipeline_clear_pipeline)
    );

    data_forwarding data_forwarding(
        .forward1       (data_forwarding_forward1),
        .forward2       (data_forwarding_forward2),
        .rs1_addr_ex    (data_forwarding_rs1_addr_ex),
        .rs2_addr_ex    (data_forwarding_rs2_addr_ex),
        .reg_write_mem  (data_forwarding_reg_write_mem),
        .reg_write_wb   (data_forwarding_reg_write_wb),
        .rd_addr_mem    (data_forwarding_rd_addr_mem),
        .rd_addr_wb     (data_forwarding_rd_addr_wb)
    );
endmodule



