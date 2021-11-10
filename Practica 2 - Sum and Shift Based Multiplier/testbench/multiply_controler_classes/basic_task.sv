class basic_task;
    
    task inicializar();
        testbench.sys_iff.A = 0;
        testbench.sys_iff.B = 0;
        testbench.sys_iff.CLK = 1'b0;
        testbench.sys_iff.RESET_N = 1'b1;
        testbench.sys_iff.start = 1'b0;
        //testbench.sys_iff.S = 0;
        //testbench.sys_iff.fin_mult = 1'b0;
        //testbench.sys_iff.S_ideal = 0;
        //testbench.sys_iff.S_real = 0;
    endtask

    task reset();
        @(negedge testbench.sys_iff.CLK)
        testbench.sys_iff.RESET_N = 1'b0;
        @(negedge testbench.sys_iff.CLK)
        testbench.sys_iff.RESET_N = 1'b1; 
    endtask

     

endclass