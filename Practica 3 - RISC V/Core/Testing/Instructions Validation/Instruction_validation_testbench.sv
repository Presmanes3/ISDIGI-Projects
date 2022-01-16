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

    Instruction_core_validator #(.program_file("ADD/add.mem"),      .expected_mem_value(0))  add_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("ADDI/addi.mem"),    .expected_mem_value(0))  addi_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("AND/and.mem"),      .expected_mem_value(0))  and_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("ANDI/andi.mem"),    .expected_mem_value(0))  andi_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("AUIPC/auipc.mem"),  .expected_mem_value(0))  auipc_validator(.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("BEQ/beq.mem"),      .expected_mem_value(0))  beq_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("BGE/bge.mem"),      .expected_mem_value(0))  bge_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("BGEU/bgeu.mem"),    .expected_mem_value(0))  bgeu_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("BLT/blt.mem"),      .expected_mem_value(0))  blt_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("BLTU/bltu.mem"),    .expected_mem_value(0))  bltu_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("BNE/bne.mem"),      .expected_mem_value(0))  bne_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("JAL/jal.mem"),      .expected_mem_value(0))  jal_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("JALR/jalr.mem"),    .expected_mem_value(0))  jalr_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("LUI/lui.mem"),      .expected_mem_value(0))  lui_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("LW/lw.mem"),        .expected_mem_value(0))  lw_validator   (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("OR/or.mem"),        .expected_mem_value(0))  or_validator   (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("ORI/ori.mem"),      .expected_mem_value(0))  ori_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SLL/sll.mem"),      .expected_mem_value(0))  sll_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SLLI/slli.mem"),    .expected_mem_value(0))  slli_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SLT/slt.mem"),      .expected_mem_value(0))  slt_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SLTI/slti.mem"),    .expected_mem_value(0))  slti_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SLTIU/sltiu.mem"),  .expected_mem_value(0))  sltiu_validator(.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SLTU/sltu.mem"),    .expected_mem_value(0))  sltu_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SRA/sra.mem"),      .expected_mem_value(0))  sra_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SRAI/srai.mem"),    .expected_mem_value(0))  srai_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SRL/srl.mem"),      .expected_mem_value(0))  srl_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SRLI/srli.mem"),    .expected_mem_value(0))  srli_validator (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SUB/sub.mem"),      .expected_mem_value(0))  sub_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("SW/sw.mem"),        .expected_mem_value(0))  sw_validator   (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("XOR/xor.mem"),      .expected_mem_value(0))  xor_validator  (.clk(clk), .reset(reset));
    // Instruction_core_validator #(.program_file("XORI/xori.mem"),    .expected_mem_value(0))  xori_validator (.clk(clk), .reset(reset));

    initial begin
        clk     = 1'b0;

        reset_();

        #(T * 100);

        $stop();
    end


    task reset_();
        reset   = 1'b0;

        @(posedge clk);

        reset = 1'b1;

        @(posedge clk);
    endtask


endmodule