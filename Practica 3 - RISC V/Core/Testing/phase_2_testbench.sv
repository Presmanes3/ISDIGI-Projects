`include "../Design/core.sv"
`include "verification_manager.sv"
`include "./fibonnaci_test.sv"

module phase_2_testbench;

    `timescale 1ps/1ps
    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    reg reset;

    reg count = 0;

    // core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_10.mem")) core(
    //     .clk(clk),
    //     .reset(reset)
    // );

    core #(.program_file("Core/Testing/Programs/Complex/BubbleSort/bubble.mem")) core(
        .clk(clk),
        .reset(reset)
    );


    fibonnaci_test fibonnaci_duv;
    int current_fib_number;
    int prev_fib_number;

    verification_manager ver_duv;

    initial begin

        ver_duv = new();
        fibonnaci_duv = new();

        ver_duv.init();
        fibonnaci_duv.init();
        
        reset_();

        @(core.instruction_memory_output_data == 32'hfc000ae3);


        $stop();
    
    end

    task test_fibbo();
        wait_fibonnaci_setup();

        check_numbers_are_equal();

        while ((core.instruction_memory_output_data != 32'h00000013))begin

            wait_till_processor_computes_new_number();
            check_numbers_are_equal();

            fibonnaci_duv.golden_model.compute_new_number();

        end
        
    endtask //automatic

    task wait_fibonnaci_setup();
        @(core.instruction_memory_output_data == 32'h06562223);
    endtask 

    task wait_till_processor_computes_new_number();
        @(core.instruction_memory_output_data == 32'h00e68463);
    endtask

    task check_numbers_are_equal();
        current_fib_number = core.register_bank.reg_pool[5];
        prev_fib_number = core.register_bank.reg_pool[6];

        fibonnaci_duv.check(current_fib_number, prev_fib_number);
    endtask

    

    task reset_;
        reset = 0;

        #(CLK_PERIOD);

        reset = 1;
    endtask 

endmodule