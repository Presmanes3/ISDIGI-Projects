`include "../../Design/golden_model_core.sv"

module cores_encapsulator(
    input clk,
    input reset
);


    // CARGAMOS MODULOS SINCLE-CYCLE ------------------------------------------------------
    golden_model_core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_20.mem")) core_fib(
        .clk(clk),
        .reset(reset)
    );

    golden_model_core #(.program_file("Core/Testing/Programs/Complex/BubbleSort/bubble.mem")) core_bubble(
        .clk(clk),
        .reset(reset)
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
                    @(testbench.cores.core_fib.instruction_memory_output_data != 32'h00000013);
                end
                begin
                    @(testbench.cores.core_fib.instruction_memory_output_data != 32'h00000013); //instruccion fin real
                end
            join


        $fwrite(txt,"ideal, real\n");

        for (int i = 0; i<Nmax_num-1; i++) begin
            int ideal_valor = testbench.cores.core_fib.data_memory.data_pool[dir_ini_core+i*4];
            int real_valor = testbench.cores.core_fib.data_memory.data_pool[dir_ini_core+i*4];

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
                    @(testbench.cores.core_bubble.instruction_memory_output_data != 32'h00000013);
                end
                begin
                    @(testbench.cores.core_fib.instruction_memory_output_data != 32'h00000013); //instruccion fin real
                end
            join

        $fwrite(txt,"ideal, real\n");

        for (int i = 0; i<Nmax_num-1; i++) begin
            int ideal_valor = testbench.cores.core_bubble.data_memory.data_pool[dir_ini_core+i*4];
            int real_valor = testbench.cores.core_bubble.data_memory.data_pool[dir_ini_core+i*4];

            $fwrite(txt,"%d, %d\n",ideal_valor, real_valor);
        
            assert (ideal_valor == real_valor) else $info("El elemento numero ",i," de fibonaci NO COINCIDE");
        end 

        $fclose(txt);

    endtask

endclass