`include "../../Design/memory.sv"

module memory_tb;

    `timescale 1ps/1ps
    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    logic write_enable;
    logic read_enable;
    logic [9:0] address;
    logic [31:0] input_data;
    logic [31:0] output_data;


    memory memory_inst(
        .clk(clk),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .address(address),
        .input_data(input_data),
        .output_data(output_data)
    );

    initial begin

        inicializar_mem();

        @(negedge clk)

        write();

        @(negedge clk)

        read();
        
        @(negedge clk)

        check();
        
        @(negedge clk)

        simultaneo();

        @(negedge clk)
        

        check2();

        $stop();
    
    end

    task inicializar_mem();
        write_enable = 0;
        read_enable = 0;
        address = 0;
        input_data = 0;
    endtask

    task write();
        write_enable = 1;
        read_enable = 0;
        address = 2;
        input_data = 8;
    endtask

    task read();
        write_enable = 0;
        read_enable = 1;
        address = 2;
    endtask

    task simultaneo();
        write_enable = 1;
        read_enable = 1;
        address = 5;
        input_data = 9;
    endtask

    task check();
        assert (output_data == 8) else   $info("La memoria no ha leido el valor correcto");
    endtask

    task check2();
        assert (output_data == 9) else   $info("La memoria no ha leido el valor correcto");
    endtask



endmodule