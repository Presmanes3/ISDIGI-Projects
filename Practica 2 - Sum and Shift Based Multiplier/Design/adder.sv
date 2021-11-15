module adder 
#(parameter size = 9)
(
	input clk, 
	input reset,
	input enable, 
	input [size - 1 : 0] input_from_reg_M,
	input [size - 1 : 0] input_from_reg_HI,

	input [1 : 0] operational_mode, 
	
	output reg [size - 1 : 0] out
);

parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;


always_comb
begin
	if(!reset) 	out <= 0;
	else begin
		if(enable)begin
			case(operational_mode)
				S0:	out = input_from_reg_HI + input_from_reg_M;
				
				S1:	out = input_from_reg_HI - input_from_reg_M;
				
				S2:	out = input_from_reg_HI + 2*input_from_reg_M;
				
				S3:	out = input_from_reg_HI - 2*input_from_reg_M;
			default: out = input_from_reg_HI + input_from_reg_M;
			endcase
		end
	end
end
endmodule


