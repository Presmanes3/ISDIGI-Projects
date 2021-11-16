module contador (enable, reset, count, clk,clear);

parameter n = 8;
parameter M = $clog2(n);

input clk;
input enable;
input clear;
input reset;
output reg [M:0] count;


always_ff @ (posedge clk or negedge reset)

begin
if(!reset)			count <= 0;
else
	if(!clear)		count <= 0;
	else
		if(enable)	count <= count + 2'b10;	// Add in steps of 2
		else		count <= count;
end


cuenta_correcta:assert property (@(negedge clk) disable iff(reset === 1'bx || count==size-1) enable |-> s1) else $error("CHEQUEO CONTADOR: el contador no cuenta bien");

	
sequence s1;
	logic [modulo-1:0] aux;
	(1,aux=count) ##1 (count == aux+1);
endsequence

	
	
endmodule