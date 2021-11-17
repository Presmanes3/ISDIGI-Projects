module register
#(  parameter size = 8)
(
    input clk,
    input reset,
    input enable,
    input [size - 1 : 0] in,
    input clear,

    output reg [size - 1 : 0] out
);

always_ff @(posedge clk or negedge reset) begin
    if (!reset)         out <= 0;
    else if (!clear)    out <= 0;
    else if (enable)    out <= in;
    else                out <= out;
end


// Added assert property for checking that the register will move the information from input to output in the 
// correct situation
regactivado:assert property (@(posedge clk) disable iff(reset==1'b0 || clear==1'b0) enable |-> s1) else $error("CHEQUEO REGISTRO: el registro no se activa bien");

sequence s1;
    logic [size - 1:0] aux;
    (1, aux = in) ##1 (out == aux);
endsequence


endmodule