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
    reg read_enable;
    reg [mem_addr_bits - 1 : 0] address;
    reg [31:0] input_value;
    reg [31:0] output_value;

    memory #(mem_size) duv_mem(
        .clk(clk),
        .write_enable(write_enable),
        .read_enable(read_enable),

        .address(address),

        .input_data(input_value),
        .output_data(output_value)
    );

initial begin

    reset();

    test_memory();

    #T;
    $stop();
    
end

task test_memory();
    reset();

    @(negedge clk);

    address = 32'd15;
    input_value = 32'd22;

    write_enable = 1'b1;

    @(posedge clk);

    @(negedge clk);

    write_enable = 1'b0;
    read_enable = 1'b1;

    #(1);

    assert (input_value == output_value) 
    else   $display("[ERROR 0] > input != output");

    read_enable = 1'b0;

    @(negedge clk);

    address = 32'd15;
    input_value = 32'd120;

    write_enable = 1'b0;

    @(posedge clk);

    @(negedge clk);

    write_enable = 1'b0;
    read_enable = 1'b1;

    #(1);

    assert (input_value != output_value) 
    else   $display("[ERROR 1] > input == output");
    

endtask

task reset();
    clk = 0;
    write_enable = 0;
    read_enable = 0;
    address = {mem_addr_bits{1'b0}};

    input_value = {31{1'b0}};
    output_value = {31{1'b0}};
endtask //automatic

always #(T/2) begin
    clk = ~clk;
end

    
endmodule