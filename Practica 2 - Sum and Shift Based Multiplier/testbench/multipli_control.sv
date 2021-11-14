`include "multiply_controler_classes/random.sv"
`include "multiply_controler_classes/basic_task.sv"

covergroup rango_valores_grupos; //Compruebo que paso por todos los valores
    a_positivo: coverpoint testbench.sys_iff.A iff(testbench.sys_iff.A > 0);
    a_negativo: coverpoint testbench.sys_iff.A iff(testbench.sys_iff.A < 0);
    a_cero: coverpoint testbench.sys_iff.A iff(testbench.sys_iff.A == 0);

    b_positivo: coverpoint testbench.sys_iff.B iff(testbench.sys_iff.B > 0);
    b_negativo: coverpoint testbench.sys_iff.B iff(testbench.sys_iff.B < 0);
    b_cero: coverpoint testbench.sys_iff.B iff(testbench.sys_iff.B == 0);
endgroup

covergroup rango_valores;
    valores_A: coverpoint testbench.sys_iff.A;
    valores_B: coverpoint testbench.sys_iff.B;
endgroup

module multipli_control ();

    //Inicializo asignador aleatorio
    RCSG random;

    basic_task bts;

    rango_valores_grupos rango_valores_grupos_inst;

    rango_valores rango_valores_inst;


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

        rango_valores_grupos_inst = new;
        rango_valores_inst = new;

        resultadoCorrecto: assert property (@(negedge testbench.sys_iff.CLK) testbench.sys_iff.fin_mult |=> testbench.sys_iff.S_ideal == testbench.sys_iff.S_real) else $info("ASSERTION ERROR/resultadoCorrecto: Valor del resultado INCORRECTO");
        valorResetFuncional: assert property (@(negedge testbench.sys_iff.CLK) !testbench.sys_iff.RESET_N |=> testbench.sys_iff.S_ideal == 0) else $info("ASSERTION ERROR/valorResetFuncional: Reset funcional incorrecto");
        valorResetReal: assert property (@(negedge testbench.sys_iff.CLK) !testbench.sys_iff.RESET_N |=> testbench.sys_iff.S_real == 0) else $info("ASSERTION ERROR/valorResetReal: Reset real incorrecto");

    end
endmodule