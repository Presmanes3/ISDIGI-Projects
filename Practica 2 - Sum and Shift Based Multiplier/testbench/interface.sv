interface system_iff;

    reg A_bits;
    reg B_bits;

    logic [A_bits-1 : 0] A;
    logic [B_bits-1 : 0] B;

    logic start;

    logic S;

    logic rst;

    logic S_ideal;
    logis S_real;
    
endinterface