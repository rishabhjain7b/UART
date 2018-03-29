// Testbench for complete UART

module uart_tb #(parameter data_bits=8, parameter transmitted_bit_counter_bits=4, parameter br=3'b000, parameter received_bit_counter_bits=3, parameter bit_cell_counter_bits=4);
reg [data_bits-1:0]DBUS;
reg sysclk,rst_n,txd_startH;
wire txd,txd_doneH;
reg rxd;
wire [data_bits-1:0]RDR;
wire rxd_readyH;

uart_tx #(.data_bits(data_bits), .transmitted_bit_counter_bits(transmitted_bit_counter_bits),.br(br)) TX (.*);

uart_rx #(.data_bits(data_bits), .received_bit_counter_bits(received_bit_counter_bits), .bit_cell_counter_bits(bit_cell_counter_bits), .br(br)) RX (.*);

initial
sysclk=1'b0;

always
#222.65 sysclk=~sysclk;

initial
begin
	rst_n = 0;
	#5 rst_n = 1;
	DBUS = 11111101;
	#5  txd_startH=1;
	//#1  txd_startH=0;
end	

always @ (posedge sysclk)
rxd=txd;

initial 
#400300.3 $stop;

endmodule
