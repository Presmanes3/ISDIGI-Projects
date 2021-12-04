`include "./Golden Model/fibonnaci_golden.sv"

class fibonnaci_test;
    
    fibonnaci_golden golden_model;

    task init;
        golden_model = new();
        golden_model.init();
    endtask

    task check(int current_fib_number, int prev_fib_number);
        int golden_number_current = golden_model.current_number;
        int golden_number_prev = golden_model.prev_number;

        $display("[RISC V] : [%d] [%d] <     > [GOLDEN] : [%d] [%d]", prev_fib_number, current_fib_number, golden_number_prev, golden_number_current);
        assert (current_fib_number == golden_number_current && prev_fib_number == golden_number_prev) 
        else   $info("ERROR [FIBONNACI CHECK] NUMBERS ARE DIFFERENT");
    endtask //automatic

endclass //fibonnaci_scoreboard