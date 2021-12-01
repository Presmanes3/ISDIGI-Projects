`include "../Design/core.sv"
`include "verification_manager.sv"
`include "./fibonnaci_test.sv"

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

    // core #(.program_file("Core/Testing/Programs/Simple/TUTI.mem")) core(
    //     .clk(clk),
    //     .reset(reset)
    // );

    core #(.program_file("Core/Testing/Programs/Complex/fibonnaci.mem")) core(
        .clk(clk),
        .reset(reset)
    );

    fibonnaci_test fibonnaci_duv;

    verification_manager ver_duv;

    initial begin

        ver_duv = new();
        fibonnaci_duv = new();

        ver_duv.init();
        fibonnaci_duv.init();
        

        reset_();

        clk = 1;

        #(1);

        while (core.instruction_memory_output_data != 32'h00100013)begin

            

            @(core.instruction_memory_output_data == 32'h00e68463)

            fibonnaci_duv.golden_model.compute_new_number();

            fibonnaci_duv.check();

            ver_duv.update();
        end

        



        $stop();
    
    end
    

    task reset_;
        reset = 0;

        #(CLK_PERIOD);

        reset = 1;
    endtask 

endmodule