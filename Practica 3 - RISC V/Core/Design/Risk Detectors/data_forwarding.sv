module data_forwarding(
    output reg [1:0] forward1,
    output reg [1:0] forward2,

    input [4:0] rs1_addr_ex,
    input [4:0] rs2_addr_ex,

    input reg_write_mem,
    input reg_write_wb,
    input [4:0] rd_addr_mem,
    input [4:0] rd_addr_wb
);

/**
Forward_x == 00 > El operando x de la ALU proviene del banco de registros
Forward_x == 10 > El operando x de la ALU proviene de un calculo anterior desde la etapa MEM
Forward_x == 01 > El operando x de la ALU proviene de un calculo anterior o la memoria de datos desde la etapa WB
loquesea
*/

always_comb begin 
    if((reg_write_mem == 1) && (rd_addr_mem != 0) && (rs1_addr_ex == rd_addr_mem)) forward1 = 2'b10;
    else if ((reg_write_wb == 1) && (rd_addr_wb != 0) && (rs1_addr_ex == rd_addr_wb)) forward1 = 2'b01;
    else forward1 = 2'b00;
end

always_comb
    if((reg_write_mem == 1) && (rd_addr_mem != 0) && (rs2_addr_ex == rd_addr_mem)) forward2 = 2'b10;
    else if ((reg_write_wb == 1) && (rd_addr_wb != 0) && (rs2_addr_ex == rd_addr_wb)) forward2 = 2'b01;
    else forward2 = 2'b00;
end

endmodule