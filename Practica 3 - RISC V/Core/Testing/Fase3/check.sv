`include "../../Design/core.sv"

module core_instances;


    // CARGAMOS MODULOS SINCLE-CYCLE ------------------------------------------------------
    core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_20.mem")) core_fib(
        .clk(testbench.sys_iff.ck),
        .reset(testbench.sys_iff.RESET_N)
    );

    core #(.program_file("Core/Testing/Programs/Complex/BubbleSort/bubble.mem")) core_bubble(
        .clk(testbench.sys_iff.ck),
        .reset(testbench.sys_iff.RESET_N)
    );
    // ------------------------------------------------------------------------------------

    // CARGAMOS MODULOS REALES ------------------------------------------------------------

    // ------------------------------------------------------------------------------------
endmodule

class core_test;

    task fibo_test();

        int Nmax_num = 20;
        int dir_ini_core = 0;
        int dir_ini_DUV = 0;
        integer txt = $fopen("fibbonaci.txt","a");

            fork
                begin
                    @(core_instances.core_fib.instruction_memory_output_data != 32'h00000013);
                end
                begin
                    @(core_instances.core_fib.instruction_memory_output_data != 32'h00000013); //instruccion fin real
                end
            join


        $fwrite(txt,"ideal, real\n");

        for (int i = 0; i<Nmax_num-1; i++) begin
            int ideal_valor = core_instances.core_fib.data_memory.data_pool[dir_ini_core+i*4];
            int real_valor = core_instances.core_fib.data_memory.data_pool[dir_ini_core+i*4];

            $fwrite(txt,"%d, %d\n",ideal_valor, real_valor);
        
            assert (ideal_valor == real_valor) else $info("El elemento numero ",i," de fibonaci NO COINCIDE");
        end 

        $fclose(txt);

    endtask

    task bubble_test();

        int Nmax_num = 20;
        int dir_ini_core = 0;
        int dir_ini_DUV = 0;
        integer txt = $fopen("bubble_sort.txt","a");

            fork
                begin
                    @(core_instances.core_bubble.instruction_memory_output_data != 32'h00000013);
                end
                begin
                    @(core_instances.core_fib.instruction_memory_output_data != 32'h00000013); //instruccion fin real
                end
            join

        $fwrite(txt,"ideal, real\n");

        for (int i = 0; i<Nmax_num-1; i++) begin
            int ideal_valor = core_instances.core_bubble.data_memory.data_pool[dir_ini_core+i*4];
            int real_valor = core_instances.core_bubble.data_memory.data_pool[dir_ini_core+i*4];

            $fwrite(txt,"%d, %d\n",ideal_valor, real_valor);
        
            assert (ideal_valor == real_valor) else $info("El elemento numero ",i," de fibonaci NO COINCIDE");
        end 

        $fclose(txt);

    endtask

endclass