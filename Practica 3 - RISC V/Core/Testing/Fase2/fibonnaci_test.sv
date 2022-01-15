`include "./Golden Model/fibonnaci_golden.sv"

class fibonnaci_test;
    
    fibonnaci_golden golden_model;

    int total_numbers_to_verify;    // Total amount of numbers to be verified at memory

    task init(int total_numbers);
        golden_model = new();
        golden_model.init();

        this.total_numbers_to_verify = total_numbers;
    endtask

    task check();

    $display("[FIBONNACI CHECKING START]");

    assert (Phase2_testbench.fibonnaci_verificator.core.data_memory.data_pool[0] == 32'd0) 
    else   $display("[ERROR] POSITION 0 OF FIBONACCI IS WRONG");

    assert (Phase2_testbench.fibonnaci_verificator.core.data_memory.data_pool[1] == 32'd1) 
    else   $display("[ERROR] POSITION 0 OF FIBONACCI IS WRONG");

    for(int x = 2 ; x < this.total_numbers_to_verify; x++ )begin
        golden_model.compute_new_number();

        assert (Phase2_testbench.fibonnaci_verificator.core.data_memory.data_pool[x] == golden_model.current_number)
        else   $display("[ERROR] POSITION %d OF FIBONACCI IS WRONG", x);
    end

    $display("[FIBONNACI CHECKING FINISHED]");

    endtask //automatic

endclass //fibonnaci_scoreboard