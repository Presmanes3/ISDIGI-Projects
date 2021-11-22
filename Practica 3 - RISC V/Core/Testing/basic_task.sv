`include "interface.sv"

class RCSG_32_AB;
    rand bit signed [31:0] A_;
    rand bit signed [31:0] B_;
endclass


module basic_task;

    RCSG_32_AB random;

    initial begin
        random = new;

        inicializar ();
    end
    
    task inicializar();
        testbench.sys_iff.CLK = 0;
        testbench.sys_iff.RESET_N = 1;
        testbench.sys_iff.A_alu = 0;
        testbench.sys_iff.B_alu = 0;
        testbench.sys_iff.control_alu = 0;
    endtask

    task reset();
        @(testbench.sys_iff.ck)
        testbench.sys_iff.RESET_N = 1'b0;
        @(testbench.sys_iff.ck)
        testbench.sys_iff.RESET_N = 1'b1; 
    endtask

    task get_random_A_B();
        if (!random.randomize()) begin
			$display("randomization failed");
			$finish();
		end

        testbench.sys_iff.A = random.A_;
        testbench.sys_iff.B = random.B_;

        $display("GENERATED NUMBERS >>> A [%d] || B [%d]", $signed(testbench.sys_iff.A), $signed(testbench.sys_iff.B));
    endtask



     

endmodule