//`include "modules/srl2_32.v"

module Gaussian_Noise(vol, noise, shiftedNoise, CLK);
	input [2:0] vol; 
	input [31:0] noise; 
	output [31:0] shiftedNoise;  
	input CLK; 
	
	always@(posedge CLK)
	begin

case(vol)
	3'b001:  shiftedNoise = noise >>> 2;
	3'b010:  shiftedNoise = noise >>> 4; 
	3'b100:  shiftedNoise = noise >>> 6; 
	3'b101:  shiftedNoise = noise >>> 7; 
	3'b110:  shiftedNoise = noise >>> 9;
	3'b111:  shiftedNoise = noise >>> 11;

	endcase	
end 
endmodule
