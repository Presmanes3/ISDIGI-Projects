module test_cases(
    FIFO_IFF fifo_iff
);

basic_fifo_tasks basic_tasks(
    .fifo_iff(fifo_iff)
);

FIFO_32_8 fifo(
    .fifo_iff(fifo_iff)
);

// Include format functions for tests
`include "display_format.sv"




// ========== UNIT TESTS ================ //
// === TESTS INPUT ADN OUTPUT === //
task test_output_equals_input_on_write();
    test_format_display("test_output_equals_input_on_write");

    basic_tasks.reset();
    basic_tasks.write(8'b00110011);

    assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("Assertion written_data failed!");
endtask

task test_output_equals_input_always();
    test_format_display("test_output_equals_input_always");
    basic_tasks.reset(); 

    basic_tasks.write(8'b00110011);

    assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("Assertion written_data failed!");

    basic_tasks.write(8'b00000011);
    
    assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("Assertion written_data failed!");
    
endtask





// ========== TEST BATTERY ========== //
task run_tests_input_output();
    battery_test_display("run_tests_input_output");

    test_output_equals_input_on_write();
    test_output_equals_input_always();

endtask




endmodule