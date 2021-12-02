module imm_gen
#(parameter size = 32)
(
    input   [size - 1 : 0]   instruction,
    output  reg [size - 1 : 0]   out
);

reg [6:0] opcode;
reg sign_extention;

reg [3:0] alu_option;

always_comb begin
    opcode = instruction[6:0];
    alu_option = {opcode[6:4], opcode[2]};

    case(alu_option)
        // Type I
        4'b0010: begin
            sign_extention = {20{instruction[31]}};

            out[31:12]  = sign_extention; 
            out[11:0]   = instruction[31:20];
        end 
        // Type S 
        4'b1100: begin 
            sign_extention = {20{instruction[31]}};

            out[31:12]  = sign_extention;
            out[11:5]   = instruction[31:25];
            out[4:0]    = instruction[11:7];
        end
        // Type SB
        4'b1100: begin 
            
            sign_extention = {19{instruction[31]}};

            out[31:13]  = sign_extention;
            out[12]     = instruction[31];
            out[11]     = instruction[7];
            out[10:5]   = instruction[30:25];
            out[4:1]    = instruction[11:8];
            out[0]      = 0;

        end

    default: out = 0; 
    endcase
end
endmodule
