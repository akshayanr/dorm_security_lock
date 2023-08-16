module dorm_security_lock(reset, open, clk, door_status_correct, door_status_incorrect, doorOpen);
	//so we want this to be a moore machine, inputs determine outputs. input and state determine outputs.
	//open input incase open for dinning hall.
	//open and reset, keeps so if correct still open. 
	//not open or closed, no number entered it keeps door status.
	input reset, clk, door_status_correct, door_status_incorrect, open;
	reg [0:0] state, next_state;
	output doorOpen;
	
	localparam closed = 2'd0;
	localparam open_param = 2'd1;
	
	
	initial begin
		state <= closed;
	end
	
	always @(posedge clk)
		if(reset)
			state <= closed;
		else if(open)
			state <= open_param;
		else
			state <= next_state;
	
	always@(*)
	case(state)
		closed:
			if(door_status_correct & !door_status_incorrect)
				state = open_param;
			else if(!door_status_correct & !door_status_incorrect)
				state = closed;
			else if(reset)
				state = closed;
			else if(open)
				state = open;
			else
				state = closed;
		open_param:
			if(!door_status_correct & door_status_incorrect)
				state = open_param;
			else if(!door_status_correct & !door_status_incorrect)
				state = open_param;
			else if(reset)
				state = closed;
			else
				state = open_param;
	endcase
	
	//open if open.
	assign doorOpen = (state == open);
	
	
endmodule