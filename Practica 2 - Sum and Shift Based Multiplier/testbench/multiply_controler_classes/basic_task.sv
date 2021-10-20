class basic_task;
    
    task inicializar();
        sys_iff.A = 0;
        sys_iff.B = 0;
        sys_iff.CLK = 1'b0;
        sys_iff.RESET_N = 1'b1;
        sys_iff.start = 1'b0;
    endtask

    task reset(A,B,RESET_N,CLK);
        sys_iff.RESET_N = 1'b1;
        @(negedge CLK)
        sys_iff.RESET_N = 1'b0; 
    endtask

    // covergroup valoresx;
    //     coverpoint cositas;
    // endgroup;


   
    // resultadoCorrecto: assert property (sys_iff.fin_mult |=> S_ideal == S_real) else $info("ASSERTION ERROR/resultadoCorrecto: Valor del resultado INCORRECTO");
    // valorResetFuncional: assert property (!sys_iff.RESET_N |=> sys_iff.S_ideal == 0) else $info("ASSERTION ERROR/valorResetFuncional: Reset funcional incorrecto");
    // valorResetReal: assert property (!sys_iff.RESET_N |=> sys_iff.S_real == 0) else $info("ASSERTION ERROR/valorResetReal: Reset real incorrecto");

endclass