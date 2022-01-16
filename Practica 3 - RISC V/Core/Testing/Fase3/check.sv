`include "../../Design/core.sv"

module cores_encapsulator(
    input clk,
    input reset
);
    core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_20.mem")) fibo_core(
        .clk(clk),
        .reset(reset)
    );

    core #(.program_file("Core/Testing/Programs/Complex/BubbleSort/bubble.mem")) bubble_short_core(
        .clk(clk),
        .reset(reset)
    );
endmodule

class core_test;


    task fibo_test();
        int Nmax_num = 20;
        int dir_ini_core = 0;
        int dir_ini_DUV = 0;
        int file;

        string relative_path = "../../Proyecto Questasim/Basic Testing/../../";
        string complete_path = {relative_path,"Core/Testing/Fase3/Out/fib_memory_testbench_out.txt"};

        file = $fopen(complete_path,"w");

        $display("[FIBBONACCI] starting test!");

        // Write header for the file
        $fwrite(file,"[GOLDEN], [SEGMENTED]\n");
        
        fork
            begin
                // Wait till the golden model finishes
                @(testbench.cores.fibo_core.golden_core_wires.instruction_memory_wiring.output_data != 32'h00000013);
                $display("[FIBBONACCI] Golden model finished");
            end
            begin
                // Wait till the segmented model finishes
                 @(testbench.cores.fibo_core.segmented_core_wires.instruction_memory_wiring.output_data != 32'h00000013); //instruccion fin real
                $display("[FIBBONACCI] Segmented model finished");
            end
        join

        $display("[FIBBONACCI] Starting with the checking");
        // Write data into file and check if both are the same
        for (int i = 0; i < Nmax_num; i++) begin
            int golden_value    = testbench.cores.fibo_core.golden_core.data_memory.data_pool[i];
            int segmented_value = testbench.cores.fibo_core.segmented_core.data_memory.data_pool[i];

            $fwrite(file,"%d, %d\n",golden_value, segmented_value);
        
            //assert (golden_value == segmented_value) else $info("El elemento numero ",i," de fibonaci NO COINCIDE");
        end 

        $display("[FIBBONACCI] finishing test!");
        $fclose(file);


    endtask

    task bubble_test();

        int Nmax_num = 20;
        int dir_ini_core = 0;
        int dir_ini_DUV = 0;
        int file;

        string relative_path = "../../Proyecto Questasim/Basic Testing/../../";
        string complete_path = {relative_path,"Core/Testing/Fase3/Out/bubble_memory_testbench_out.txt"};

        file = $fopen(complete_path,"w");

        $display("[BUBBLE] starting test!");

        // Write header for the file
        $fwrite(file,"[GOLDEN], [SEGMENTED]\n");

            fork
                begin
                    @(testbench.cores.bubble_short_core.golden_core_wires.instruction_memory_wiring.output_data != 32'h00000013);
                    $display("[BUBBLE] Golden model finished");
                end
                begin
                    //@(testbench.cores.bubble_short_core.segmented_core_wires.instruction_memory_wiring.output_data != 32'h00000013); //instruccion fin real
                    $display("[BUBBLE] Segmented model finished");
                end
            join

        $fwrite(file,"ideal, real\n");

        for (int i = 0; i < Nmax_num; i++) begin
            int golden_value    = testbench.cores.bubble_short_core.golden_core.data_memory.data_pool[i];
            int segmented_value = testbench.cores.bubble_short_core.segmented_core.data_memory.data_pool[i];

            $fwrite(file,"%d, %d\n",golden_value, segmented_value);
        
            //assert (golden_value == segmented_value) else $info("El elemento numero ",i," de bubble sort NO COINCIDE");
        end 

        $display("[BUBBLE] finishing test!");
        $fclose(file);

    endtask

endclass