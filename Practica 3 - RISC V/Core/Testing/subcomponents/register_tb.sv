`include "../../Design/register_bank.sv"

module register_tb;

    `timescale 1ps/1ps
    // Clock generator
    reg clk = 0;
    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    logic write_enable;
    logic [4:0] read_register_1_addr;
    logic [4:0] read_register_2_addr;
    logic [4:0] write_register_addr;
    logic [31:0] write_data;
    logic [31:0] read_data_1;
    logic [31:0] read_data_2;


    register_bank register_inst(
        .clk(clk),
        .write_enable(write_enable),
        .read_register_1_addr(read_register_1_addr),
        .read_register_2_addr(read_register_2_addr),
        .write_register_addr(write_register_addr),
        .write_data(write_data),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    initial begin

        inicializar_reg();

        @(negedge clk)

        write1();

        @(negedge clk)

        read();
        
        @(negedge clk)

        check();

        $stop();
    
    end

    task inicializar_reg();
        write_enable = 0;
        read_register_1_addr = 0;
        read_register_2_addr = 0;
        write_register_addr = 0;
        write_data = 0;
    endtask

    task write1();
        write_enable = 1;
        read_register_1_addr = 3;
        read_register_2_addr = 4;
        write_register_addr = 5;
        write_data = 6;
    endtask

    task read();
        write_enable = 0;
        read_register_1_addr = 5;
        read_register_2_addr = 5;
        write_register_addr = 0;
        write_data = 0;
    endtask


    task check();
        assert (read_data_1 == 6) else   $info("El registro no ha leído el valor correcto");
        assert (read_data_2 == 6) else   $info("El registro no ha leído el valor correcto");
    endtask

endmodule