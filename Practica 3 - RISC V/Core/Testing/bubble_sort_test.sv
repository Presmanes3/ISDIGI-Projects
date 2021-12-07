`include "./Golden Model/bubble_sort_golden.sv"

class bubble_test;
    
    bubble_golden golden_bubble_model;

    task init;
        golden_bubble_model = new();
        golden_bubble_model.init();
    endtask

    task check;
    
        assert ( 25 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000bc]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 0 ARE DIFFERENT");

        assert ( 24 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000b8]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 1 ARE DIFFERENT");

        assert ( 8 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000b4]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 2 ARE DIFFERENT");

        assert ( 7 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000b0]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 3 ARE DIFFERENT");

        assert ( 6 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000ac]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 4 ARE DIFFERENT");

        assert ( 5 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000a8]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 5 ARE DIFFERENT");

        assert ( 3 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000a4]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 6 ARE DIFFERENT");

        assert ( 3 == bubble_sort_verificator.core.data_memory.data_pool[32'h000000a0]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 7 ARE DIFFERENT");

        
    endtask //automatic

endclass //fibonnaci_scoreboard