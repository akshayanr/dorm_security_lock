module keyPad(reset, equals, clk, digit, door_status_correct, door_status_incorrect);
	input reset, clk, equals;
	input [3:0] digit;
	reg[3:0] stored_digit;
	//just state for this, so we don't actually
	reg [3:0]state, next_state;
	//need to figure out 
	output door_status_correct;
	output door_status_incorrect;
	
	//wires.
	wire LD_N;
	//wire [3:0] feed_digit;
	
	

	
	//so have two outputs incorrect and correct.
	
	//look up the difference between assign.
	
	//reset have to have available 
	initial begin
		state <= XInit;
		stored_digit <= 'd0;
	end
	
	//next state
	//don't need a begin and end here. 
	always @(posedge clk)
		if (reset)
			state <= XInit;
		else
			state <= next_state;
			
		
	always @(posedge clk)
	begin
		//N_TC <= LD_N ? NumberTC : N_TC;
		//stored_digit
		stored_digit <= LD_N ? digit : stored_digit;
	end
	
	//39008121
	//finish
	//if incorrect goes to a separate state.
	localparam XInit = 5'd0;
	localparam XFinish = 5'd1;
	localparam XIncorrect = 5'd2;
	localparam XCheckFirstDigit = 4'd3;
	localparam XGetSecond = 5'd4;
	localparam XCheckSecondDigit = 5'd5;
	localparam XGetThird = 5'd6;
	localparam XCheckThirdDigit = 5'd7;
	localparam XGetFourth = 5'd8;
	localparam XCheckFourthDigit = 5'd9;
	localparam XGetFifth = 5'd10;
	localparam XCheckFifthDigit = 5'd11;
	localparam XGetSixth = 5'd12;
	localparam XCheckSixthDigit = 5'd13;
	localparam XGetSeventh = 5'd14;
	localparam XCheckSeventhDigit = 5'd15;
	localparam XGetEigth = 5'd16;
	localparam XCheckEigthDigit = 5'd17;
	//data path state uodate.
	//need to reset here as well. 
	//combinational portion
	//like enum case.
	always @(*)
	case(state)
		XInit:
			if(equals)
				next_state <= XCheckFirstDigit;
			else
				next_state <= XInit;
		XCheckFirstDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd3)
				next_state <= XGetSecond;
			else
				next_state <= XIncorrect;
		XGetSecond:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckSecondDigit;
			else
				next_state <= XGetSecond;
		XCheckSecondDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd9)
				next_state <= XGetThird;
			else
				next_state <= XIncorrect;
		XGetThird:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckThirdDigit;
			else
				next_state <= XGetThird;
		XCheckThirdDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd0)
				next_state <= XGetFourth;
			else
				next_state <= XIncorrect;
		XGetFourth:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckFourthDigit;
			else
				next_state <= XGetFourth;
		XCheckFourthDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd0)
				next_state <= XGetFifth;
			else
				next_state <= XIncorrect;
		XGetFifth:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckFifthDigit;
			else
				next_state <= XGetFifth;
		XCheckFifthDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd8)
				next_state <= XGetSixth;
			else
				next_state <= XIncorrect;
		XGetSixth:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckSixthDigit;
			else
				next_state <= XGetSixth;
		XCheckSixthDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd1)
				next_state <= XGetSeventh;
			else
				next_state <= XIncorrect;
		XGetSeventh:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckSeventhDigit;
			else
				next_state <= XGetSeventh;
		XCheckSeventhDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd2)
				next_state <= XGetEigth;
			else
				next_state <= XIncorrect;
		XGetEigth:
			if(reset)
				next_state <= XInit;
			else if(equals)
				next_state <= XCheckEigthDigit;
			else
				next_state <= XGetEigth;
		XCheckEigthDigit:
			if(reset)
				next_state <= XInit;
			else if(stored_digit == 4'd1)
				next_state <= XFinish;
			else
				next_state <= XIncorrect;	
	endcase
	
	
	//set the next 
	
	
	//assigning signals 
	//so in the next thing we'd need to check that 1 and 2,
	//then that is correct.
	//Follow this: 
	//so get number states is when get number
	//and then you have to check in next state. 
	//because in addition you check if overflow, so
	//even in calculator you go to check overflow, 
	//so for addition keeps getting added so it's fine. 
	
	//okay so LD_N and is working. 
	assign LD_N = (state == XInit || state == XGetSecond || state == XGetThird || state == XGetFourth || state == XGetFifth || state == XGetSixth || state == XGetSeventh || state == XGetEigth);
	assign door_status_correct = (state == XFinish);
	assign door_status_incorrect = (state == XIncorrect);
	
	
endmodule