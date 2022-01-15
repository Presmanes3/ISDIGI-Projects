`include "./bubble_sort_verificator.sv"
`include "./fibonnaci_verificator.sv"

module Phase2_testbench (
    
);
    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 20;
    always #(CLK_PERIOD/2) clk =~ clk;

    clocking ck @(posedge clk); //usar ck como clock
        default input #1ns output #1ns;
    endclocking:ck

    reg reset;

    bubble_sort_verificator bubble_sort_verificator(
        .clk(clk),
        .reset(reset)
    );

    fibonnaci_verificator fibonnaci_verificator(
        .clk(clk),
        .reset(reset)
    );

    task reset_;
        reset = 0;

        #(CLK_PERIOD);

        reset = 1;
    endtask 

    initial begin
        @(bubble_sort_verificator.test_finished == 1 && fibonnaci_verificator.test_finished == 1);

        $stop();
    end
    
    
endmodule
