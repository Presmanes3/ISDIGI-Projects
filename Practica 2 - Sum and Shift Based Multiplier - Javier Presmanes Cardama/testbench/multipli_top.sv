`include "../Design/multipli.sv"

module multipli_top(system_iff.DUV mport);

    asignar radicador_duv(
        .CLK(mport.CLK),
        .RESET_N(mport.RESET_N),
        .A(mport.A),
        .B(mport.B),
        .S_real(mport.S_real),
        .fin_mult(mport.fin_mult),
        .START(mport.start)
    ); 

endmodule

    module asignar(
        CLK, 
        RESET_N,
        A,
        B,
        S_real,
        fin_mult,
        START
    );


    input wire CLK, RESET_N, START;
    input wire [7:0] A;
    input wire [7:0] B;
    output wire fin_mult;
    output wire [15:0] S_real;

    multipli multipli_model(
                .CLOCK(CLK), 
                .RESET(RESET_N), 
                .END_MULT(fin_mult), 
                .A(A), 
                .B(B), 
                .S(S_real), 
                .START(START)   
    );

endmodule
