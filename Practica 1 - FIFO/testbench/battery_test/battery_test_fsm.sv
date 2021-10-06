interface FSM_IFF;
    logic current_state;
    logic next_state;

    logic [1:0] read_write_conc;

    logic flag_use_dw_31;
    logic flag_use_dw_1;

    logic output_selector;

    logic [4 : 0] counter_w_out;
    logic [4 : 0] counter_r_out;
    logic [4 : 0] counter_dw_out;
    logic [4 : 0] counter_dw_mode;
endinterface


module battery_test_fsm(
    FIFO_IFF fifo_iff,
    FSM_IFF fsm_iff
);

`timescale 1ns/1ps

parameter T = 20;       // Time unit in ps

// Include format functions for tests
`include "display_format.sv"

typedef enum bit[1:0] {EMPTY = 2'b00, OTHER = 2'b01, FULL = 2'b10} STATES;

// Create basic tasks instance
basic_fifo_tasks basic_tasks(
    .fifo_iff(fifo_iff)
);


// === AUSILIARY REGISTERS FOR TESTING === //

// === BASIC TASKS === //
task init();
    basic_tasks.init();
endtask

task reset();
    basic_tasks.reset();

    #1;
endtask

task write();
    basic_tasks.enable_write();
    basic_tasks.disable_read();
    basic_tasks.write(8'b0000001);

    #T;
endtask

task read();
    basic_tasks.disable_write();
    basic_tasks.enable_read();

    #T;
endtask


    
// === TESTS UPDATE STATE ====== //
task test_update_empty_state();
    test_format_display("test_update_empty_state");

endtask

task test_update_other_state();
    test_format_display("test_update_other_state");

endtask

task test_update_full_state();
    test_format_display("test_update_full_state");
    
endtask


// === TESTS CHANGE OF STATE === //
task test_change_state_empty_other();
    test_format_display("test_change_state_empty_other");

    reset();

    // Check state == EMPTY
    check_assertion("CURRENT STATE == EMPTY");
    assert (fsm_iff.current_state == EMPTY)
        else $error("CURRENT STATE !- EMPTY");

    write();

    check_assertion("CURRENT STATE == OTHER");
    assert (fsm_iff.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

    // Write 1 element 
    // Check state == OTHER
endtask

task test_change_state_other_empty();
    test_format_display("test_change_state_other_empty");

    reset();

    // Check state == EMPTY
    check_assertion("CURRENT STATE == EMPTY");
    assert (fsm_iff.current_state == EMPTY)
        else $error("CURRENT STATE !- EMPTY");

    write();

    check_assertion("CURRENT STATE == OTHER");
    assert (fsm_iff.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

    read();

    check_assertion("CURRENT STATE == EMPTY");
    assert (fsm_iff.current_state == EMPTY)
        else $error("CURRENT STATE !- EMPTY");

endtask

task test_change_state_other_full();
    test_format_display("test_change_state_other_full");

    reset();

    for (int i=0; i < 31; ++i) begin
        write();
    end

    check_assertion("CURRENT STATE == OTHER");
    assert (fsm_iff.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

    write();

    check_assertion("CURRENT STATE == FULL");
    assert (fsm_iff.current_state == FULL)
        else $error("CURRENT STATE !- FULL");

endtask

task test_change_state_full_other();
    test_format_display("test_change_state_full_other");

    // Write 31 element
    // Check state == FULL
    // Read 1 element
    // Check state == OTHER
endtask

// === TESTS BASICS === //
task test_force_write();
    test_format_display("test_force_write");

    write();

    check_assertion("DATA_OUT == DATA_IN");
    assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("\t DATA_OUT != DATA_IN");

    check_assertion("COUNTER_W INCREMENTED");
    assert (fsm_iff.counter_w_out == 1)
        else $error("\t COUNTER_W NOT INCREMENTED");

    check_assertion("COUNTER_W INCREMENTED");
    assert (fifo_iff.USE_DW == 1)
        else $error("\t COUNTER_W NOT INCREMENTED");

    check_assertion("NEW STATE == OTHER");
    assert (fsm_iff.next_state == OTHER)
        else $error("\t NEW STATE != OTHER");

    // Add asser for ram in
endtask

task run_battery_test();
    battery_test_display("run_tests_change_state");

    // Bsaic tests
    test_force_write();

    // Update of states
    test_update_empty_state();

    test_update_other_state();

    test_update_full_state();

    // Change of states
    test_change_state_empty_other();

    test_change_state_other_empty();

    test_change_state_other_full();

    test_change_state_full_other();


endtask



endmodule