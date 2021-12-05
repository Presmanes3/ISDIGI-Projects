`include "../Design/ALU.sv"

// ALU connector ------------------------------------------
module alu_conector(system_iff.modport_alu modport_alu);
    asignar_alu alu_conexion(
        .A_alu(modport_alu.A_alu),
        .B_alu(modport_alu.B_alu),
        .control_alu(modport_alu.control_alu),
        .zero_alu(modport_alu.zero_alu),
        .result_alu(modport_alu.result_alu)
    );
endmodule

module asignar_alu(
    A_alu,
    B_alu,
    control_alu,
    zero_alu,
    result_alu
);

input wire [31:0] A_alu, B_alu;
input wire [3:0] control_alu;
output wire [31:0] result_alu;
output wire zero_alu;

ALU ALU_model(
    .input1(A_alu),
    .input2(B_alu),
    .operation(control_alu),
    .operation_result(result_alu),
    .Zero(zero_alu)
);
endmodule
// End ALU connector ---------------------------------------