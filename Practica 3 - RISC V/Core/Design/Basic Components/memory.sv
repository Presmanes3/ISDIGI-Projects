interface memory_interface #(
    parameter size = 1024,
    parameter bits = $clog2(size)  // Compute the number of bits needed for a given size
);
    logic   clk;
    logic   write_enable;
    logic   read_enable;
    logic   [bits - 1 : 0]  address;
    logic   [31:0]          input_data;

    logic   [31:0]          output_data;
endinterface //memory_interface()


module memory #(
	parameter sintetizable = 1'b0,
    parameter size = 1024,
    parameter input_file = "../Testing/Programs/Simple/R/ADD.mem",
    parameter charge_file = 1'b0,
    parameter bits = $clog2(size)  // Compute the number of bits needed for a given size
) (
    memory_interface memory_wiring
);

// Create the data pool which will contain the information
reg         [31:0]          data_pool [0 : size - 1];

parameter relative_path = "../../Proyecto Questasim/Basic Testing/../../";
// parameter relative_path = "";
parameter file_path = {relative_path, input_file};


initial begin
    if(charge_file && !sintetizable)begin
        $display(">>> CHARGING FILE [%s] IN MEMORY", file_path);
        $readmemh(file_path, data_pool );
    end
end

always_ff @( posedge memory_wiring.clk ) begin 
    if(memory_wiring.write_enable) data_pool[memory_wiring.address] = memory_wiring.input_data;
end

always_comb begin 
    memory_wiring.output_data = 0;
    if(memory_wiring.read_enable) memory_wiring.output_data = data_pool[memory_wiring.address];
end



// TODO add assert property for checking that logic and output written and read

endmodule