
module registroM (In_multi, Out_multi, CLOCK, RESET,enableM);

parameter tamano = 8;

input  [tamano-1:0] In_multi;

input CLOCK, RESET, enableM;

reg [tamano:0] aux;

output reg [tamano:0] Out_multi;

always_ff @(posedge CLOCK, negedge RESET)
begin
	if (!RESET)
		begin
		Out_multi<= 0;
		end

	else if (enableM)
		begin
		aux[tamano-1:0] <= In_multi[tamano-1:0];
		aux[tamano] <= In_multi[tamano-1];

		Out_multi<= aux;
		end
	else Out_multi<= Out_multi;
end

endmodule