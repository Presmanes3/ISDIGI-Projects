module ADDER (CLOCK, RESET, selector, estado, outSHI, inSHI);

parameter tamano = 8;

input CLOCK, RESET;

input [1:0] estado;

parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;


input [tamano:0] selector, outSHI;

output reg [tamano:0] inSHI;

always_comb
begin
	if(!RESET)
		begin
		inSHI <= 0;
		end
	else
		begin
		case(estado)
		S0:	inSHI = outSHI + selector;
		
		S1:	inSHI = outSHI - selector;
		
		S2:	inSHI = outSHI + 2*selector;
		
		S3:	inSHI = outSHI - 2*selector;
		
		
		default: inSHI = outSHI + selector;
		
		endcase

		end


end
endmodule


