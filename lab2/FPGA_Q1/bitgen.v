module bitgen(SEL,bitstream); 

	input [3:0]SEL;
	output reg bitstream; 
	
	always @(SEL)begin
	
	bitstream = 0; 

	case(SEL)
	4'b0001 : bitstream = 1'b1; //input vector SEL. If the input vector SEL is equivalent to 
	4'b0010 : bitstream = 1'b0; //any of the cases indicated on the left of the colon, a 
	4'b0011 : bitstream = 1'b0; //specific bit will be produced as output (ex: if the SEL line 
	4'b0100 : bitstream = 1'b0; //is 0101, the output bit will be 1). 
	4'b0101 : bitstream = 1'b1; 
	4'b0110 : bitstream = 1'b1; 
	4'b0111 : bitstream = 1'b0;
	4'b1000 : bitstream = 1'b1; 
	
	endcase
	
	end 

endmodule 