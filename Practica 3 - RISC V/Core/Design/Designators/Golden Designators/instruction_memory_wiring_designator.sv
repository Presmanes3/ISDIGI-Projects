module instruction_memory_wiring_designator #(
    parameter memory_size = 1024,
    parameter memory_address_bits = $clog2(memory_size)
)(
    segmented_interface wires
);

    assign wires.instructions_memory_wiring.clk             = 1'b0;
    assign wires.instructions_memory_wiring.write_enable    = 1'b0;
    assign wires.instructions_memory_wiring.read_enable     = 1'b1;
    assign wires.instructions_memory_wiring.address         = 32'h0;
    assign wires.instructions_memory_wiring.input_data      = wires.instruction[memory_address_bits - 1  : 2];
endmodule