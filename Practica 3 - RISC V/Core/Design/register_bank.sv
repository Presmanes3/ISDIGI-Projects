module register_bank (
    input clk,
    input [4:0] read_register_1_addr,
    input [4:0] read_register_2_addr,
    input [4:0] write_register_addr,

    input [31:0] write_data,
    input write_enable,

    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2
);

reg [31:0] reg_pool [31:0];

always_ff @( posedge clk ) begin 
    reg_pool[0] = 32'd0;
    
    if(write_enable)begin
        if(write_register_addr != 5'b00000)begin
            reg_pool[write_register_addr] <= write_data;
        end
    end
end

always_comb begin 
    read_data_1 = reg_pool[read_register_1_addr];
    read_data_2 = reg_pool[read_register_2_addr];
end


// TODO add assert property for writting
// TODO add assert property for reading
    
endmodule