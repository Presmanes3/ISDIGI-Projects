interface system_iff;

    /*
        @brief interface system_iff, will carry all the signals.

        @param MAIN PARAMS: DIN, DOUT

        @info señales generales
        @input iaddr
        @output idata

        @info señales de acceso a IMEM
        @input iaddr
        @output idata

        @info señales de acceso al memory controller
        @input daddr
        @input ddata_w
        @input ddata_r

        @brief it also have all the other signals
    */
    parameter n = 16;

    logic [15: 0] DIN;
    logic [15: 0] DOUT;

    logic [n-1:0] iaddr;
    logic [31:0] idata;

    logic [n-1:0] daddr;
    logic [31:0] ddata_w;
    logic [31:0] ddata_r;
    logic d_rw;

    logic [31:0] mem0_dw;
    logic [31:0] mem0_dr;
    logic mem0_ena;
    logic mem0_rw;

    logic [15:0] mem1_dout;
    logic [15:0] mem1_din;
    logic mem1_ena;


    logic CLK;
    logic RESET_N;

    logic comparing;

    modport IMEM (
    input iaddr,
    output idata
    );

    modport DMEM (
    input mem0_dw, mem0_ena, mem0_rw,
    output mem0_dr
    );

    modport memrory_controller (
    input daddr, ddata_w, d_rw, mem1_din, mem0_dr,
    output ddata_r, mem0_ena, mem0_rw, mem1_ena, mem1_dout
    );

    modport GPIO (
    input DIN, mem1_dout, mem1_ena,
    output DOUT, mem1_din
    );

    modport CORE (
    input idata, ddata_r,
    output iaddr, daddr, ddata_w, d_rw
    );


endinterface