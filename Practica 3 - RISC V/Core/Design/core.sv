`include "memory.sv"
`include "register_bank.sv"

/**
    @brief Top level entity for the RISC-V processor
*/
module core ();
parameter size =32;
wire [size-1:0] instruction,mux_out_1,mux_out_2,mux_out_pc,operation_result,pc_out,mem_output_data,read_data_1,read_data_2,imm;
wire Zero
wire [3:0] operation


ADDER ADDER_SUM(               //Adder cuya output es la entrada 1 del multiplexor conectado a PC
            .input1(imm_gen),
            .input2(pc_out),
            .out(suma_adder_sum));

ADDER ADDER_MUX(             //Adder cuya ouput es la entrada 0 del multiplexor conectado a PC
            .input1(pc_out),
            .input2(4),
            .out(suma_adder_mux));

ALU     ALU(                       //ALU, sin más 
            .input1(mux_out_1),
            .input2(mux_out_2),
            .operation(ALU_control),
            .operation_result(operation_result),
            .Zero(Zero));

data_memory    data_memory(         //Memoria de datos
                .clk(clk),
                .write_enable(MemWrite),
                .read_enable(MemRead),
                .address(operation_result),
                .input_data(read_data_2),
                .output_data(mem_output_data));

mux_3_input       mux_alu1(      //multiplexor con el que definimos la primera entrada de la ALU
                .input0(pc),
                .input1(32'd0),
                .input2(read_data_1),
                .control(AuipcLui),
                .output(mux_out_1));

mux_2_input      mux_alu1(           //multiplexor con el que definimos la segunda entrada de la ALU
                .input1(read_data_2),
                .input2(imm),
                .control(ALUSrc),
                .output(mux_out_2));

mux_2_input       mux_mem(          //multiplexor a la salida de la memoria de datos
                .input1(mem_output_data),
                .input2(operation_result),
                .control(MemtoReg),
                .output(mux_out_3));

mux_2_input      mux_pc(             //multiplexor cuya salida está conectada a PC
                .input1(suma_adder_mux),
                .input2(suma_adder_sum),
                .control(and_out),
                .output(mux_out_pc));

register_bank   register_bank(
                .clk(clk),
                .read_register_1_addr(instruction[19:15]),
                .read_register_2_addr(instruction[24:20]),
                .write_register_addr(instruction[11:7]),
                .write_data(mux_out_3),
                .write_enable(RegWrite),
                .read_data_1(read_data_1),
                .read_data_2(read_data_2));

imm_gen         imm_gen(
                .inst(instruction[31:0]),
                .imm(imm));

instruction_memory   instruction_memory(
                        .read_address(pc_out),
                        .instruction(instruction));
            
PC                    PC(
                        .input(mux_out_pc)
                        .output(pc_out)
)

control                control_path(
                        .input(),
                        .branch(),
                        .MemRead(),
                        .MemtoReg(),
                        .ALUop(),
                        .MemWrite(),
                        .ALUsrc(),
                        .RegWrite(),
                        .AuipcLui();

)

// Instanciate the control module





endmodule
