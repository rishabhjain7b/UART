// Transmitter module for UART

module uart_tx #(parameter data_bits=8, parameter transmitted_bit_counter_bits=4)
(input [data_bits-1:0]DBUS,
 input sysclk,rst_n,bclk,txd_startH,
 output txd,txd_doneH);

 reg shftTSR,loadTSR,start;
 reg clr,inc;
 reg [transmitted_bit_counter_bits-1:0]bct;
 reg txd_done,bclk_dlayed;
 wire bclk_rising;

 dff DFF1 (.clk(sysclk),.rst_n(rst_n),.in(bclk),.q(bclk_dlayed));
 
 and and_gate (bclk_rising,bclk,~(bclk_dlayed));
 
 sm_tx #(.data_bits(data_bits)) state_machine (.bclk(bclk_rising),.rst_n(rst_n),.txd_startH(txd_startH),.bct(bct),
 						.txd_done(txd_done),.start(start),.shftTSR(shftTSR),.loadTSR(loadTSR),
						.clr(clr),.inc(inc));

 counter_nbit #(.n(transmitted_bit_counter_bits)) transmitted_bit_counter (.clk(sysclk),.clear(clr),.inc(inc),.out(bct));

 PISO #(.piso_width(data_bits)) data_shift_register (.clk(sysclk),.shift(shftTSR),.start(start),.load(loadTSR),.in(DBUS),.out(TSR));

 dff DFF2 (.clk(sysclk),.rst_n(rst_n),.in(txd_done),.q(txd_doneH));

endmodule
