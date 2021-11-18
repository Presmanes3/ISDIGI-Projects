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
    // SEÑALES ALU -------------------------
        logic [31:0] A_alu, B_alu;
        logic [4:0] control_alu;
        logic [31:0] zero_alu;
        logic result_alu;
    //--------------------------------------

    // SEÑALES GENERALES -------------------
    logic CLK;
    logic ck;
    logic RESET_N;
    //--------------------------------------


    modport modport_alu (
    input A_alu, B_alu, control_alu,
    output zero_alu, result_alu
    );


endinterface