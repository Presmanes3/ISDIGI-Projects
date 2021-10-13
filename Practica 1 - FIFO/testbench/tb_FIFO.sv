module tb_FIFO(
    
);

// ===== INTERFACES ===== //
FIFO_IFF fifo_iff();


// ===== ASSIGNS ===== //


battery_test battery_test(
);

// Pass the fifo interface to the DUV
FIFO_32_8 DUV(
    .fifo_iff(fifo_iff)
);

basic_fifo_tasks basic_tasks(
    .fifo_iff(fifo_iff)
);

initial begin
    //tests.basic_tasks.init();
    //tests.basic_tasks.reset();

    //tests.basic_tasks.reset();

    // Battery tests for FSM
    battery_test.init();
    battery_test.run_battery_test();

    // Battery tests for

    $stop;
end
    
endmodule