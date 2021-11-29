`include "memory.sv"
`include "register_bank.sv"
`include "Controllers/main_controller.sv"
`include "Controllers/alu_controller.sv"
`include "pc.sv"
`include "ADDER.sv"
`include "immgen.sv"
`include "mux_2_input.sv"
`include "mux_3_input.sv"

/**
    @brief Top level entity for the RISC-V processor
*/
module core ();
    parameter size =32;
    wire [size-1:0] instruction_;
    wire [size-1:0] inmux_out_1_;
    wire [size-1:0] mux_out_2_;
    wire [size-1:0] mux_out_pc_;
    wire [size-1:0] operation_result_;
    wire [size-1:0] pc_out_;
    wire [size-1:0] mem_output_data_;
    wire [size-1:0] read_data_1_;
    wire [size-1:0] read_data_2_;
    wire [size-1:0] imm_gen_;
    wire Zero;

    wire [3:0] operation;


    ADDER ADDER_SUM (               //Adder cuya out es la entrada 1 del multiplexor conectado a PC
                    .input1(imm_gen_),
                    .input2(pc_out_),
                    .out(suma_adder_sum)
    );

    ADDER ADDER_MUX (             //Adder cuya ouput es la entrada 0 del multiplexor conectado a PC
                    .input1(pc_out_),
                    .input2(4),
                    .out(suma_adder_mux)
    );

    ALU ALU (                       //ALU, sin más 
                    .input1(inmux_out_1_),
                    .input2(mux_out_2_),
                    .operation(alu_operation_),
                    .operation_result(operation_result_),
                    .Zero(Zero)
    );

    data_memory data_memory (         //Memoria de datos
                    .clk(clk),
                    .write_enable(memory_write),
                    .read_enable(memory_read),
                    .address(operation_result_),
                    .input_data(read_data_2_),
                    .output_data(mem_output_data_)
    );

    mux_3_input mux_alu1 (      //multiplexor con el que definimos la primera entrada de la ALU
                    .input0(pc),
                    .input1(32'd0),
                    .input2(read_data_1_),
                    .control(AuipcLui),
                    .out(inmux_out_1_)
    );

    mux_2_input mux_alu2(           //multiplexor con el que definimos la segunda entrada de la ALU
                    .input1(read_data_2_),
                    .input2(imm_gen_),
                    .control(alu_source),
                    .out(mux_out_2_)
    );

    mux_2_input mux_mem (          //multiplexor a la salida de la memoria de datos
                    .input1(mem_output_data_),
                    .input2(operation_result_),
                    .control(memory_to_register),
                    .out(mux_out_3)
    );

    mux_2_input mux_pc (             //multiplexor cuya salida está conectada a PC
                    .input1(suma_adder_mux),
                    .input2(suma_adder_sum),
                    .control(and_out),
                    .out(mux_out_pc_)
    );

    register_bank register_bank (
                    .clk(clk),
                    .read_register_1_addr(instruction_[19:15]),
                    .read_register_2_addr(instruction_[24:20]),
                    .write_register_addr(instruction_[11:7]),
                    .write_data(mux_out_3),
                    .write_enable(register_write),
                    .read_data_1(read_data_1_),
                    .read_data_2(read_data_2_)
    );

    imm_gen imm_gen (
                    .inst(instruction_[31:0]),
                    .imm_gen(imm_gen_)
    );

    instruction_memory instruction_memory (
                    .read_address(pc_out_),
                    .instruction_(instruction_)
    );
                
    PC PC(
                    .in(mux_out_pc_),
                    .out(pc_out_)
    );

    // Instanciate the control module
    main_controller controller(
                    .opcode(instruction_[6:0]),
                    .branch(branch),
                    .memory_read(memory_read),
                    .memory_register(memory_register),
                    .alu_option(alu_option),
                    .memory_write(memory_write),
                    .alu_source(alu_source),
                    .register_write(register_write),
                    .AuipcLui(AuipcLui)
    );

    alu_controller alu_control(
                    .func_7_bits(instruction_[31:24]),
                    .func_3_bits(instruction_[14:12]),
                    .alu_option(alu_option),
                    .alu_operation(alu_operation_)
    );

endmodule
