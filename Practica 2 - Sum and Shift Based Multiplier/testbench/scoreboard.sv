class scoreboard;

    task multiply(int A, int B);
        if(sys_iff.start == 1'b1)
        begin
            sys_iff.S_ideal = A * B;
        end
    endtask

    task compare_outputs();
        if(sys_iff.fin_mult == 1'b1)
        begin
            $display("[COMPARING OUTPUTS] {IDEAL : %d} == {RESULT : %d}", ideal_result, real_result);
            if(sys_iff.ideal_result == sys_iff.real_result)
                $display("RESULTS ARE EQUAL");
            else
                $display("RESULTS ARE EQUAL");
        

        end
    endtask

endclass