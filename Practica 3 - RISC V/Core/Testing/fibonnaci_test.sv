`include "./Golden Model/fibonnaci_golden.sv"

class fibonnaci_test;
    
    fibonnaci_golden golden_model;

    task init;
        golden_model = new();
        golden_model.init();
    endtask

    task check;
        int real_number = phase_2_testbench.core.register_bank.reg_pool[5];
        int golden_number = golden_model.prev_number;

        $display("[CHECKING FIBONNACI] > [%d] == [%d]", real_number, golden_number);
        assert (real_number == golden_number) 
        else   $info("ERROR [FIBONNACI CHECK] NUMBERS ARE DIFFERENT");
    endtask //automatic

endclass //fibonnaci_scoreboard