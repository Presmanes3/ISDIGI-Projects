`include "./Instruction_core_validator.sv"

module instruction_validation_testbench ();
    `timescale 1ns/100ps

    localparam T=20;

    reg clk;
    reg reset;
    //-------------------------------------------------------------------------------

    // Definimos el reloj -----------------------------------------------------------
    always begin
        #(T/2)
        clk = ~clk;
    end

    Instruction_core_validator #("ADD/add.mem")     add_validator(.*);
    Instruction_core_validator #("ADDI/addi.mem")   addi_validator(.*);
    Instruction_core_validator #("AND/and.mem")     and_validator(.*);
    Instruction_core_validator #("ANDI/andi.mem")   andi_validator(.*);
    Instruction_core_validator #("AUIPC/auipc.mem") auipc_validator(.*);
    Instruction_core_validator #("BEQ/beq.mem")     beq_validator(.*);
    Instruction_core_validator #("BGE/bge.mem")     bge_validator(.*);
    Instruction_core_validator #("BGEU/bgeu.mem")   bgeu_validator(.*);
    Instruction_core_validator #("BLT/blt.mem")     blt_validator(.*);
    Instruction_core_validator #("BLTU/bltu.mem")   bltu_validator(.*);
    Instruction_core_validator #("BNE/bne.mem")     bne_validator(.*);
    Instruction_core_validator #("JAL/jal.mem")     jal_validator(.*);
    Instruction_core_validator #("JALR/jalr.mem")   jalr_validator(.*);
    Instruction_core_validator #("LUI/lui.mem")     lui_validator(.*);
    Instruction_core_validator #("LW/lw.mem")       lw_validator(.*);
    Instruction_core_validator #("OR/or.mem")       or_validator(.*);
    Instruction_core_validator #("ORI/ori.mem")     ori_validator(.*);
    Instruction_core_validator #("SLL/sll.mem")     sll_validator(.*);
    Instruction_core_validator #("SLLI/slli.mem")   slli_validator(.*);
    Instruction_core_validator #("SLT/slt.mem")     slt_validator(.*);
    Instruction_core_validator #("SLTI/slti.mem")   slti_validator(.*);
    Instruction_core_validator #("SLTIU/sltiu.mem") sltiu_validator(.*);
    Instruction_core_validator #("SLTU/sltu.mem")   sltu_validator(.*);
    Instruction_core_validator #("SRA/sra.mem")     sra_validator(.*);
    Instruction_core_validator #("SRAI/srai.mem")   srai_validator(.*);
    Instruction_core_validator #("SRL/srl.mem")     srl_validator(.*);
    Instruction_core_validator #("SRLI/srli.mem")   srli_validator(.*);
    Instruction_core_validator #("SUB/sub.mem")     sub_validator(.*);
    Instruction_core_validator #("SW/sw.mem")       sw_validator(.*);
    Instruction_core_validator #("XOR/xor.mem")     xor_validator(.*);
    Instruction_core_validator #("XORI/xori.mem")   xori_validator(.*);



    initial begin
        clk     = 1'b0;
        reset   = 1'b1;
    end


endmodule