onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Main IFF} /testbench/sys_iff/A
add wave -noupdate -group {Main IFF} /testbench/sys_iff/B
add wave -noupdate -group {Main IFF} /testbench/sys_iff/start
add wave -noupdate -group {Main IFF} /testbench/sys_iff/fin_mult
add wave -noupdate -group {Main IFF} /testbench/sys_iff/S_ideal
add wave -noupdate -group {Main IFF} /testbench/sys_iff/S_real
add wave -noupdate -group {Main IFF} /testbench/sys_iff/CLK
add wave -noupdate -group {Main IFF} /testbench/sys_iff/RESET_N
add wave -noupdate -group {Main IFF} /testbench/sys_iff/comparing
add wave -noupdate -divider {DATA PATH}
add wave -noupdate -group ADDER /testbench/multipli_model/DataPath/ADDER/operational_mode
add wave -noupdate -group ADDER /testbench/multipli_model/DataPath/ADDER/input_from_reg_M
add wave -noupdate -group ADDER /testbench/multipli_model/DataPath/ADDER/input_from_reg_HI
add wave -noupdate -group ADDER /testbench/multipli_model/DataPath/ADDER/out
add wave -noupdate -group {Shifter HI} /testbench/multipli_model/DataPath/shifterHI/mode
add wave -noupdate -group {Shifter HI} /testbench/multipli_model/DataPath/shifterHI/enable
add wave -noupdate -group {Shifter HI} /testbench/multipli_model/DataPath/shifterHI/serial_data_in
add wave -noupdate -group {Shifter HI} /testbench/multipli_model/DataPath/shifterHI/parallel_data_in
add wave -noupdate -group {Shifter HI} /testbench/multipli_model/DataPath/shifterHI/parallel_data_out
add wave -noupdate -group {Shifter HI} /testbench/multipli_model/DataPath/shifterHI/serial_data_out
add wave -noupdate -group {Shifter LO} /testbench/multipli_model/DataPath/shifterLO/mode
add wave -noupdate -group {Shifter LO} /testbench/multipli_model/DataPath/shifterLO/enable
add wave -noupdate -group {Shifter LO} /testbench/multipli_model/DataPath/shifterLO/parallel_data_in
add wave -noupdate -group {Shifter LO} /testbench/multipli_model/DataPath/shifterLO/serial_data_in
add wave -noupdate -group {Shifter LO} /testbench/multipli_model/DataPath/shifterLO/parallel_data_out
add wave -noupdate -group {Shifter LO} /testbench/multipli_model/DataPath/shifterLO/serial_data_out
add wave -noupdate -group {Shifter X} /testbench/multipli_model/DataPath/registroX/qi
add wave -noupdate -group {Shifter X} /testbench/multipli_model/DataPath/registroX/enable
add wave -noupdate -group {Shifter X} /testbench/multipli_model/DataPath/registroX/q1_minus_1
add wave -noupdate -group {Register M} /testbench/multipli_model/DataPath/registroM/in_val
add wave -noupdate -group {Register M} /testbench/multipli_model/DataPath/registroM/enable
add wave -noupdate -group {Register M} /testbench/multipli_model/DataPath/registroM/aux
add wave -noupdate -group {Register M} /testbench/multipli_model/DataPath/registroM/out_val
add wave -noupdate -divider {CONTROL PATH}
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/COUNT
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/START
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/control
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/counter_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/end_mult
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/accu_operational_mode_selector
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_LO_operational_mode
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_HI_operational_mode
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/register_M_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_X_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_HI_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_LO_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_HI_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_X_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/shifter_LO_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/counter_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/ControlPath/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35494 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 423
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
WaveRestoreZoom {35457 ns} {36162 ns}
