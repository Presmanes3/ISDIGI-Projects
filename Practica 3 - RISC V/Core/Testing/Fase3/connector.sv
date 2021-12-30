/* A FALTA DE AÑADIR EL REAL

module duv_conector(system_iff.modport_DUV modport_DUV);
    asignar_duv div_conexion(
        .DOUT(modport_DUV.DOUT),
        .DIN(modport_DUV.DIN),
        .CLK(modport_DUV.CLK),
        .RESET_N(modport_DUV.RESET_N)
    );
endmodule

module asignar_duv(
    DOUT,
    DIN,
    CLK,
    RESET_N
);

input wire [15:0] DIN;
input wire CLK;
input wire RESET_N;
output wire [15:0] DOUT;

DUV duv_model(                  ADAPTAR
    .input1(DIN),
    .input2(CLK),
    .input3(RESET_N),
    .output(DOUT),
);
endmodule
*/