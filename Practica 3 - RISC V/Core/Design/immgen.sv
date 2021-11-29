module immgen
#(parameter size = 32)
(
    input   [size - 1 : 0]   inst,
    output  reg [size - 1 : 0]   imm);
always_comb
    case(inst[6:0])
        7'b0000000  : imm = { {21{inst[31]}},    inst[30:20]                                         };
        7'b0000001  : imm = { {21{inst[31]}},    inst[30:25],    inst[11:7]                          };
        7'b0000010  : imm = { {20{inst[31]}},    inst[7],        inst[30:25],    inst[11:8],1'b0     };
        7'b0000011  : imm = { inst[31:12],       12'b0                                               };
        7'b0000100  : imm = { {12{inst[31]}},    inst[19:12],    inst[20],       inst[30:21],    1'b0};

        default: imm = 7'b0000000; 
    endcase
endmodule
