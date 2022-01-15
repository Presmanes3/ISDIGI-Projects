onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/cores/fibo_core/clk
add wave -noupdate /testbench/cores/fibo_core/reset
add wave -noupdate -group {ADDER SUM } /testbench/cores/fibo_core/golden_core_wires/adder_sum_wiring/input1
add wave -noupdate -group {ADDER SUM } /testbench/cores/fibo_core/golden_core_wires/adder_sum_wiring/input2
add wave -noupdate -group {ADDER SUM } /testbench/cores/fibo_core/golden_core_wires/adder_sum_wiring/out
add wave -noupdate -group {ADDER PC} /testbench/cores/fibo_core/golden_core_wires/adder_pc_wiring/input1
add wave -noupdate -group {ADDER PC} /testbench/cores/fibo_core/golden_core_wires/adder_pc_wiring/input2
add wave -noupdate -group {ADDER PC} /testbench/cores/fibo_core/golden_core_wires/adder_pc_wiring/out
add wave -noupdate -group {MUX PC} /testbench/cores/fibo_core/golden_core_wires/mux_pc_wiring/input1
add wave -noupdate -group {MUX PC} /testbench/cores/fibo_core/golden_core_wires/mux_pc_wiring/input2
add wave -noupdate -group {MUX PC} /testbench/cores/fibo_core/golden_core_wires/mux_pc_wiring/out
add wave -noupdate -group {MUX PC} /testbench/cores/fibo_core/golden_core_wires/mux_pc_wiring/control
add wave -noupdate -group {DATA MEMORY} /testbench/cores/fibo_core/golden_core_wires/data_memory_wiring/clk
add wave -noupdate -group {DATA MEMORY} /testbench/cores/fibo_core/golden_core_wires/data_memory_wiring/write_enable
add wave -noupdate -group {DATA MEMORY} /testbench/cores/fibo_core/golden_core_wires/data_memory_wiring/read_enable
add wave -noupdate -group {DATA MEMORY} /testbench/cores/fibo_core/golden_core_wires/data_memory_wiring/address
add wave -noupdate -group {DATA MEMORY} /testbench/cores/fibo_core/golden_core_wires/data_memory_wiring/input_data
add wave -noupdate -group {DATA MEMORY} /testbench/cores/fibo_core/golden_core_wires/data_memory_wiring/output_data
add wave -noupdate -group {JUMP CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/jump_controller_wiring/branch
add wave -noupdate -group {JUMP CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/jump_controller_wiring/func_3_bits
add wave -noupdate -group {JUMP CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/jump_controller_wiring/zero
add wave -noupdate -group {JUMP CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/jump_controller_wiring/alu_result
add wave -noupdate -group {JUMP CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/jump_controller_wiring/select
add wave -noupdate -group {PC } /testbench/cores/fibo_core/golden_core_wires/pc_wiring/in
add wave -noupdate -group {PC } /testbench/cores/fibo_core/golden_core_wires/pc_wiring/out
add wave -noupdate -group {PC } /testbench/cores/fibo_core/golden_core_wires/pc_wiring/pc_write_id_enable
add wave -noupdate -group {PC } /testbench/cores/fibo_core/golden_core_wires/pc_wiring/clk
add wave -noupdate -group {PC } /testbench/cores/fibo_core/golden_core_wires/pc_wiring/reset
add wave -noupdate -group {INSTRUCTION MEMORY} /testbench/cores/fibo_core/golden_core_wires/instruction_memory_wiring/clk
add wave -noupdate -group {INSTRUCTION MEMORY} /testbench/cores/fibo_core/golden_core_wires/instruction_memory_wiring/write_enable
add wave -noupdate -group {INSTRUCTION MEMORY} /testbench/cores/fibo_core/golden_core_wires/instruction_memory_wiring/read_enable
add wave -noupdate -group {INSTRUCTION MEMORY} /testbench/cores/fibo_core/golden_core_wires/instruction_memory_wiring/address
add wave -noupdate -group {INSTRUCTION MEMORY} /testbench/cores/fibo_core/golden_core_wires/instruction_memory_wiring/input_data
add wave -noupdate -group {INSTRUCTION MEMORY} /testbench/cores/fibo_core/golden_core_wires/instruction_memory_wiring/output_data
add wave -noupdate -group {MUX ALU 1} /testbench/cores/fibo_core/golden_core_wires/mux_alu1_wiring/input0
add wave -noupdate -group {MUX ALU 1} /testbench/cores/fibo_core/golden_core_wires/mux_alu1_wiring/input1
add wave -noupdate -group {MUX ALU 1} /testbench/cores/fibo_core/golden_core_wires/mux_alu1_wiring/input2
add wave -noupdate -group {MUX ALU 1} /testbench/cores/fibo_core/golden_core_wires/mux_alu1_wiring/out
add wave -noupdate -group {MUX ALU 1} /testbench/cores/fibo_core/golden_core_wires/mux_alu1_wiring/control
add wave -noupdate -group {MUX ALU 2} /testbench/cores/fibo_core/golden_core_wires/mux_alu2_wiring/input1
add wave -noupdate -group {MUX ALU 2} /testbench/cores/fibo_core/golden_core_wires/mux_alu2_wiring/input2
add wave -noupdate -group {MUX ALU 2} /testbench/cores/fibo_core/golden_core_wires/mux_alu2_wiring/out
add wave -noupdate -group {MUX ALU 2} /testbench/cores/fibo_core/golden_core_wires/mux_alu2_wiring/control
add wave -noupdate -group {MUX MEM} /testbench/cores/fibo_core/golden_core_wires/mux_mem_wiring/input1
add wave -noupdate -group {MUX MEM} /testbench/cores/fibo_core/golden_core_wires/mux_mem_wiring/input2
add wave -noupdate -group {MUX MEM} /testbench/cores/fibo_core/golden_core_wires/mux_mem_wiring/out
add wave -noupdate -group {MUX MEM} /testbench/cores/fibo_core/golden_core_wires/mux_mem_wiring/control
add wave -noupdate -group {IMMEDIATE GEN} /testbench/cores/fibo_core/golden_core_wires/imm_gen_wiring/instruction
add wave -noupdate -group {IMMEDIATE GEN} /testbench/cores/fibo_core/golden_core_wires/imm_gen_wiring/out
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/clk
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/read_register_1_addr
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/read_register_2_addr
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/write_register_addr
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/write_data
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/write_enable
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/read_data_1
add wave -noupdate -group {REGISTER BANK } /testbench/cores/fibo_core/golden_core_wires/register_bank_wiring/read_data_2
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/opcode
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/hazard_mux_enable
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/branch
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/memory_read
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/memory_to_register
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/alu_option
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/memory_write
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/alu_source
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/register_write
add wave -noupdate -group {MAIN CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/main_controller_wiring/AuipcLui
add wave -noupdate -group {ALU CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/alu_controller_wiring/func_7_bits
add wave -noupdate -group {ALU CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/alu_controller_wiring/func_3_bits
add wave -noupdate -group {ALU CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/alu_controller_wiring/alu_option
add wave -noupdate -group {ALU CONTROLLER} /testbench/cores/fibo_core/golden_core_wires/alu_controller_wiring/alu_operation
add wave -noupdate -group ALU /testbench/cores/fibo_core/golden_core_wires/alu_wiring/input1
add wave -noupdate -group ALU /testbench/cores/fibo_core/golden_core_wires/alu_wiring/input2
add wave -noupdate -group ALU /testbench/cores/fibo_core/golden_core_wires/alu_wiring/operation
add wave -noupdate -group ALU /testbench/cores/fibo_core/golden_core_wires/alu_wiring/result
add wave -noupdate -group ALU /testbench/cores/fibo_core/golden_core_wires/alu_wiring/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {548 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 402
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3847 ns}
