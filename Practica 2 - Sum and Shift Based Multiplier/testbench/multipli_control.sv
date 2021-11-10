`include "multiply_controler_classes/random.sv"
`include "multiply_controler_classes/basic_task.sv"

module multipli_control ();

    //Inicializo asignador aleatorio
    RCSG random;

    basic_task bts;

    task get_random_values();
        if (!random.randomize()) begin
			$display("randomization failed");
			$finish();
		end

        sys_iff.A = random.A_;
        sys_iff.B = random.B_;

        $display();

    endtask


    initial begin
        bts = new;

        random = new;

        sys_iff.A = random.A_;
        sys_iff.A = random.B_;


        resultadoCorrecto: assert property (@(negedge testbench.sys_iff.CLK) testbench.sys_iff.fin_mult |=> testbench.sys_iff.S_ideal == testbench.sys_iff.S_real) else $info("ASSERTION ERROR/resultadoCorrecto: Valor del resultado INCORRECTO");
        valorResetFuncional: assert property (@(negedge testbench.sys_iff.CLK) !testbench.sys_iff.RESET_N |=> testbench.sys_iff.S_ideal == 0) else $info("ASSERTION ERROR/valorResetFuncional: Reset funcional incorrecto");
        valorResetReal: assert property (@(negedge testbench.sys_iff.CLK) !testbench.sys_iff.RESET_N |=> testbench.sys_iff.S_real == 0) else $info("ASSERTION ERROR/valorResetReal: Reset real incorrecto");

    end
endmodule