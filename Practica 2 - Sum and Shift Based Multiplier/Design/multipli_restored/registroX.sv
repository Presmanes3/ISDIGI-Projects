
module registroX (qi, q1_minus_1, CLOCK, RESET, enable);

parameter tamano = 2;

input [tamano-1:0] qi;
input enable;

output reg q1_minus_1;

input CLOCK, RESET;

always_ff @(posedge CLOCK, negedge RESET)
begin
	if(!RESET)
		begin
		q1_minus_1 <= 0;
		end
	else
	if(enable)
		begin
		q1_minus_1 <= qi[0];
		end
	else
		q1_minus_1<=q1_minus_1;
end

endmodule