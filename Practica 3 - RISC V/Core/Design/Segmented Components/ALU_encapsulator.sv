//`include "../Basic Components/ALU.sv"
//`include "../Basic Components/mux_3_input.sv"

module alu_encapsulator #(
    parameter data_bits = 32
) (
    input [data_bits - 1 : 0] register_data_1_in,
    input [data_bits - 1 : 0] register_data_2_in,

    input [1:0] forward_controller_1,
    input [1:0] forward_controller_2,

    input [data_bits - 1 : 0] prev_result_from_mux,
    input [data_bits - 1 : 0] prev_result_from_reg,

    input [3:0] alu_operation,

    output [data_bits - 1 : 0] alu_result,
    output alu_zero

);

    wire [data_bits - 1 : 0] alu_input_1;
    wire [data_bits - 1 : 0] alu_input_2;

    mux_3_input mux_alu_input_1(
        .input0(register_data_1_in),  // Entrada a la salida del registro ID/EX salida read_data_1_out
        .input1(prev_result_from_reg),  // Entrada a salida del registro EX/MEM salida alu_operation_out
        .input2(prev_result_from_mux),  // Entrada a salida del multiplexor de 2 entradas del registro MEM/WB 
        .control(forward_controller_1), // Entrada a la salida forward 1 del forwarding unit    
        .out(alu_input_1)      // Salida a entrada 1 de la ALu
    );

    mux_3_input mux_alu_input_2(
        .input0(register_data_2_in),  // Entrada a la salida del registro ID/EX salida read_data_2_out
        .input1(prev_result_from_reg),  // Entrada a salida del registro EX/MEM salida alu_operation_out
        .input2(prev_result_from_mux),  // Entrada a salida del multiplexor de 2 entradas del registro MEM/WB 
        .control(forward_controller_2), // Entrada a la salida forward 2 del forwarding unit    
        .out(alu_input_2)      // Salida a entrada 2 de la ALu
    );

    ALU ALU (                      
        .input1             (alu_input_1),      // Entrada a salida del multiplexor de 3 entradas
        .input2             (alu_input_2),      // Entrada a salida del multiplexor de 2 entradas
        .operation          (alu_operation),    // Señal que indica la operacion a realizar
        .operation_result   (alu_result),       // Resultado de la operacion
        .Zero               (alu_zero)          // Bit que indica si el resultado de la operacion es 0
    );
    
endmodule