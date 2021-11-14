module ADDER (CLOCK, RESET, input_from_reg_M, operational_mode, input_from_reg_HI, out);

parameter tamano = 8;

input CLOCK, RESET;

input [1:0] operational_mode;

parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;


input [tamano:0] input_from_reg_M, input_from_reg_HI;

output reg [tamano:0] out;

always_comb
begin
	if(!RESET)
		begin
		out <= 0;
		end
	else
		begin
		case(operational_mode)
			S0:	out = input_from_reg_HI + input_from_reg_M;
			
			S1:	out = input_from_reg_HI - input_from_reg_M;
			
			S2:	out = input_from_reg_HI + 2*input_from_reg_M;
			
			S3:	out = input_from_reg_HI - 2*input_from_reg_M;
		default: out = input_from_reg_HI + input_from_reg_M;
		
		endcase

		end
end
endmodule


