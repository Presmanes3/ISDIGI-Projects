`include "./Instruction_core_validator.sv"

module instruction_validation_testbench (
    
);
    `timescale 1ns/100ps

    localparam T=20;

    reg clk;
    reg reset;
    //-------------------------------------------------------------------------------

    // Definimos el reloj -----------------------------------------------------------
    always begin
        #(T/2)
        clk = ~clk;
    end

    Instruction_core_validator #("ADD/add.mem")     add_validator(.*);
    Instruction_core_validator #("ADDI/addi.mem")   addi_validator(.*);
    Instruction_core_validator #("AND/and.mem")     add_validator(.*);
    Instruction_core_validator #("ANDI/andi.mem")   add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);
    Instruction_core_validator #("ADD/add.mem") add_validator(.*);



    initial begin
        clk     = 1'b0;
        reset   = 1'b1;
    end


endmodule