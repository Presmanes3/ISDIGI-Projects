interface data_forwarding_interface;
    logic  [1:0] forward1;
    logic  [1:0] forward2;

    logic  [4:0] rs1_addr_ex;
    logic  [4:0] rs2_addr_ex;

    logic  reg_write_mem;
    logic  reg_write_wb;
    logic  [4:0] rd_addr_mem;
    logic  [4:0] rd_addr_wb;
endinterface //interfacename

module data_forwarding(
    data_forwarding_interface wiring
);

/**
Forward_x == 00 > El operando x de la ALU proviene del banco de registros
Forward_x == 10 > El operando x de la ALU proviene de un calculo anterior desde la etapa MEM
Forward_x == 01 > El operando x de la ALU proviene de un calculo anterior o la memoria de datos desde la etapa WB
loquesea
*/

always_comb begin 
    if((wiring.reg_write_mem == 1) && (wiring.rd_addr_mem != 0) && (wiring.rs1_addr_ex == wiring.rd_addr_mem)) wiring.forward1 = 2'b10;
    else if ((wiring.reg_write_wb == 1) && (wiring.rd_addr_wb != 0) && (wiring.rs1_addr_ex == wiring.rd_addr_wb)) wiring.forward1 = 2'b01;
    else wiring.forward1 = 2'b00;
end

always_comb begin
    if((wiring.reg_write_mem == 1) && (wiring.rd_addr_mem != 0) && (wiring.rs2_addr_ex == wiring.rd_addr_mem)) wiring.forward2 = 2'b10;
    else if ((wiring.reg_write_wb == 1) && (wiring.rd_addr_wb != 0) && (wiring.rs2_addr_ex == wiring.rd_addr_wb)) wiring.forward2 = 2'b01;
    else wiring.forward2 = 2'b00;
end

endmodule