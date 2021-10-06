module tb_FIFO(
    
);

// ===== INTERFACES ===== //
FIFO_IFF fifo_iff();
COUNTER_WIRING_IFF counter_iff();
FSM_IFF fsm_iff();


// ===== ASSIGNS ===== //
assign counter_iff.CLK  = DUV.fifo_iff.CLK;

assign fsm_iff.current_state    = DUV.current_state;
assign fsm_iff.next_state       = DUV.next_state;
assign fsm_iff.read_write_conc  = DUV.read_write_conc;
assign fsm_iff.flag_use_dw_31   = DUV.flag_use_dw_31;
assign fsm_iff.flag_use_dw_1    = DUV.flag_use_dw_1;
assign fsm_iff.output_selector  = DUV.output_selector;
assign fsm_iff.counter_w_out    = DUV.counter_w_current_value;
assign fsm_iff.counter_r_out    = DUV.counter_w_current_value;
assign fsm_iff.counter_dw_out   = DUV.fifo_iff.USE_DW;
assign fsm_iff.counter_dw_mode  = DUV.counter_dw_mode;


battery_test_fsm BT_fsm(
    .fsm_iff(fsm_iff),
    .fifo_iff(fifo_iff)
);

// Pass the fifo interface to the DUV
FIFO_32_8 DUV(
    .fifo_iff(fifo_iff)
);


initial begin
   // tests.basic_tasks.init();
    //tests.basic_tasks.reset();

    //tests.basic_tasks.reset();

    // Battery tests for FSM
    BT_fsm.init();
    BT_fsm.run_battery_test();

    // Battery tests for

    $stop;
end
    
endmodule