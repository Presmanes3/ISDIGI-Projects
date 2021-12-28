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
        logic [3:0] control_alu;
        logic zero_alu;
        logic [31:0] result_alu;
    //--------------------------------------

    // SEÑALES GENERALES -------------------
    logic CLK;
    logic RESET_N;
    //--------------------------------------

    // Definimos clocking block -----------------------------------------------------
    clocking ck @(posedge sys_iff.CLK); //usar ck como clock
        default input #1ns output #1ns;
    endclocking:ck
    //-------------------------------------------------------------------------------

    modport modport_alu (
    input A_alu, B_alu, control_alu,
    output zero_alu, result_alu
    );


endinterface