class scoreboard;

    task multiply(int A, int B);
        if(testbench.sys_iff.start == 1'b1)
        begin
            testbench.sys_iff.S_ideal = A * B;
        end
    endtask

    task compare_outputs();
        if(testbench.sys_iff.fin_mult == 1'b1)
        begin
            $display("[COMPARING OUTPUTS] {IDEAL : %d} == {RESULT : %d}", testbench.sys_iff.S_ideal, testbench.sys_iff.S_real);
            if(testbench.sys_iff.S_ideal == testbench.sys_iff.S_real)
                $display("RESULTS ARE EQUAL");
            else
                $display("RESULTS ARE EQUAL");
        

        end
    endtask

endclass