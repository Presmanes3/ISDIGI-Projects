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

endmodule