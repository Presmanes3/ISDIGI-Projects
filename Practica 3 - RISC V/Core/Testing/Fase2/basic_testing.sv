`include "../Design/memory.sv"
`include "../Design/register_bank.sv"

module basic_testing (
    
);
    `timescale 1ps/1ps

    parameter T = 20;

    parameter mem_size = 1024;
    parameter mem_addr_bits = $clog2(mem_size);

    reg clk;
    reg write_enable;
    reg [mem_addr_bits - 1 : 0] address;
    reg [31:0] input_value;
    reg [31:0] output_value;

    memory #(mem_size) duv_mem(
        .clk(clk),
        .write_enable(write_enable),

        .address(address),

        .input_data(input_value),
        .output_data(output_value)
    );

    reg [5 - 1 : 0] read_register_1_addr;
    reg [5 - 1 : 0] read_register_2_addr;
    reg [5 - 1 : 0] write_register_addr;
    reg [31 : 0]    write_data;

    reg [31:0]      read_data_1;
    reg [31:0]      read_data_2;

    register_bank dub_reg_bank(
        .clk(clk),
        .read_register_1_addr(read_register_1_addr),
        .read_register_2_addr(read_register_2_addr),
        .write_register_addr(write_register_addr),

        .write_data(write_data),
        .write_enable(write_enable),

        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

initial begin

    reset();

    //test_memory();

    //#T;

    test_register_bank();

    #T;

    $stop();
    
end

task test_register_bank();
    reset();

    @(negedge clk);

    read_register_1_addr = 5'd15;
    read_register_2_addr = 5'd20;

    write_register_addr = read_register_1_addr;
    write_data = 31'd1000;
    write_enable = 1'b1;

    @(posedge clk);
    #1;

    assert (read_data_1 == write_data) 
    else   $display("[ERROR 1] > read_data_1 == write_data");

    write_register_addr = read_register_2_addr;
    write_data = 31'd2000;
    write_enable = 1'b1;

    @(posedge clk);
    #1;

    assert (read_data_2 == write_data) 
    else   $display("[ERROR 2] > read_data_2 == write_data");

    write_register_addr = read_register_2_addr;
    write_data = 31'd3000;
    write_enable = 1'b0;

    @(posedge clk);
    #1;

    assert (read_data_2 != write_data) 
    else   $display("[ERROR 2] > data written with enable off");

endtask

task test_memory();
    reset();

    @(negedge clk);

    address = 32'd15;
    input_value = 32'd22;

    write_enable = 1'b1;

    @(posedge clk);

    @(negedge clk);

    write_enable = 1'b0;

    #(1);

    assert (input_value == output_value) 
    else   $display("[ERROR 0] > input != output");

    @(negedge clk);

    address = 32'd15;
    input_value = 32'd120;

    write_enable = 1'b0;

    @(posedge clk);

    @(negedge clk);

    write_enable = 1'b0;

    #(1);

    assert (input_value != output_value) 
    else   $display("[ERROR 1] > input == output");
endtask

task reset();
    clk                     = 0;
    write_enable            = 0;
    address                 = 0;

    input_value             = 0;
    output_value            = 0;

    //

    read_register_1_addr    = 0;
    read_register_2_addr    = 0;
    write_register_addr     = 0;
    write_data              = 0;

    read_data_1             = 0;
    read_data_2             = 0;
endtask 

always #(T/2) begin
    clk = ~clk;
end

    
endmodule