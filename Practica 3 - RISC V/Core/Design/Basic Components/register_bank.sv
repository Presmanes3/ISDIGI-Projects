interface register_bank_interface #(
	parameter sintetizable = 1'b0
);
    logic clk;

    logic [4:0] read_register_1_addr;
    logic [4:0] read_register_2_addr;
    logic [4:0] write_register_addr;

    logic [31:0] write_data;
    logic write_enable;

    logic [31:0] read_data_1;
    logic [31:0] read_data_2;
endinterface //interfacename




module register_bank #(
	parameter sintetizable = 1'b0
)(
    register_bank_interface register_bank_wiring
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

always_ff @( posedge register_bank_wiring.clk ) begin 
    if(register_bank_wiring.write_enable)begin
        if(register_bank_wiring.write_register_addr != 5'b00000)begin
            reg_pool[register_bank_wiring.write_register_addr] <= register_bank_wiring.write_data;
        end
    end
end


assign register_bank_wiring.read_data_1 = reg_pool[register_bank_wiring.read_register_1_addr];
assign register_bank_wiring.read_data_2 = reg_pool[register_bank_wiring.read_register_2_addr];
    
endmodule