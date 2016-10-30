module subSample(left_channel_audio_in, right_channel_audio_in, left_channel_audio_out, right_channel_audio_out, vol, CLK);

	input [31:0] left_channel_audio_in, right_channel_audio_in; 
	input [2:0] vol; 
	output [31:0] left_channel_audio_out, right_channel_audio_out; 
	input CLK; 

	always@(posedge CLK)
	begin
	
	
	// zero-hold order approach
	case(vol)
	3'b000 : begin
		// no aliasing
		left_channel_audio_out = left_channel_audio_in;
		right_channel_audio_out = right_channel_audio_in;
	end
	3'b001 : begin
		// 2 bit aliasing
		for (integer i = 0; i < 32; i = i + 2)
		begin
			left_channel_audio_out[i] = left_channel_audio_in[i];
			left_channel_audio_out[i + 1] = left_channel_audio_in[i];
			
			right_channel_audio_out[i] = right_channel_audio_in[i];
			right_channel_audio_out[i + 1] = right_channel_audio_in[i];
		end
	end
	3'b010 : begin
		// 4 bit aliasing
		for (integer i = 0; i < 32; i = i + 4)
		begin
			left_channel_audio_out[i] = left_channel_audio_in[i];
			left_channel_audio_out[i + 1] = left_channel_audio_in[i];
			left_channel_audio_out[i + 2] = left_channel_audio_in[i];
			left_channel_audio_out[i + 3] = left_channel_audio_in[i];
			
			right_channel_audio_out[i] = right_channel_audio_in[i];
			right_channel_audio_out[i + 1] = right_channel_audio_in[i];
			right_channel_audio_out[i + 2] = right_channel_audio_in[i];
			right_channel_audio_out[i + 3] = right_channel_audio_in[i];
		end
	end
	3'b100 : begin
		// 8 bit aliasing
		for (integer i = 0; i < 32; i = i + 8)
		begin
			left_channel_audio_out[i] = left_channel_audio_in[i];
			left_channel_audio_out[i + 1] = left_channel_audio_in[i];
			left_channel_audio_out[i + 2] = left_channel_audio_in[i];
			left_channel_audio_out[i + 3] = left_channel_audio_in[i];
			left_channel_audio_out[i + 4] = left_channel_audio_in[i];
			left_channel_audio_out[i + 5] = left_channel_audio_in[i];
			left_channel_audio_out[i + 6] = left_channel_audio_in[i];
			left_channel_audio_out[i + 7] = left_channel_audio_in[i];
			
			right_channel_audio_out[i] = right_channel_audio_in[i];
			right_channel_audio_out[i + 1] = right_channel_audio_in[i];
			right_channel_audio_out[i + 2] = right_channel_audio_in[i];
			right_channel_audio_out[i + 3] = right_channel_audio_in[i];
			right_channel_audio_out[i + 4] = right_channel_audio_in[i];
			right_channel_audio_out[i + 5] = right_channel_audio_in[i];
			right_channel_audio_out[i + 6] = right_channel_audio_in[i];
			right_channel_audio_out[i + 7] = right_channel_audio_in[i];
		end
	end
	endcase	
	end

endmodule