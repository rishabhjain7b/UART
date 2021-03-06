// Testbench for UART transmitter module

module uart_tx_tb #(parameter data_bits=8, parameter transmitted_bit_counter_bits=4, parameter br=3'b000);
reg [data_bits-1:0]DBUS;
reg sysclk,rst_n,txd_startH;
wire txd,txd_doneH;

uart_tx #(.data_bits(data_bits), .transmitted_bit_counter_bits(transmitted_bit_counter_bits),.br(br)) TX (.*);

initial
sysclk=1'b0;

always
#222.65 sysclk=~sysclk;

initial
begin
	rst_n = 0;
	#5 rst_n = 1;
	DBUS = 1010_0101;
	#5  txd_startH=1;
	//#1  txd_startH=0;
end	

initial 
#320300.3 $stop;

endmodule