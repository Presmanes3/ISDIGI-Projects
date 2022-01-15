module adder_pc_wiring_designator_segmented(

segmented_interface wires

);

assign wires.adder_pc_wiring.input1 =   wires.pc_wiring.out;
assign wires.adder_pc_wiring.input2 =   4;

endmodule 
