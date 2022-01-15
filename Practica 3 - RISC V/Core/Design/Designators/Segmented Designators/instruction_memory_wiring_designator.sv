module instruction_memory_wiring_designator_segmented #(
    parameter memory_size = 1024,
    parameter memory_address_bits = $clog2(memory_size)
)(
    segmented_interface wires
);

    assign wires.instruction_memory_wiring.clk             = 1'b0;
    assign wires.instruction_memory_wiring.write_enable    = 1'b0;
    assign wires.instruction_memory_wiring.read_enable     = 1'b1;
    assign wires.instruction_memory_wiring.address         = wires.pc_wiring.out[memory_address_bits - 1  : 2] ;
    assign wires.instruction_memory_wiring.input_data      = 32'h0;
endmodule