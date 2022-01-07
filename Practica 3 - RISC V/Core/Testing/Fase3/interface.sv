interface system_iff;

/*
    // SEÑALES CORE -------------------------
        // ENTRADA
        logic [31:0] idata;
        logic [31:0] ddata_r;
        // SALIDA
        logic [31:0] iaddr;
        logic [31:0] ddata_w;
        logic d_rw;
    //--------------------------------------
    */

    // SEÑALES DUV -------------------------
        // SALIDA
        logic [15:0] DOUT;
        // ENTRADA
        logic [15:0] DIN;
    //--------------------------------------


    // SEÑALES GENERALES -------------------
    logic CLK;
    logic RESET_N; // Activo a nivel bajo
    //--------------------------------------

    modport modport_DUV (
        input DOUT, CLK, RESET_N,
        output DIN
    );


endinterface