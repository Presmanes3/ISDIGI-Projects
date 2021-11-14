interface system_iff;

    parameter A_bits = 0;
    parameter B_bits = 0;

    logic [A_bits - 1 : 0] A;
    logic [B_bits - 1 : 0] B;

    logic start;

    logic fin_mult;

    logic [A_bits*2 - 1 : 0] S_ideal;
    logic [A_bits*2 - 1 : 0] S_real;

    logic CLK;
    logic RESET_N;

    logic comparing;
    
endinterface