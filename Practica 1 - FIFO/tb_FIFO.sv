module tb_FIFO(
    
);

// Define the fifo interface for wiring easily
FIFO_IFF fifo_iff();

// Pass the fifo interface to the test cases module
test_cases tests(
    .fifo_iff(fifo_iff)
);

// Pass the fifo interface to the test tasks module


// Pass the fifo interface to the DUV
FIFO_32_8 DUV(
    .fifo_iff(fifo_iff)
);


initial begin
    tests.basic_tasks.init();

    @(posedge fifo_iff.CLK);

    tests.run_tests_input_output();
    
    $stop;
end
    
endmodule