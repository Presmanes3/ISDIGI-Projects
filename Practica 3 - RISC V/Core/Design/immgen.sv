module imm_gen
#(parameter size = 32)
(
    input   [size - 1 : 0]   instruction,
    output  reg [size - 1 : 0]   out
);

reg [6:0] opcode;

reg [3:0] alu_option;

always_comb begin
    opcode = instruction[6:0];
    alu_option = {opcode[6:4], opcode[2]};

    case(alu_option)
        4'b0010: out = { {21{instruction[31]}},    instruction[30:20]                                         };
        //7'b0000001  : out = { {21{instruction[31]}},    instruction[30:25],    instruction[11:7]                          };
        //7'b0000010  : out = { {20{instruction[31]}},    instruction[7],        instruction[30:25],    instruction[11:8],     1'b0};
        //7'b0000011  : out = { instruction[31:12],       12'b0                                               };
        //7'b0000100  : out = { {12{instruction[31]}},    instruction[19:12],    instruction[20],       instruction[30:21],    1'b0};
        default: out = 4'b0000; 
    endcase
end
endmodule
