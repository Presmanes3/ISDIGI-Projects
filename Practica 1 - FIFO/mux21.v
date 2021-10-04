module mux21(
				IN_0,
				IN_1,
				CLK,
				
				OUT,
				
				SELECT
		
				);
				
parameter size = 8;

input [size - 1 : 0] IN_0;	
input [size - 1 : 0] IN_1;	
input CLK;
input SELECT;
				
output reg [size - 1 : 0] OUT;

always @(posedge CLK) begin
	OUT <= (SELECT == 1) ? IN_1 : IN_0;
end
				
endmodule