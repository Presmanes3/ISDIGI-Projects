module contador (enable, reset, count, clk,clear);

parameter n = 8;
parameter M = $clog2(n);

input clk;
input enable;
input clear;
input reset;
output reg [M:0] count;


always @ (posedge clk, negedge reset)

begin
if(!reset)
	count <= 0;
else
	if(!clear)
		count <= 0;
	else
		if(enable)
			count <= count + 2'b10;
		else
			count <= count;
end
	
endmodule