interface hazar_detection_unit_interface;
    logic pc_write_id;
    logic hazard_mux;
    logic flush;
    logic flush_pc;
    logic flush_adder;

    logic force_jump_wb;
    logic branch_mux_mem;

    logic mem_read_ex;
    logic rd_addr_ex;
    logic rs1_addr_id;
    logic rs2_addr_id;
    logic force_jump_id;
    logic force_jump_ex;
    logic force_jump_mem;
endinterface //hazar_detection_unit_interface



module hazard_detection_unit(
    hazard_detection_unit_interface wiring
);

assign wiring.flush = (wiring.force_jump_ex || wiring.force_jump_mem || wiring.force_jump_wb);
assign wiring.flush_pc = (wiring.force_jump_id || wiring.force_jump_ex);
assign wiring.flush_adder = (wiring.force_jump_id || wiring.force_jump_ex || wiring.force_jump_mem);

always_comb begin
    if((wiring.mem_read_ex == 1) && (wiring.rd_addr_ex == wiring.rs1_addr_id) || (wiring.rd_addr_ex == wiring.rs2_addr_id) && !wiring.branch_mux_mem) begin
        wiring.pc_write_id = 0;
        wiring.hazard_mux = 1;
    end else begin
        wiring.pc_write_id = 1;
        wiring.hazard_mux = 0;
    end
end
endmodule