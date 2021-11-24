module memory #(
    parameter size = 1024
) (
    clk,
    write_enable,
    read_enable,

    address,
    
    input_data,
    output_data
);
// Compute the number of bits needed for a given size
parameter bits = $clog2(size);

// Create the data pool which will contain the information
reg         [31:0]          data_pool [size - 1 : 0];

// Declare inputs
input                       clk;
input                       write_enable;
input                       read_enable;
input       [bits - 1 : 0]  address;
input       [31:0]          input_data;

// Declare outputs
output reg  [31:0]          output_data;

always_ff @( posedge clk ) begin 
    if(write_enable) data_pool[address] <= input_data;
end

always_comb begin 
    if(read_enable) output_data <= data_pool[address];
end

// TODO add assert property for checking that input and output written and read

endmodule