module battery_test(
);

parameter T = 20;       // Time unit in ps

// Include format functions for tests
`include "display_format.sv"

typedef enum bit[1:0] {EMPTY = 2'b00, OTHER = 2'b01, FULL = 2'b10} STATES;
typedef enum bit {OUT_IS_IN = 0, OUT_IS_RAM = 1} OUTPUTS;

// === AUSILIARY REGISTERS FOR TESTING === //

// === BASIC TASKS === //
task init();
    basic_tasks.init();
endtask

task reset();
    basic_tasks.reset();

    #1;
endtask

task only_write();
    basic_tasks.enable_write();
    basic_tasks.disable_read();
    basic_tasks.write(8'b0000001);
endtask

task only_read();
    basic_tasks.disable_write();
    basic_tasks.read();
endtask


// === TESTS CHANGE OF STATE === //
task test_change_state_empty_other();
    test_format_display("test_change_state_empty_other");

    @(posedge fifo_iff.CLK);

    reset();

    #T;

    basic_tasks.disable_read();

    // Check state == EMPTY
    check_assertion("CURRENT STATE == EMPTY");
    assert (DUV.current_state == EMPTY)
        else $error("CURRENT STATE !- EMPTY");

    only_write();

    #1;

    check_assertion("CURRENT STATE == OTHER");
    assert (DUV.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

endtask

task test_change_state_other_empty();
    test_format_display("test_change_state_other_empty");

    @(posedge fifo_iff.CLK);

    reset();

    #T;

    check_assertion("CURRENT STATE == EMPTY");
    assert (DUV.current_state == EMPTY)
        else $error("CURRENT STATE !- EMPTY");

    only_write();

    check_assertion("CURRENT STATE == OTHER");
    assert (DUV.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

    only_read();

    check_assertion("CURRENT STATE == EMPTY");
    assert (DUV.current_state == EMPTY)
        else $error("CURRENT STATE !- EMPTY");

endtask

task test_change_state_other_full();
    test_format_display("test_change_state_other_full");

    @(posedge fifo_iff.CLK);

    reset();

    #T;

    for (int i=0; i < 31; ++i) begin
        only_write();
    end

    check_assertion("CURRENT STATE == OTHER");
    assert (DUV.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

    only_write();

    basic_tasks.enable_write();
    basic_tasks.disable_read();

    check_assertion("CURRENT STATE == FULL");
    assert (DUV.current_state == FULL)
        else $error("CURRENT STATE !- FULL");

endtask

task test_change_state_full_other();
    test_format_display("test_change_state_full_other");

    @(posedge fifo_iff.CLK);

    reset();

    #T;

    for (int i=0; i <= 32; ++i) begin
        only_write();
    end

    basic_tasks.enable_write();
    basic_tasks.disable_read();

    check_assertion("CURRENT STATE == FULL");
    assert (DUV.current_state == FULL)
        else $error("CURRENT STATE !- FULL");

    only_read();

    check_assertion("CURRENT STATE == OTHER");
    assert (DUV.current_state == OTHER)
        else $error("CURRENT STATE !- OTHER");

endtask

// === TESTS BASICS === //
task test_force_only_write();
    test_format_display("test_force_only_write");

    @(posedge fifo_iff.CLK);

    reset();

    #T;

    only_write();

    check_assertion("DATA_OUT == DATA_IN");
    assert (fifo_iff.DATA_OUT == fifo_iff.DATA_IN)
        else $error("\t DATA_OUT != DATA_IN");

    check_assertion("COUNTER_W INCREMENTED");
    assert (DUV.counter_w_current_value == 1)
        else $error("\t COUNTER_W NOT INCREMENTED");

    check_assertion("COUNTER_W INCREMENTED");
    assert (fifo_iff.USE_DW == 1)
        else $error("\t COUNTER_W NOT INCREMENTED");

    check_assertion("NEW STATE == OTHER");
    assert (DUV.next_state == OTHER)
        else $error("\t NEW STATE != OTHER");

    // Add asser for ram in
endtask

task test_write_and_read();
    test_format_display("test_write_and_read");

    @(posedge fifo_iff.CLK);

    reset();

    basic_tasks.enable_read();
    basic_tasks.enable_write();

    basic_tasks.write(8'b11111111);

    check_assertion("DATA_OUT == DATA_IN");
    assert (DUV.fifo_iff.DATA_OUT == DUV.fifo_iff.DATA_IN)
        else $error("\t DATA_OUT != DATA_IN");

    check_assertion("NEX STATE == EMPTY");
    assert (DUV.next_state == EMPTY)
        else $error("\t NEX STATE != EMPTY");

    check_assertion("OUTPUT SELECTOR == OUT_IS_IN");
    assert (DUV.output_selector == OUT_IS_IN)
        else $error("\t OUTPUT SELECTOR != OUT_IS_IN");

endtask

task test_use_dw();
    test_format_display("test_use_dw");

    @(posedge fifo_iff.CLK);

    reset();

    only_write();

    check_assertion("USE_DW == 1");
    assert (DUV.fifo_iff.USE_DW == 1)
        else $error("\t USE_DW != 1");

    only_write();

    check_assertion("USE_DW == 2");
    assert (DUV.fifo_iff.USE_DW == 2)
        else $error("\t USE_DW != 2");

    only_write();

    check_assertion("USE_DW == 3");
    assert (DUV.fifo_iff.USE_DW == 3)
        else $error("\t USE_DW != 3");

    only_read();

    check_assertion("USE_DW == 2");
    assert (DUV.fifo_iff.USE_DW == 2)
        else $error("\t USE_DW != 2");

    only_read();

    check_assertion("USE_DW == 1");
    assert (DUV.fifo_iff.USE_DW == 1)
        else $error("\t USE_DW != 1");

endtask

task test_overflow();
    test_format_display("test_overflow");

    @(posedge fifo_iff.CLK);

    reset();

    check_assertion("CURRENT_STATE == EMPTY");
    assert (DUV.current_state == EMPTY)
        else $error("\t CURRENT_STATE != EMPTY");

    basic_tasks.enable_write();
    basic_tasks.disable_read();

    for (int i=0; i <= 40; ++i) begin
        basic_tasks.write(i);
    end

    $display("Written 40 elements on FIFO");

    check_assertion("CURRENT_STATE == FULL");
    assert (DUV.current_state == FULL)
        else $error("\t CURRENT_STATE != FULL");

    check_assertion("USE_DW == 0");
    assert (DUV.fifo_iff.USE_DW == 0)
        else $error("\t USE_DW != 0");

    only_read();

    check_assertion("CURRENT_STATE == OTHER");
    assert (DUV.current_state == OTHER)
        else $error("\t CURRENT_STATE != OTHER");

    check_assertion("USE_DW == 31");
    assert (DUV.fifo_iff.USE_DW == 31)
        else $error("\t USE_DW != 31");
endtask

task test_read_full_fifo();
    test_format_display("test_read_full_fifo");

    @(posedge fifo_iff.CLK);

    reset();

        check_assertion("CURRENT_STATE == EMPTY");
    assert (DUV.current_state == EMPTY)
        else $error("\t CURRENT_STATE != EMPTY");

    basic_tasks.enable_write();
    basic_tasks.disable_read();

    for (int i=0; i <= 40; ++i) begin
        basic_tasks.write(i);
    end

    $display("Written 40 elements on FIFO");

    check_assertion("CURRENT_STATE == FULL");
    assert (DUV.current_state == FULL)
        else $error("\t CURRENT_STATE != FULL");

    check_assertion("USE_DW == 0");
    assert (DUV.fifo_iff.USE_DW == 0)
        else $error("\t USE_DW != 0");
    
    for (int i=0; i <= 40; ++i) begin
        only_read();
    end

    check_assertion("CURRENT_STATE == EMPTY");
    assert (DUV.current_state == EMPTY)
        else $error("\t CURRENT_STATE != EMPTY");

    check_assertion("USE_DW == 0");
    assert (DUV.fifo_iff.USE_DW == 0)
        else $error("\t USE_DW != 0");

endtask

task test_reset();
    test_format_display("test_reset");

    @(posedge fifo_iff.CLK);

    reset();

    check_assertion("NEW STATE == EMPTY");
    assert (DUV.next_state == EMPTY)
        else $error("\t NEW STATE != EMPTY");
endtask

task test_clear();
    test_format_display("test_clear");

    @(posedge fifo_iff.CLK);

    basic_tasks.clear();

    check_assertion("NEW STATE == EMPTY");
    assert (DUV.next_state == EMPTY)
        else $error("\t NEW STATE != EMPTY");
endtask

// === RUNNER === //

task run_battery_test();
    battery_test_display("run_tests_change_state");

    // Bsaic tests
    test_reset();
    test_clear();
    test_force_only_write();
    test_write_and_read();
    test_use_dw();
    test_overflow();
    test_read_full_fifo();

    // Change of states
    test_change_state_empty_other();
    test_change_state_other_empty();
    test_change_state_other_full();
    test_change_state_full_other();
endtask



endmodule