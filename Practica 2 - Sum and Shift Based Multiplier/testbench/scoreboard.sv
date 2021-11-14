class scoreboard #(parameter int size);

    logic signed [size - 1 : 0 ] A_;
    logic signed [size - 1 : 0 ] B_;
    logic signed [size * 2 - 1 : 0]result;

    task multiply();

        A_ = testbench.sys_iff.A;
        B_ = testbench.sys_iff.B;


        if(testbench.sys_iff.start == 1'b1)
        begin
            result = A_ * testbench.sys_iff.B;            
            testbench.sys_iff.S_ideal = result;
        end
    endtask


    task compare_outputs();
        if(testbench.sys_iff.fin_mult == 1'b1)
        begin
            $display("[COMPARING OUTPUTS] {IDEAL : %d} == {RESULT : %d}", testbench.sys_iff.S_ideal, testbench.sys_iff.S_real);
            // if(testbench.sys_iff.S_ideal == testbench.sys_iff.S_real)
            //     $display("RESULTS ARE EQUAL");
            // else
            //     $display("RESULTS ARE NOT EQUAL");

            comprobar_resultados: assert (testbench.sys_iff.S_ideal == testbench.sys_iff.S_real) else $info("ASSERT ERROR:  RESULTS ARE NOT EQUAL");
        end
    endtask

endclass