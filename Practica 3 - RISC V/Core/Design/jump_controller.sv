module jump_controller (
    input branch,
    input [2:0] func_3_bits,
    input zero,
    input [31:0] alu_result,

    output reg select
);



always_comb begin
    select = 1'b0;
    
    if(branch == 1'b1)begin
        case (func_3_bits)
            // BEQ
            3'b000: begin
                if(zero == 1'b1) select = 1'b1;
            end
            // BNE
            3'b001: begin
                if(zero == 1'b0) select = 1'b1;
            end 
            // BLT
            3'b100: begin
                if(alu_result == 32'd1) select = 1'b1;
            end 
            // BGE
            3'b101: begin
                if(alu_result == 32'd0) select = 1'b1;
            end 
            // BLTU
            3'b110: begin
                if(alu_result == 32'd1) select = 1'b1;
            end 
            // BGEU
            3'b111: begin
                if(alu_result == 32'd0) select = 1'b1;
            end 

            default: select = 1'b0;
        endcase
    end
end
endmodule