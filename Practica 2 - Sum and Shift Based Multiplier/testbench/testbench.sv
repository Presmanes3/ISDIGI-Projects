`include "scoreboard.sv"
`include "interface.sv"
`include "DUV/multipli_parallel.sv"

module testbench(
    
);

`timescale 1ns/100ps

localparam T = 20;

// Instanciate the common system interface for signals
system_iff sys_iff();

parameter size = 8;

defparam sys_iff.A_bits = size;
defparam sys_iff.B_bits = size;

// Instanciate scoreboard
scoreboard #(size) scoreboard_;

// Instanciate multipli control and link system interface
multipli_control multi_control_module(
);

// Instanciate the multipli parallel object
multipli_parallel multipli_parallel_module(
                .CLOCK(sys_iff.CLK), 
                .RESET(sys_iff.RESET_N), 
                .END_MULT(sys_iff.fin_mult), 
                .A(sys_iff.A), 
                .B(sys_iff.B), 
                .S(sys_iff.S_real), 
                .START(sys_iff.start)
                );

initial begin
    // RUN VVERIFICATION TESTS
    multi_control_module.bts.inicializar();
    multi_control_module.bts.reset();

    @(negedge sys_iff.CLK)

    multi_control_module.get_random_values();

    @(negedge sys_iff.CLK)
    
    // TODO covertgroup sample


    scoreboard_.multiply();

    sys_iff.start = 1'b1;

    @(posedge sys_iff.CLK)

    @(sys_iff.fin_mult == 1'b1)

    scoreboard_.compare_outputs();

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