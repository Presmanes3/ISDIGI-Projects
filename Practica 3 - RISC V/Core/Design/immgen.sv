module imm_gen
#(parameter size = 32)
(
    input   [size - 1 : 0]   instruction,
    output  reg [size - 1 : 0]   out
);
reg [19:0] sign_extention;

wire [6:0]  opcode;
wire [3:0]  alu_option;


assign opcode       = instruction[6:0];
assign alu_option   = {opcode[6:4], opcode[2]};

always_comb begin
    sign_extention  = 0;

    case(alu_option)
        // Type I
        4'b0010: begin
            sign_extention = {20{instruction[31]}};

            out[31:12]  = sign_extention; 
            out[11:0]   = instruction[31:20];
        end 
        // Type S 
        4'b1000: begin 
            sign_extention = {20{instruction[31]}};

            out[31:12]  = sign_extention;
            out[11:5]   = instruction[31:25];
            out[4:0]    = instruction[11:7];
        end
        // Type SB
        4'b1100: begin 
            
            sign_extention = {20{instruction[31]}};

            out[31:12]  = sign_extention;
            out[11]     = instruction[7];
            out[10:5]   = instruction[30:25];
            out[4:1]    = instruction[11:8];
            out[0]      = 1'b0;
        end

    default: out = 0; 
    endcase
end
endmodule
