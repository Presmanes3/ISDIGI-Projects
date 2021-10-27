`include "scoreboard.sv"
`include "interface.sv"

module testbench(
    
);

`timescale 1ns/100ps

localparam T = 20;

// Instanciate the common system interface for signals
system_iff sys_iff();

defparam sys_iff.A_bits = 8;
defparam sys_iff.B_bits = 8;

// Instanciate scoreboard
scoreboard scoreboard_;

// Instanciate multipli control and link system interface
multipli_control multi_control_module(
);

initial begin
    scoreboard_ = new();
    multi_control_module.bts.inicializar(); //ejecuto la task inicializar

    @(negedge sys_iff.CLK);

    sys_iff.A = 5;
    sys_iff.B = 2;

    sys_iff.start = 1'b1;

    scoreboard_.multiply();

    @(negedge sys_iff.CLK);

    sys_iff.start = 1'b0;

    multi_control_module.bts.reset();

    @(negedge sys_iff.CLK);

    multi_control_module.get_random_values();

    sys_iff.start = 1'b1;

    scoreboard_.multiply();

    @(negedge sys_iff.CLK);

    sys_iff.start = 1'b0;

    multi_control_module.bts.reset();

    @(negedge sys_iff.CLK);

    sys_iff.A = -15;
    sys_iff.B = -11;

    sys_iff.start = 1'b1;

    scoreboard_.multiply();

    @(negedge sys_iff.CLK);

    sys_iff.start = 1'b0;

    multi_control_module.bts.reset();

    @(negedge sys_iff.CLK);

    $stop();

end

always  begin
    #(T/2)
    sys_iff.CLK = ~sys_iff.CLK;
end

always @(negedge sys_iff.RESET_N) begin
    sys_iff.S_ideal = 0;
end


endmodule