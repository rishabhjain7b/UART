// Receiver module for UART

module uart_rx #(parameter data_bits=8, parameter received_bit_counter_bits=3, parameter bit_cell_counter_bits=4, parameter br=3'b000)
(input rxd,sysclk,rst_n,
 output [data_bits-1:0]RDR,
 output rxd_readyH);

 wire bclkx8;
 wire [data_bits-1:0]RSR;
 wire shftRSR,load_RDR,ok_en;
 wire clr1,inc1,clr2,inc2;
 wire [received_bit_counter_bits-1:0]ct1;
 wire [bit_cell_counter_bits-1:0]ct2;
 wire bclkx8_dlayed;
 wire bclkx8_rising;

 BRG #(.sel(br)) baud_rate_generator (.fclk(sysclk),.bclkx8(bclkx8),.bclk());

 dff DFF1 (.clk(sysclk),.rst_n(rst_n),.in(bclkx8),.q(bclkx8_dlayed));
 
 and and_gate (bclkx8_rising,bclkx8,~(bclkx8_dlayed));
 
 sm_rx #(.data_bits(data_bits)) state_machine (.bclkx8(bclkx8_rising),.rst_n(rst_n),.rxd(rxd),.ct1(ct1),
 						.ct2(ct2),.ok_en(ok_en),.shftRSR(shftRSR),.load_RDR(load_RDR),
						.clr1(clr1),.clr2(clr2),.inc1(inc1),.inc2(inc2));

 counter_nbit #(.n(received_bit_counter_bits)) received_bit_counter (.clk(sysclk),.clear(clr1),.inc(inc1),.out(ct1));

 counter_nbit #(.n(bit_cell_counter_bits)) bit_cell_counter (.clk(sysclk),.clear(clr2),.inc(inc2),.out(ct2));

 SIPO #(.sipo_width(data_bits)) data_shift_register (.clk(sysclk),.shift(shftRSR),.in(rxd),.out(RSR));
 
 PIPO #(.pipo_width(data_bits)) received_data_loader (.clk(sysclk),.load(load_RDR),.in(RSR),.out(RDR));

 dff DFF2 (.clk(sysclk),.rst_n(rst_n),.in(ok_en),.q(rxd_readyH));

endmodule
