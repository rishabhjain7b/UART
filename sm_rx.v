// State Machine for Receiver Module of UART

module sm_rx #(parameter data_bits=8)
(input bclkx8,rst_n,rxd,
 input [2:0]ct1,
 input [3:0]ct2,
 output reg ok_en,shftRSR,load_RDR,clr1,clr2,inc1,inc2);

 parameter idle=2'b00,
	   start_detected=2'b01,
	   recv_data=2'b10;
 
 reg [1:0]pr_state,nxt_state;

always @ (posedge bclkx8, negedge rst_n)
begin
	if(!rst_n)
	begin
	pr_state <= idle;
	end
	else
	pr_state <= nxt_state;
end

always @ (posedge bclkx8)
begin
	case(pr_state)
	idle:   if(rxd == 1'b0)
		begin
			nxt_state <= start_detected;
		end
		else
		begin
			nxt_state <= idle;
		end
	start_detected: if(rxd == 1'b1)
			begin
				{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
				{clr1,clr2,inc1,inc2}<={1'b1,1'b1,1'b0,1'b0};
				//clr1 = 1'b1;
				nxt_state <= idle;
			end
			else
			begin
				if(ct1==3'd3)
				begin
					{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
					{clr1,clr2,inc1,inc2}<={1'b1,1'b1,1'b0,1'b0};
					//clr1 = 1'b1;
					nxt_state <= recv_data;
				end
				else
				begin
					{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
					{clr1,clr2,inc1,inc2}<={1'b0,1'b1,1'b1,1'b0};
					//inc1 = 1'b1;
					nxt_state <= start_detected;
				end
			end
	recv_data: if(!(ct1==3'd7))
		   begin
			{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
			{clr1,clr2,inc1,inc2}<={1'b0,1'b0,1'b1,1'b0};
			//inc1 = 1'b1;
			nxt_state <= recv_data;
		   end
		   else
		   begin
			if(!(ct2==data_bits))
			begin
				{ok_en,shftRSR,load_RDR}<={1'b0,1'b1,1'b0};
				{clr1,clr2,inc1,inc2}<={1'b1,1'b0,1'b0,1'b1};
				//{shftRSR,inc2,clr1} = {1'b1,1'b1,1'b1};
				nxt_state <= recv_data;
			end
			else
			begin
				if(rxd == 1'b1)
				begin
					{ok_en,shftRSR,load_RDR}<={1'b1,1'b0,1'b1};
					{clr1,clr2,inc1,inc2}<={1'b1,1'b1,1'b0,1'b0};
					//{load_RDR,ok_en,clr1,clr2}={1'b1,1'b1,1'b1,1'b1};
					nxt_state <= idle;
				end
				else
				begin
					{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
					{clr1,clr2,inc1,inc2}<={1'b1,1'b1,1'b0,1'b0};
					//{clr1,clr2}={1'b1,1'b1};
					nxt_state <= idle;
				end
			end
		   end
	endcase
end

always @ (negedge bclkx8)
begin
	case(pr_state)
	start_detected: begin
				{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
				{clr1,clr2,inc1,inc2}<={1'b0,1'b1,1'b0,1'b0};
				//clr1 = 1'b0;
			end
	recv_data:  if(!(ct1==3'd7))
		    begin
			{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
			{clr1,clr2,inc1,inc2}<={1'b0,1'b0,1'b0,1'b0};
			nxt_state <= recv_data;
		    end
		    else if(!(ct2==data_bits))
		    begin
			{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b0};
			{clr1,clr2,inc1,inc2}<={1'b0,1'b0,1'b0,1'b0};
			//{shftRSR,inc2,clr1} = {1'b1,1'b1,1'b1};
			nxt_state <= recv_data;
		    end
		    else
		    begin
			{ok_en,shftRSR,load_RDR}<={1'b0,1'b0,1'b1};
			{clr1,clr2,inc1,inc2}<={1'b1,1'b1,1'b0,1'b0};
			//{load_RDR,ok_en,clr1,clr2}={1'b1,1'b1,1'b1,1'b1};
			nxt_state <= idle;
		    end
	endcase
end

endmodule
