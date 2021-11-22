`include "interface.sv" 
`include "basic_task.sv"

module testbench();
    `timescale 1ns/100ps

    localparam T=20;

    // Definimos el reloj -----------------------------------------------------------
    always begin
        #(T/2)
        sys_iff.CLK = ~sys_iff.CLK;
    end
    //-------------------------------------------------------------------------------

    // Instanciate the common system interface for signals ---------------------------
    system_iff sys_iff();
    //--------------------------------------------------------------------------------

    // Instanciamos ALU conector -----------------------------------------------------
    alu_conector alu_conector_module(
        .modport_alu(sys_iff)
    );
    //--------------------------------------------------------------------------------

    initial begin
        //Voy a probar la ALU
        test_alu(sys_iff.A_alu, sys_iff.B_alu, sys_iff.control_alu, sys_iff.ck, sys_iff.zero_alu, sys_iff.result_alu);
    end

endmodule