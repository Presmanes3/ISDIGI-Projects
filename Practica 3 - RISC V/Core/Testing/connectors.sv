`include "../Design/ALU.sv"

// ALU connector ------------------------------------------
module alu_conector(system_iff.modport_alu mport_ALU);
    asignar_alu alu_conexion(
        .A_alu(mport_alu.A_alu),
        .B_alu(mport_alu.B_alu),
        .control_alu(mport_alu.control_alu),
        .zero_alu(mport_alu.zero_alu),
        .result_alu(mport_alu.result_alu)
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
input wire [4:0] control_alu;
output wire [31:0] result_alu;
output wire zero_alu;

ALU ALU_model(
    .input1(A_alu),
    .input2(B_alu),
    .ALUop(control_alu),
    .ALUresult(result_alu),
    .Zero(zero_alu)
);
endmodule
