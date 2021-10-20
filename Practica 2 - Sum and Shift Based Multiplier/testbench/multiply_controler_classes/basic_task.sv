class basic_task;

    system_iff sys_iff;
    
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

   
    resultadoCorrecto: assert property (Fin_Mult |=> S_ideal == S_real) else $info("ASSERTION ERROR/resultadoCorrecto: Valor del resultado INCORRECTO");
    valorReset: assert property ()

endtask