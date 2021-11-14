
module registroM (in_val, out_val, CLOCK, RESET, enable);

parameter tamano = 8;

input  [tamano-1:0] in_val;

input CLOCK, RESET, enable;

reg [tamano:0] aux;

output reg [tamano:0] out_val;

always_ff @(posedge CLOCK, negedge RESET)
begin
	if (!RESET)
		begin
			out_val<= 0;
		end

	else if (enable)
		begin
		aux[tamano-1:0] <= in_val[tamano-1:0];
		aux[tamano] <= in_val[tamano-1];

		out_val<= aux;
		end
	else out_val<= out_val;
end

endmodule