module memory #(
    parameter size = 1024,
    parameter input_file = "../Testing/Programs/Simple/R/ADD.mem",
    parameter charge_file = 1'b0,
    parameter bits = $clog2(size)  // Compute the number of bits needed for a given size
) (
    // Declare inputs
    input                       clk,
    input                       write_enable,
    input                       read_enable,
    input       [bits - 1 : 0]  address,
    input       [31:0]          input_data,

    // Declare outputs
    output reg  [31:0]          output_data
);

// Create the data pool which will contain the information
reg         [31:0]          data_pool [0 : size - 1];

parameter relative_path = "../../Proyecto Questasim/Basic Testing/../../";
// parameter relative_path = "";
parameter file_path = {relative_path, input_file};


initial begin
    if(charge_file)begin
        $display(">>> CHARGING FILE [%s] IN MEMORY", file_path);
        $readmemh(file_path, data_pool );
    end
end

always_ff @( posedge clk ) begin 
    if(write_enable) data_pool[address / 4] = input_data;
end

always_comb begin 
    if(read_enable) output_data = data_pool[address / 4];
end



// TODO add assert property for checking that input and output written and read

endmodule