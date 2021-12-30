`include "../Design/core.sv"
`include "./bubble_sort_test.sv"

module bubble_sort_verificator;

    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 20;
    always #(CLK_PERIOD/2) clk=~clk;

    clocking ck @(posedge clk); //usar ck como clock
        default input #1ns output #1ns;
    endclocking:ck

    reg reset;

    core #(.program_file("Core/Testing/Programs/Complex/BubbleSort/bubble.mem")) core(
        .clk(clk),
        .reset(reset)
    );

    bubble_test bubble_duv;

    initial begin
        bubble_duv = new();

        bubble_duv.init();
        
        reset_();

        // Wait until program end to check
        @(core.instruction_memory_output_data == 32'h00000013)

        bubble_duv.check();

        $stop();
    
    end
    

    task reset_;
        reset = 0;

        #(CLK_PERIOD);

        reset = 1;
    endtask 

endmodule