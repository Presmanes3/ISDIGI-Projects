
class RCSG_DIN;
    rand bit signed [15:0] DIN;
endclass


module basic_task();

    RCSG_DIN random_DIN;

    initial begin
        random_DIN = new;
    end
    
    task inicializar();
        testbench.sys_iff.CLK = 0;
        testbench.sys_iff.RESET_N = 1;
        testbench.sys_iff.DIN = 0;
    endtask

    task reset();
        @(testbench.sys_iff.ck)
        testbench.sys_iff.RESET_N = 1'b0;
        @(testbench.sys_iff.ck)
        testbench.sys_iff.RESET_N = 1'b1; 
    endtask

    task get_random_DIN();
        if (!random.randomize()) begin
			$display("randomization failed");
			$finish();
		end

        testbench.sys_iff.DIN= random_DIN.DIN;

        $display("GENERATED DIN >>> ", $signed(testbench.sys_iff.DIN));
    endtask

endmodule