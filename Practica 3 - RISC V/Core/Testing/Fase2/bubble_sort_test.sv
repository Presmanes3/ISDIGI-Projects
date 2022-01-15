`include "./Golden Model/bubble_sort_golden.sv"

class bubble_test;
    
    bubble_golden golden_bubble_model;

    task init;
        golden_bubble_model = new();
        golden_bubble_model.init();
    endtask

    task check;
    
        $display("[BUBBLE SORT CHECKING START]");
        assert ( 32'h3 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[0]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 0 ARE DIFFERENT");

        assert ( 32'h3 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[1]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 1 ARE DIFFERENT");

        assert ( 32'h5 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[2]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 2 ARE DIFFERENT");

        assert ( 32'h6 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[3]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 3 ARE DIFFERENT");

        assert ( 32'h7 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[4]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 4 ARE DIFFERENT");

        assert ( 32'h8 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[5]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 5 ARE DIFFERENT");

        assert ( 32'h18 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[6]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 6 ARE DIFFERENT");

        assert ( 32'h19 == Phase2_testbench.bubble_sort_verificator.core.data_memory.data_pool[7]) 
        else $info("ERROR [BUBBLE SHORT]: NUMBERS IN POSITION 7 ARE DIFFERENT");

        $display("[BUBBLE SORT CHECKING FINISHED]");
        
    endtask //automatic

endclass //fibonnaci_scoreboard