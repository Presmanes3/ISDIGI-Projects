`include "./Golden Model/bubble_sort_golden.sv"

class bubble_test;
    
    bubble_golden golden_bubble_model;

    task init;
        golden_bubble_model = new();
        golden_bubble_model.init();
    endtask

    task check;
    
        assert (golden_bubble_model.numeros[0] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000bc]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[1] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000b8]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[2] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000b4]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[3] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000b0]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[4] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000ac]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[5] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000a8]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[6] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000a4]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        assert (golden_bubble_model.numeros[7] == bubble_sort_verificator.core.data_memory.data_pool[32'h000000a0]) 
        else $info("ERROR [BUBBLE SHORT] 1 NUMBERS ARE DIFFERENT");

        
    endtask //automatic

endclass //fibonnaci_scoreboard