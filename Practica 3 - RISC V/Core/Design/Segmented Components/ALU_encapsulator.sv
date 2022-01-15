//`include "../Basic Components/ALU.sv"
//`include "../Basic Components/mux_4_input.sv"

interface alu_encapsulator_interface#(
    parameter data_bits = 32
);
    logic [data_bits - 1 : 0] register_data_1_in;
    logic [data_bits - 1 : 0] register_data_2_in;
    logic [data_bits - 1 : 0] immediate_gen;

    logic [1:0] forward_controller_1;
    logic [1:0] forward_controller_2;

    logic [data_bits - 1 : 0] prev_result_from_mux;
    logic [data_bits - 1 : 0] prev_result_from_reg;

    logic [3:0] alu_operation;

    logic [data_bits - 1 : 0] alu_result;
    logic alu_zero;
endinterface //interfacename



module alu_encapsulator #(
    parameter data_bits = 32
) (
    alu_encapsulator_interface alu_encapsulator_wiring

);

    mux_4_input_interface   input_1_wiring();
    mux_4_input_interface   input_2_wiring();
    ALU_interface           alu_wiring();

    // Cable assigment for input 1
    assign input_1_wiring.input0    = alu_encapsulator_wiring.register_data_1_in;
    assign input_1_wiring.input1    = alu_encapsulator_wiring.prev_result_from_mux;
    assign input_1_wiring.input2    = alu_encapsulator_wiring.prev_result_from_reg;
    assign input_1_wiring.input3    = 32'h0;
    assign input_1_wiring.control   = alu_encapsulator_wiring.forward_controller_1;

    assign alu_wiring.input1        = input_1_wiring.out;

    // Cable assigment for input 2
    assign input_2_wiring.input0    = alu_encapsulator_wiring.register_data_2_in;
    assign input_2_wiring.input1    = alu_encapsulator_wiring.prev_result_from_mux;
    assign input_2_wiring.input2    = alu_encapsulator_wiring.prev_result_from_reg;
    assign input_2_wiring.input3    = alu_encapsulator_wiring.immediate_gen;
    assign input_2_wiring.control   = alu_encapsulator_wiring.forward_controller_2;

    assign alu_wiring.input2        = input_2_wiring.out;

    // Cable assigmend for ALU
    assign alu_encapsulator_wiring.alu_zero    = alu_wiring.zero;
    assign alu_encapsulator_wiring.alu_result  = alu_wiring.result;

    assign alu_wiring.operation = alu_encapsulator_wiring.alu_operation;


    mux_4_input mux_alu_input_1(
        .mux_4_input_wiring (input_1_wiring)
    );

    mux_4_input mux_alu_input_2(
        .mux_4_input_wiring (input_2_wiring)
    );

    ALU ALU (                      
        .alu_wiring         (alu_wiring)
    );
    
endmodule