// State Machine for Transmitter Module of UART

module sm_tx #(parameter data_bits=4'd8)
(input bclk,rst_n,txd_startH,
 input [3:0]bct,
 output reg txd_done,start,shftTSR,loadTSR,clr,inc);

 parameter idle=2'b00;
 parameter synch=2'b01;
 parameter tdata=2'b10;
 
 reg [1:0]pr_state,nxt_state;

always @ (posedge bclk, negedge rst_n)
begin
	if(!rst_n)
	begin
	pr_state <= idle;
	end
	else
	pr_state <= nxt_state;
end

always @ (posedge bclk)
begin
	case(pr_state)
	idle:   if(txd_startH == 1'b1)
		begin
			{txd_done,clr,inc}<={1'b0,1'b1,1'b0};
			{start,shftTSR,loadTSR}<={1'b0,1'b0,1'b1};
			//loadTSR = 1'b1;
			nxt_state <= synch;
		end
		else
		begin
			{txd_done,clr,inc}<={1'b0,1'b1,1'b0};
			{start,shftTSR,loadTSR}<={1'b0,1'b0,1'b0};
			//loadTSR = 1'b0;
			nxt_state <= idle;
		end
	synch:  begin
		{txd_done,clr,inc}<={1'b0,1'b1,1'b0};
		{shftTSR,loadTSR}<={1'b0,1'b0};
		start <= 1'b1;
		nxt_state <= tdata;
		end
	tdata:  if(bct != (data_bits+1))
		begin
			{txd_done,clr,inc}<={1'b0,1'b0,1'b1};
			{start,shftTSR,loadTSR}<={1'b0,1'b1,1'b0};
			//{shftTSR,inc}={1'b1,1'b1};
			nxt_state <= tdata;
		end
		else
		begin
			{txd_done,clr,inc}<={1'b1,1'b1,1'b0};
			{start,shftTSR,loadTSR}<={1'b0,1'b0,1'b0};
			//{txd_done,clr} = {1'b1,1'b1};
			nxt_state <= idle;
		end
	endcase
end

always @ (negedge bclk)
begin
	case(pr_state)
	synch:  begin
		{txd_done,clr,inc}<={1'b0,1'b1,1'b0};
		{start,shftTSR,loadTSR}<={1'b0,1'b0,1'b0};
		//start = 1'b0;
		nxt_state <= tdata;
		end
	tdata:  begin
			{txd_done,clr,inc}<={1'b0,1'b0,1'b0};
			{start,shftTSR,loadTSR}<={1'b0,1'b0,1'b0};
			//{shftTSR,inc}={1'b1,1'b1};
			nxt_state <= tdata;
		end
	endcase
end
endmodule
