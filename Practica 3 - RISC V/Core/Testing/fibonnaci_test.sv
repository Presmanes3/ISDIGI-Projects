`include "./Golden Model/fibonnaci_golden.sv"

class fibonnaci_test;
    
    fibonnaci_golden golden_model;

    task init;
        golden_model = new();
        golden_model.init();
    endtask

    task check;
        int real_number_current = phase_2_testbench.core.register_bank.reg_pool[5];
        int golden_number_current = golden_model.current_number;

        int real_number_prev = phase_2_testbench.core.register_bank.reg_pool[6];
        int golden_number_prev = golden_model.prev_number;

        $display("[RISC V] : [%d] [%d] <     > [GOLDEN] : [%d] [%d]", real_number_prev, real_number_current, golden_number_prev, golden_number_current);
        assert (real_number_current == golden_number_current && real_number_prev == golden_number_prev) 
        else   $info("ERROR [FIBONNACI CHECK] NUMBERS ARE DIFFERENT");
    endtask //automatic

endclass //fibonnaci_scoreboard