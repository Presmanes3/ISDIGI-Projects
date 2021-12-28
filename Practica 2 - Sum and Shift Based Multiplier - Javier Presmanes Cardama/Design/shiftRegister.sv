module shiftRegister
#(parameter size = 8)
(
    input clk,
    input reset,
    input shift_enable,
    input load_enable,
    input clear,
    input [size - 1 : 0] parallel_in,
    input [1 : 0] serial_in,

    output reg [size - 1 : 0] parallel_out,
    output  [1 : 0] serial_out
);

always_ff @(posedge clk or negedge reset)begin
    if(!reset)              parallel_out <= 0;
    else if (!clear)        parallel_out <= 0;
    else if (load_enable)   parallel_out <= parallel_in;    // Load from parallel input
    else if (shift_enable)  parallel_out <= {serial_in, parallel_out[size - 1 : 2]};    // Shift 2 places
end

    assign serial_out = parallel_out[1:0];

endmodule