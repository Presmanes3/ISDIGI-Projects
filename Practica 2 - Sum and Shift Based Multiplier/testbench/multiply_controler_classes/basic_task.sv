class basic_task;
    
    task inicializar();
        testbench.sys_iff.A = 0;
        testbench.sys_iff.B = 0;
        testbench.sys_iff.CLK = 1'b0;
        testbench.sys_iff.RESET_N = 1'b1;
        testbench.sys_iff.start = 1'b0;
        testbench.sys_iff.S = 0;
        testbench.sys_iff.fin_mult = 1'b0;
        testbench.sys_iff.S_ideal = 0;
        testbench.sys_iff.S_real = 0;
    endtask

    task reset();
        @(negedge testbench.sys_iff.CLK)
        testbench.sys_iff.RESET_N = 1'b0;
        @(negedge testbench.sys_iff.CLK)
        testbench.sys_iff.RESET_N = 1'b1; 
    endtask

     covergroup rango_valores; //Compruebo que paso por todos los valores
         a_positivo: coverpoint testbench.sys_iff.A iff(testbench.sys_iff.A > 0);
         a_negativo: coverpoint testbench.sys_iff.A iff(testbench.sys_iff.A < 0);
         a_cero: coverpoint testbench.sys_iff.A iff(testbench.sys_iff.A == 0);

         b_positivo: coverpoint testbench.sys_iff.B iff(testbench.sys_iff.B > 0);
         b_negativo: coverpoint testbench.sys_iff.B iff(testbench.sys_iff.B < 0);
         b_cero: coverpoint testbench.sys_iff.B iff(testbench.sys_iff.B == 0);
     endgroup

    //Hago varias aserciones para comprobar rapidamente que algunos valores son correctos
    //  resultadoCorrecto: assert property (testbench.sys_iff.fin_mult |=> S_ideal == S_real) else $info("ASSERTION ERROR/resultadoCorrecto: Valor del resultado INCORRECTO");
    //  valorResetFuncional: assert property (!testbench.sys_iff.RESET_N |=> testbench.sys_iff.S_ideal == 0) else $info("ASSERTION ERROR/valorResetFuncional: Reset funcional incorrecto");
    //  valorResetReal: assert property (!testbench.sys_iff.RESET_N |=> testbench.sys_iff.S_real == 0) else $info("ASSERTION ERROR/valorResetReal: Reset real incorrecto");

endclass