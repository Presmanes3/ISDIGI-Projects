`include "../Design/core.sv"

module phase_2_testbench;

// Clock generator
reg clk;
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

reg reset;

core #(.program_file("Core/Testing/Programs/Simple/R/ADD.mem")) core(
    .clk(clk),
    .reset(reset)
);

initial begin

    reset_();

    clk = 1;

    #(4*CLK_PERIOD);

    $stop();
end

task reset_();
    reset = 0;

    #(CLK_PERIOD);

    reset = 1;
endtask 

endmodule