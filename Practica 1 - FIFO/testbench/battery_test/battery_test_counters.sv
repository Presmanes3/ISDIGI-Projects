module battery_test_counters(
    COUNTER_WIRING_IFF counter_iff
);

`timescale 1ns/1ps

parameter T = 20;       // Time unit in ps

// Include format functions for tests
`include "display_format.sv"


// === BASIC TASKS === //
task reset();
    #0 counter_iff.RST_N = 0;
    #1 counter_iff.RST_N = 1;
endtask

task init();
    counter_iff.ENABLE  = 0;
    counter_iff.MODE    = 0;
    counter_iff.RST_N   = 1;
endtask

task count_up();
    counter_iff.ENABLE  = 1;
    counter_iff.MODE    = 1;
    @(posedge counter_iff.CLK);
endtask

task count_down();
    counter_iff.ENABLE  = 1;
    counter_iff.MODE    = 0;
    @(posedge counter_iff.CLK);
endtask


// ========== PROPERTIES ASSERT ========== //
/*
property property_counter_counts_up;
    @(posedge counter_iff.CLK) (counter_iff.ENABLE) |-> (counter_iff.MODE) |=> (counter_iff.ENABLE) |-> (counter_iff.OUT == $past(counter_iff.OUT + 1))
endproperty assert property (property_counter_counts_up)
    else $error("Asertion 'property_counter_counts_up' failed!");

property property_counter_counts_down;
    @(posedge counter_iff.CLK) (counter_iff.ENABLE) |-> (!counter_iff.MODE) |=> (counter_iff.ENABLE) |-> (counter_iff.OUT == $past(counter_iff.OUT - 1))
endproperty assert property (property_counter_counts_down)
    else $error("Asertion 'property_counter_counts_down' failed!");
*/


// === TESTS COUNTERS === //
reg prev_counter_val;
reg current_counter_val;
reg diff;

task test_count_up();
    test_format_display("test_count_up");

    prev_counter_val = counter_iff.OUT;

    count_up();

    #1;
    current_counter_val = counter_iff.OUT;

    diff = current_counter_val - prev_counter_val;

    check_counter_add_one: assert (diff == 1)
        else $error("Assertion check_counter_add_one failed!");

    @(negedge counter_iff.CLK);
endtask

task test_count_down();
    test_format_display("test_count_down");


    prev_counter_val = counter_iff.OUT;

    count_down();

    #1;
    current_counter_val = counter_iff.OUT;

    diff = prev_counter_val - current_counter_val;

    check_counter_sub_one: assert (diff == 1)
        else $error("Assertion check_counter_sub_one failed!");

    @(negedge counter_iff.CLK);

endtask

task test_reset();
    test_format_display("test_reset");

    reset();

    check_counter_reset: assert (counter_iff.OUT == 5'b00000)
        else $error("Assertion check_counter_reset failed!");
endtask

task test_disable();
    test_format_display("test_disable");

    prev_counter_val = counter_iff.OUT;

    counter_iff.ENABLE  = 0;
    counter_iff.MODE    = 1;
    @(posedge counter_iff.CLK);
    counter_iff.ENABLE = 0;

    #1;
    current_counter_val = counter_iff.OUT;

    check_disable_counter: assert (current_counter_val == prev_counter_val)
        else $error("Assertion check_disable_counter failed!");

    @(negedge counter_iff.CLK);
endtask


task run_battery_test();
    battery_test_display("COUNTER BATTERY TEST");

    reset();
    test_count_up();

    reset();
    test_count_down();

    reset();
    test_reset();

    reset();
    test_disable();

endtask
    
endmodule