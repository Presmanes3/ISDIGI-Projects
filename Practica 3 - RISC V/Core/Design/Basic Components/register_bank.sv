module register_bank #(
	parameter sintetizable = 1'b0
)(
    input clk,
	 input charge_file,
    input [4:0] read_register_1_addr,
    input [4:0] read_register_2_addr,
    input [4:0] write_register_addr,

    input [31:0] write_data,
    input write_enable,

    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2
);

reg [31:0] reg_pool [0 : 31];

parameter relative_path = "../../Proyecto Questasim/Basic Testing/../../";
parameter input_file = "Core/Design/Basic Components/register_bank_init.mem";

// parameter relative_path = "";
parameter file_path = {relative_path, input_file};

initial begin
if(!sintetizable) begin
    $display(">>> CHARGING FILE [%s] IN REGISTER BANK", file_path);
    $readmemh(file_path, reg_pool );
	end
end

always_ff @( posedge clk ) begin 
    if(write_enable)begin
        if(write_register_addr != 5'b00000)begin
            reg_pool[write_register_addr] <= write_data;
        end
    end
end


assign read_data_1 = reg_pool[read_register_1_addr];
assign read_data_2 = reg_pool[read_register_2_addr];


// TODO add assert property for writting
// TODO add assert property for reading
    
endmodule