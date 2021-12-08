`include "../Design/core.sv"
`include "verification_manager.sv"
`include "./fibonnaci_test.sv"

module phase_2_testbench;

    `timescale 1ps/1ps
    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 20;
    always #(CLK_PERIOD/2) clk = ~clk;

    reg reset;

    reg count = 0;

    // core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_20.mem")) core(
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

        // test_fibbo();
        
        test_bubble();

        $stop();
    
    end

    task test_bubble();

        // Wait for the registers setup
        @(core.instruction_memory_output_data == 32'h00520e63);

        @(core.instruction_memory_output_data == 32'h00000013);


        // while (core.instruction_memory_output_data != 32'h00000013) begin
            
        //     // Wait until checking if finished
        //     //@(core.instruction_memory_output_data == 32'h02041263)
        //     // Wait till swap
        //     // @(core.instruction_memory_output_data == 32'h0263c263)

        //     $display("New instruction charged!");
            
        // end
    endtask //automatic

    task test_fibbo();
        $display("5.1");
        wait_fibonnaci_setup();
        $display("5.2");

        check_numbers_are_equal();
        $display("5.3");

        while ((core.instruction_memory_output_data != 32'h00000013))begin
            $display("5.4");

            wait_till_processor_computes_new_number();
            $display("5.5");
            check_numbers_are_equal();
            $display("5.6");

            fibonnaci_duv.golden_model.compute_new_number();
            $display("5.7");

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