`include "basic_task.sv"
`include "interface.sv"
`include "check.sv"



module testbench();
    `timescale 1ns/100ps

    localparam T=20;

    // Definimos el reloj -----------------------------------------------------------
    always begin
        #(T/2)
        sys_iff.CLK = ~sys_iff.CLK;
    end
    //--------------------------------------------------------------------------------

    // Instanciate the common system interface for signals ---------------------------
    system_iff sys_iff();
    //--------------------------------------------------------------------------------

    // Instanciamos ALU conector -----------------------------------------------------
    /* A FALTA DE AÑADIR EL REAL
    duv_conector duv_conector_module(
        .modport_DUV(sys_iff)
    );*/
    //--------------------------------------------------------------------------------

    basic_task basic_task_instance();

    // Instanciación clase de test ---------------------------------------------------
    core_test core_test_inst;
    //--------------------------------------------------------------------------------
    

    initial begin
        // Inicializo las class -----
        core_test_inst = new;
        //--------------------------

        basic_task_instance.inicializar();
        basic_task_instance.reset();
        
        // Inicio de la comprobación
        @(sys_iff.ck)
        
        core_test_inst.fibo_test();

        @(sys_iff.ck)

        core_test_inst.bubble_test();
        

        $stop();
        
    end

endmodule