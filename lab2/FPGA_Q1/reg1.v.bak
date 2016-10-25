module reg1 (reset, CLK, D, Q);

//maybe use a d flip-flop if it doesn't work 

	input reset;
	input	CLK;
	input	D;
	output	Q;
	reg	Q;
	
	always@(posedge CLK)
	begin
		if (reset)
			Q=0;
		else
			Q=D;
	end		
			
endmodule
