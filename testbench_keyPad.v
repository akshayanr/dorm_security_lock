`timescale 1ns/100ps
module testbench_keyPad();
	// keyPad(reset, equals, clk, door_status_correct, door_status_incorrect);
	//parameter WIDTH = 11;							// Data bit width
// Inputs and Outputs
	reg Clock;
	reg Clear;											// C button
	reg Equals;											// = button: displays result so far; does not repeat previous operation									// Divide button
	reg [3:0] digit; 					// Must be entered in sign-magnitude on SW[W-1:0]
	wire door_status_correct;
	wire door_status_incorrect;
	
	//keyPad.
	keyPad(.reset(Clear), .equals(Equals), .clk(Clock), .digit(digit), .door_status_correct(door_status_correct), .door_status_incorrect(door_status_incorrect));
	
// Define 10 ns Clock
	always #5 Clock = ~Clock;

	initial
	begin
		Clock = 0; Clear = 1;
		#20; Clear = 0;

		//39008121
		#10; Equals = 1; digit = 3; 
		#20; Equals = 0;

		#10; Equals = 1; digit = 9; 
		#20; Equals = 0;
		
		
		#10; Equals = 1; digit = 0; 
		#20; Equals = 0;
		
		
		#10; Equals = 1; digit = 0; 
		#20; Equals = 0;
		
		
		#10; Equals = 1; digit = 8; 
		#20; Equals = 0;
		
		
		#10; Equals = 1; digit = 1; 
		#20; Equals = 0;
		
		
		#10; Equals = 1; digit = 2; 
		#20; Equals = 0;
		
		
		#10; Equals = 1; digit = 1; 
		#20; Equals = 0;
		
		//450671
		#20; Clear = 0;

		#10; Equals = 1; digit = 4; 
		#20; Equals = 0;
		end

endmodule