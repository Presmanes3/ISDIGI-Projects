module hazard_detection_unit(
    output reg pc_write_id,
    output reg hazard_mux,
    output flush,
    output flush_pc,
    output flush_adder,

    input force_jump_wb,
    input branch_mux_mem,

    input mem_read_ex,
    input rd_addr_ex,
    input rs1_addr_id,
    input rs2_addr_id,
    input force_jump_id,
    input force_jump_ex,
    input force_jump_mem
);

assign flush = (force_jump_ex || force_jump_mem || force_jump_wb);
assign flush_pc = (force_jump_id || force_jump_ex);
assign flush_adder = (force_jump_id || force_jump_ex || force_jump_mem);

always_comb begin
    if((mem_read_ex == 1) && (rd_addr_ex == rs1_addr_id) || (rd_addr_ex == rs2_addr_id) && !branch_mux_mem) begin
        pc_write_id = 0;
        hazard_mux = 1;
    end else begin
        pc_write_id = 1;
        hazard_mux = 0;
    end
end
endmodule