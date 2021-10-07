onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_FIFO/fifo_iff/CLK
add wave -noupdate /tb_FIFO/DUV/reset_controller
add wave -noupdate -divider {WRITE AND READ}
add wave -noupdate /tb_FIFO/fifo_iff/WRITE
add wave -noupdate /tb_FIFO/fifo_iff/READ
add wave -noupdate -divider COUNTERS
add wave -noupdate -divider COUNTER_W
add wave -noupdate /tb_FIFO/DUV/counter_w/ENABLE
add wave -noupdate /tb_FIFO/DUV/counter_w/OUT
add wave -noupdate /tb_FIFO/DUV/counter_w_current_value
add wave -noupdate -divider COUNTER_R
add wave -noupdate /tb_FIFO/DUV/counter_r/ENABLE
add wave -noupdate /tb_FIFO/DUV/counter_r/OUT
add wave -noupdate /tb_FIFO/DUV/counter_r_current_value
add wave -noupdate -divider COUNTER_DW
add wave -noupdate /tb_FIFO/DUV/use_dw/ENABLE
add wave -noupdate -radix unsigned /tb_FIFO/DUV/use_dw/OUT
add wave -noupdate -radix unsigned /tb_FIFO/fifo_iff/USE_DW
add wave -noupdate -divider STATES
add wave -noupdate /tb_FIFO/DUV/next_state
add wave -noupdate /tb_FIFO/DUV/current_state
add wave -noupdate -divider RAM
add wave -noupdate /tb_FIFO/DUV/PILA/data_in
add wave -noupdate /tb_FIFO/DUV/PILA/data_out
add wave -noupdate -divider OUTPUT
add wave -noupdate /tb_FIFO/DUV/output_selector
add wave -noupdate /tb_FIFO/DUV/PILA/data_out
add wave -noupdate /tb_FIFO/fifo_iff/DATA_IN
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_FIFO/DUV/flag_use_dw_31
add wave -noupdate /tb_FIFO/DUV/flag_use_dw_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {370 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
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
configure wave -timelineunits ps
update
WaveRestoreZoom {118 ps} {394 ps}
