class basic_task;
    
    task inicializar();
        
    endtask

    task reset();
        @(negedge testbench.sys_iff.CLK)
        testbench.sys_iff.RESET_N = 1'b0;
        @(negedge testbench.sys_iff.CLK)
        testbench.sys_iff.RESET_N = 1'b1; 
    endtask

     

endclass