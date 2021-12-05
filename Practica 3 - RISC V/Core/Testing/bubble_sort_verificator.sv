`include "../Design/core.sv"
`include "verification_manager.sv"
`include "./bubble_sort_test.sv"

module bubble_sort_verificator;

    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    clocking ck @(posedge clk); //usar ck como clock
        default input #1ns output #1ns;
    endclocking:ck

    reg reset;

    // core #(.program_file("Core/Testing/Programs/Simple/R/ADD.mem")) core(
    //     .clk(clk),
    //     .reset(reset)
    // );

    // core #(.program_file("Core/Testing/Programs/Simple/TUTI.mem")) core(
    //     .clk(clk),
    //     .reset(reset)
    // );

    core #(.program_file("Core/Testing/Programs/Complex/bubble.mem")) core(
        .clk(clk),
        .reset(reset)
    );

    bubble_test bubble_duv;

    verification_manager ver_duv;

    initial begin

        ver_duv = new();
        bubble_duv = new();

        ver_duv.init();
        bubble_duv.init();
        

        reset_();

        clk = 1;

        #(1);

        while (bubble_duv.golden_bubble_model.i<8)begin



            @(ck)

            bubble_duv.golden_bubble_model.compute_new_number();

            bubble_duv.check();

            #(1);
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