module contador 
#(parameter size = 8)
(enable, reset, count, clk,clear);

parameter mod = $clog2(size);
parameter increment = 2'b10;

input clk;
input enable;
input clear;
input reset;
output reg [mod:0] count;


always_ff @ (posedge clk or negedge reset)

begin
if(!reset)			count <= 0;
else
	if(!clear)		count <= 0;
	else
		if(enable)	count <= count + increment;	
		else		count <= count;
end

// Added assert property for  checking that the counter will count
cuenta_correcta:assert property (@(negedge clk) disable iff(reset === 1'bx) enable |-> s1 ) else $error("CHEQUEO CONTADOR: el contador no cuenta bien");
sequence s1;
	logic [mod:0] aux;
	(1,aux=count) ##1 (count == aux + 2) ;
endsequence

endmodule