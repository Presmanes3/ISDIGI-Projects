onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Interface /testbench/sys_iff/A
add wave -noupdate -group Interface /testbench/sys_iff/B
add wave -noupdate -group Interface /testbench/sys_iff/start
add wave -noupdate -group Interface /testbench/sys_iff/fin_mult
add wave -noupdate -group Interface /testbench/sys_iff/S_ideal
add wave -noupdate -group Interface /testbench/sys_iff/S_real
add wave -noupdate -group Interface /testbench/sys_iff/CLK
add wave -noupdate -group Interface /testbench/sys_iff/RESET_N
add wave -noupdate -group Interface /testbench/sys_iff/comparing
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/CLOCK
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/RESET
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/START
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/control
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/shifter_HI_shift_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/shifter_HI_load_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/shifter_HI_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/shifter_LO_shift_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/shifter_LO_load_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/shifter_LO_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/register_M_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/register_M_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/register_X_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/register_X_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/adder_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/adder_mode
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/END_MULT
add wave -noupdate -group {Control Path} -expand /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/count_value
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/counter_enable
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/counter_clear
add wave -noupdate -group {Control Path} /testbench/multipli_model/radicador_duv/multipli_model/ControlPath/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {232 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 523
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
WaveRestoreZoom {0 ns} {717 ns}
