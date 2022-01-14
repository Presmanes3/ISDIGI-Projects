module pc_wiring_designator(
    segmented_interface wires
);

    assign wires.pc_wiring.clk                  = wires.clk;
    assign wires.pc_wiring.in                   = wires.mux_pc_wiring.out;
    assign wires.pc_wiring.pc_write_id_enable   = 1'b1; // TODO link with hazard error detector
    assign wires.pc_wiring.reset                = wires.reset;

endmodule