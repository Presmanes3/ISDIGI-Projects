`include "../Design/core.sv"
`include "./fibonnaci_test.sv"

module fibonnaci_verificator;

    `timescale 1ps/1ps
    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 20;
    always #(CLK_PERIOD/2) clk = ~clk;

    reg reset;

    core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_20.mem")) core(
        .clk(clk),
        .reset(reset)
    );

    fibonnaci_test fibonnaci_duv;

    initial begin

        fibonnaci_duv = new();

        fibonnaci_duv.init(20);

        reset_();

        // Wait until program end to check
        @(core.instruction_memory_output_data == 32'h00000013);

        fibonnaci_duv.check();

        $stop();
    
    end

    task reset_;
        reset = 0;

        #(CLK_PERIOD);

        reset = 1;
    endtask 

endmodule