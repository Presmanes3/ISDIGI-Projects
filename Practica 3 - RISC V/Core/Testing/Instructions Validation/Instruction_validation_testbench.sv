`include "./Instruction_core_validator.sv"

module instruction_validation_testbench ();
    
    `timescale 1ns/100ps

    Instruction_core_validator #(.program_file("ADD/add.mem"),      .expected_mem_value(2))  add_validator  ();
    // Instruction_core_validator #(.program_file("ADDI/addi.mem"),    .expected_mem_value(1))  addi_validator ();
    // Instruction_core_validator #(.program_file("AND/and.mem"),      .expected_mem_value(1))  and_validator  ();
    // Instruction_core_validator #(.program_file("ANDI/andi.mem"),    .expected_mem_value(1))  andi_validator ();
    // Instruction_core_validator #(.program_file("AUIPC/auipc.mem"),  .expected_mem_value(24)) auipc_validator();
    // Instruction_core_validator #(.program_file("BEQ/beq.mem"),      .expected_mem_value(1))  beq_validator  ();
    // Instruction_core_validator #(.program_file("BGE/bge.mem"),      .expected_mem_value(1))  bge_validator  ();
    // Instruction_core_validator #(.program_file("BGEU/bgeu.mem"),    .expected_mem_value(1))  bgeu_validator ();
    // Instruction_core_validator #(.program_file("BLT/blt.mem"),      .expected_mem_value(1))  blt_validator  ();
    // Instruction_core_validator #(.program_file("BLTU/bltu.mem"),    .expected_mem_value(1))  bltu_validator ();
    // Instruction_core_validator #(.program_file("BNE/bne.mem"),      .expected_mem_value(1))  bne_validator  ();
    // Instruction_core_validator #(.program_file("JAL/jal.mem"),      .expected_mem_value(28)) jal_validator  ();
    // Instruction_core_validator #(.program_file("JALR/jalr.mem"),    .expected_mem_value(0))  jalr_validator ();
    // Instruction_core_validator #(.program_file("LUI/lui.mem"),      .expected_mem_value(0))  lui_validator  ();
    // Instruction_core_validator #(.program_file("LW/lw.mem"),        .expected_mem_value(1))  lw_validator   ();
    // Instruction_core_validator #(.program_file("OR/or.mem"),        .expected_mem_value(1))  or_validator   ();
    // Instruction_core_validator #(.program_file("ORI/ori.mem"),      .expected_mem_value(1))  ori_validator  ();
    // Instruction_core_validator #(.program_file("SLL/sll.mem"),      .expected_mem_value(2))  sll_validator  ();
    // Instruction_core_validator #(.program_file("SLLI/slli.mem"),    .expected_mem_value(2))  slli_validator ();
    // Instruction_core_validator #(.program_file("SLT/slt.mem"),      .expected_mem_value(1))  slt_validator  ();
    // Instruction_core_validator #(.program_file("SLTI/slti.mem"),    .expected_mem_value(1))  slti_validator ();
    // Instruction_core_validator #(.program_file("SLTIU/sltiu.mem"),  .expected_mem_value(1))  sltiu_validator();
    // Instruction_core_validator #(.program_file("SLTU/sltu.mem"),    .expected_mem_value(1))  sltu_validator ();
    // Instruction_core_validator #(.program_file("SRA/sra.mem"),      .expected_mem_value(1))  sra_validator  ();
    // Instruction_core_validator #(.program_file("SRAI/srai.mem"),    .expected_mem_value(1))  srai_validator ();
    // Instruction_core_validator #(.program_file("SRL/srl.mem"),      .expected_mem_value(1))  srl_validator  ();
    // Instruction_core_validator #(.program_file("SRLI/srli.mem"),    .expected_mem_value(1))  srli_validator ();
    // Instruction_core_validator #(.program_file("SUB/sub.mem"),      .expected_mem_value(1))  sub_validator  ();
    // Instruction_core_validator #(.program_file("SW/sw.mem"),        .expected_mem_value(1))  sw_validator   ();
    // Instruction_core_validator #(.program_file("XOR/xor.mem"),      .expected_mem_value(1))  xor_validator  ();
    // Instruction_core_validator #(.program_file("XORI/xori.mem"),    .expected_mem_value(1))  xori_validator ();

initial begin
    add_validator.start();
    // addi_validator.start();
    // and_validator.start();
    // andi_validator.start();
    // auipc_validator.start();
    // beq_validator.start();
    // bge_validator.start();
    // bgeu_validator.start();
    // blt_validator.start();
    // bltu_validator.start();
    // bne_validator.start();
    // jal_validator.start();
    // //jalr_validator.start();
    // lui_validator.start();
    // or_validator.start();
    // ori_validator.start();
    // sll_validator.start();
    // slli_validator.start();
    // slt_validator.start();
    // slti_validator.start();
    // sltiu_validator.start();
    // sltu_validator.start();
    // sra_validator.start();
    // srai_validator.start();
    // srl_validator.start();
    // srli_validator.start();
    // sub_validator.start();
    // sw_validator.start();
    // xor_validator.start();
    // xori_validator.start();

    $stop();
end
endmodule