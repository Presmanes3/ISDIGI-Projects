module test_cases(
    FIFO_IFF fifo_iff
);

test_tasks basic_tasks(
    .fifo_iff(fifo_iff)
);

FIFO_32_8 fifo(
    .fifo_iff(fifo_iff)
);


// ========== PROPERTY ASSERTS ========== //


// ========== UNIT TESTS ================ //
// === TESTS INPUT ADN OUTPUT === //
task test_output_equals_input_on_write();
    $display("[TEST] > test_output_equals_input_on_write");

    basic_tasks.reset();
    basic_tasks.write(8'b00110011);

    data_in_equals_data_out: assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("Assertion written_data failed!");
endtask

task test_output_equals_input_always();
    $display("[TEST] > test_output_equals_input_always");
    basic_tasks.reset(); 

    basic_tasks.write(8'b00110011);

    data_in_equals_data_out: assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("Assertion written_data failed!");

    basic_tasks.write(8'b00000011);
    
    data_in_equals_data_out: assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("Assertion written_data failed!");
    
endtask

// === TESTS COUNTERS === //
task test_counter_w_up_on_write();
    $display("[TEST] > test_counter_w_up_on_write");
    basic_tasks.reset();
endtask

task test_counter_r_up_on_read();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();
endtask

task test_counter_dw_up_on_write();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();
endtask

task test_counter_dw_down_on_read();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();
endtask

task test_counter_dw_equal_on_read_and_write();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();
endtask


// === TESTS CHANGE OF STATE === //
task test_change_state_empty_other();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();

    // Check state == EMPTY
    // Write 1 element 
    // Check state == OTHER
endtask

task test_change_state_other_empty();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();

    // Write 1 element
    // Check state == OTHER
    // Read 1 element
    // Check state == EMPTY
endtask

task test_change_state_other_full();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();

    // Write 30 element
    // Check state == OTHER
    // Write 1 element
    // Check state == FULL
endtask

task test_change_state_full_other();
    $display("[TEST] > test_counter_r_up_on_read");
    basic_tasks.reset();

    // Write 31 element
    // Check state == FULL
    // Read 1 element
    // Check state == OTHER
endtask


task run_tests_input_output();
    $display("[TEST BATTERY] > run_tests_input_output");
    test_output_equals_input_on_write();
    test_output_equals_input_always();

endtask

endmodule