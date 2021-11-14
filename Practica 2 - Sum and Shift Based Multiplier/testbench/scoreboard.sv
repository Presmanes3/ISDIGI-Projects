class scoreboard #(int size);

    logic signed [size - 1 : 0 ] A_;
    logic signed [size - 1 : 0 ] B_;
    logic signed [size * 2 - 1 : 0] result;


    // Function that allows to multiply DIRECTLY the values stored at A and B registers of the testbench
    task multiply();

        A_ = testbench.sys_iff.A;
        B_ = testbench.sys_iff.B;


        if(testbench.sys_iff.start == 1'b1)
        begin
            result = A_ * B_;        

            testbench.sys_iff.S_ideal =  $signed(result);
        end
    endtask


    // Function that compares the output of the real and ideal values
    task compare_outputs();
        if(testbench.sys_iff.fin_mult == 1'b1)
        begin
            $display("COMPARING OUTPUTS \t>>>\t[IDEAL : %d] == [REAL : %d]", $signed(testbench.sys_iff.S_ideal), $signed(testbench.sys_iff.S_real));

            comprobar_resultados: assert (testbench.sys_iff.S_ideal == testbench.sys_iff.S_real) else $info("ASSERT ERROR:  RESULTS ARE NOT EQUAL");
        end
        else begin
            $display("NOT COMPARING >>> FIN_MULT != 1");
        end
    endtask

endclass