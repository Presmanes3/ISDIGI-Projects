interface system_iff;

    parameter A_bits = 0;
    parameter B_bits = 0;

    logic [A_bits - 1 : 0] A;
    logic [B_bits - 1 : 0] B;

    logic start;

    logic S;
    logic fin_mult;

    logic rst;

    logic S_ideal;
    logic S_real;

    logic CLK;
    logic RESET_N;
    
endinterface