`include "basic_task.sv"
`include "interface.sv"
`include "subcomponents/alu_tb.sv"
//`include "subcomponents/ram_tb.sv"

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

    // Instanciamos el test de la ALU ------------------------------------------------
    test_alu test_alu_instance();
    //--------------------------------------------------------------------------------

    basic_task basic_task_instance();

    

    initial begin
        basic_task_instance.inicializar();
        basic_task_instance.reset();
        
        // Compruebo la ALU
        test_alu_instance.tb_alu();

        $stop();
        
    end

endmodule