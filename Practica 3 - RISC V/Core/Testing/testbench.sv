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

    // Definimos clocking block -----------------------------------------------------
    clocking ck @(posedge sys_iff.CLK); //usar ck como clock
        default input #1ns output #1ns;
    endclocking:ck
    assign sys_iff.ck = ck;
    //-------------------------------------------------------------------------------

    // Instanciate the common system interface for signals ---------------------------
    system_iff sys_iff();
    //--------------------------------------------------------------------------------

    // Instanciamos ALU conector -----------------------------------------------------
    alu_conector alu_conector_module(
        .modport_alu(sys_iff)
    );
    //--------------------------------------------------------------------------------

endmodule