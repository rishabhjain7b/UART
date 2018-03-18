# This is TCL file for UART

vlog *.v
vsim -novopt uart_tb
add wave *
add wave -position end sim:/uart_tb/TX/state_machine/*
add wave -position end sim:/uart_tb/TX/data_shift_register/*
add wave -position end sim:/uart_tb/TX/transmitted_bit_counter/*
add wave -position end sim:/uart_tb/RX/state_machine/*
add wave -position end sim:/uart_tb/RX/data_shift_register/*
add wave -position end sim:/uart_tb/RX/received_data_loader/*
run -all