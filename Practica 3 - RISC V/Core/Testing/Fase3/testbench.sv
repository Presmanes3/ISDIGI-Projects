`include "basic_task.sv"
`include "interface.sv"



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
    duv_conector duv_conector_module(
        .modport_DUV(sys_iff)
    );
    //--------------------------------------------------------------------------------

    basic_task basic_task_instance();

    

    initial begin
        basic_task_instance.inicializar();
        basic_task_instance.reset();
        
        // Inicio la comprobación
        

        $stop();
        
    end

endmodule