onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /testbench/multipli_model/DataPath/total_signal
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/A
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/B
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/start
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/fin_mult
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/S_ideal
add wave -noupdate -expand -group {Main IFF} -radix binary /testbench/sys_iff/S_real
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/CLK
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/RESET_N
add wave -noupdate -expand -group {Main IFF} /testbench/sys_iff/comparing
add wave -noupdate -divider {DATA PATH}
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/clk
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/reset
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/enable
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/input_from_reg_M
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/input_from_reg_HI
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/operational_mode
add wave -noupdate -group Adder /testbench/multipli_model/DataPath/adder/out
add wave -noupdate -group Register_M /testbench/multipli_model/DataPath/regigster_M/clk
add wave -noupdate -group Register_M /testbench/multipli_model/DataPath/regigster_M/reset
add wave -noupdate -group Register_M /testbench/multipli_model/DataPath/regigster_M/enable
add wave -noupdate -group Register_M /testbench/multipli_model/DataPath/regigster_M/in
add wave -noupdate -group Register_M /testbench/multipli_model/DataPath/regigster_M/clear
add wave -noupdate -group Register_M /testbench/multipli_model/DataPath/regigster_M/out
add wave -noupdate -expand -group Register_X /testbench/multipli_model/DataPath/register_X/clk
add wave -noupdate -expand -group Register_X /testbench/multipli_model/DataPath/register_X/reset
add wave -noupdate -expand -group Register_X /testbench/multipli_model/DataPath/register_X/enable
add wave -noupdate -expand -group Register_X /testbench/multipli_model/DataPath/register_X/in
add wave -noupdate -expand -group Register_X /testbench/multipli_model/DataPath/register_X/clear
add wave -noupdate -expand -group Register_X /testbench/multipli_model/DataPath/register_X/out
add wave -noupdate -expand -group Shifter_HI /testbench/multipli_model/DataPath/shifter_HI/clk
add wave -noupdate -expand -group Shifter_HI /testbench/multipli_model/DataPath/shifter_HI/reset
add wave -noupdate -expand -group Shifter_HI /testbench/multipli_model/DataPath/shifter_HI/shift_enable
add wave -noupdate -expand -group Shifter_HI /testbench/multipli_model/DataPath/shifter_HI/load_enable
add wave -noupdate -expand -group Shifter_HI /testbench/multipli_model/DataPath/shifter_HI/clear
add wave -noupdate -expand -group Shifter_HI -radix binary /testbench/multipli_model/DataPath/shifter_HI/parallel_in
add wave -noupdate -expand -group Shifter_HI -radix binary /testbench/multipli_model/DataPath/shifter_HI/serial_in
add wave -noupdate -expand -group Shifter_HI -radix binary /testbench/multipli_model/DataPath/shifter_HI/parallel_out
add wave -noupdate -expand -group Shifter_HI -radix binary /testbench/multipli_model/DataPath/shifter_HI/serial_out
add wave -noupdate -expand -group Shifter_LO /testbench/multipli_model/DataPath/shifter_LO/clk
add wave -noupdate -expand -group Shifter_LO /testbench/multipli_model/DataPath/shifter_LO/reset
add wave -noupdate -expand -group Shifter_LO /testbench/multipli_model/DataPath/shifter_LO/shift_enable
add wave -noupdate -expand -group Shifter_LO /testbench/multipli_model/DataPath/shifter_LO/load_enable
add wave -noupdate -expand -group Shifter_LO /testbench/multipli_model/DataPath/shifter_LO/clear
add wave -noupdate -expand -group Shifter_LO -radix binary /testbench/multipli_model/DataPath/shifter_LO/parallel_in
add wave -noupdate -expand -group Shifter_LO -radix binary /testbench/multipli_model/DataPath/shifter_LO/serial_in
add wave -noupdate -expand -group Shifter_LO -radix binary /testbench/multipli_model/DataPath/shifter_LO/parallel_out
add wave -noupdate -expand -group Shifter_LO -radix binary /testbench/multipli_model/DataPath/shifter_LO/serial_out
add wave -noupdate -divider {CONTROL PATH}
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/CLOCK
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/RESET
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/START
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/control
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/shifter_HI_shift_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/shifter_HI_load_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/shifter_HI_clear
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/shifter_LO_shift_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/shifter_LO_load_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/shifter_LO_clear
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/register_M_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/register_M_clear
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/register_X_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/register_X_clear
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/adder_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/adder_mode
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/END_MULT
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/count_value
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/counter_enable
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/counter_clear
add wave -noupdate -group Control_Path /testbench/multipli_model/ControlPath/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {150 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 423
configure wave -valuecolwidth 320
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
WaveRestoreZoom {0 ns} {513 ns}
