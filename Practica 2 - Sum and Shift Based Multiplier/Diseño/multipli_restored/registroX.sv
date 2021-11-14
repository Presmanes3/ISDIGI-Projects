
module registroX (qi, qi_1, CLOCK, RESET, enableX);

parameter tamano = 2;

input [tamano-1:0] qi;
input enableX;

output reg qi_1;

input CLOCK, RESET;

always_ff @(posedge CLOCK, negedge RESET)
begin
	if(!RESET)
		begin
		qi_1 <= 0;
		end
	else
	if(enableX)
		begin
		qi_1<= qi[0];

		end
	else
		qi_1<=qi_1;

end
		
endmodule