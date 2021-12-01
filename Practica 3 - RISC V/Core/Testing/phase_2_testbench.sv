`include "../Design/core.sv"
`include "verification_manager.sv"
module phase_2_testbench;

    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    reg reset;

    // core #(.program_file("Core/Testing/Programs/Simple/R/ADD.mem")) core(
    //     .clk(clk),
    //     .reset(reset)
    // );

    

    core #(.program_file("Core/Testing/Programs/Simple/TUTI.mem")) core(
        .clk(clk),
        .reset(reset)
    );

        verification_manager ver_duv;

    initial begin

        ver_duv = new();
        ver_duv.init();

        reset_();

        clk = 1;

        #(1);

        ver_duv.update();

        $stop();
    
    end
    

    task reset_;
        reset = 0;

        #(CLK_PERIOD);

        reset = 1;
    endtask 

endmodule