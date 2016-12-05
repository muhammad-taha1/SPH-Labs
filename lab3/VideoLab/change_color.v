module change_colour (X, Y, SW, CLK, R, G, B); 

input[9:0] X; 
input[9:0] Y; 
input[17:0] SW;
input CLK;  
output reg [3:0] R;
output reg [3:0] G;
output reg [3:0] B;

integer rgb = 0; 
integer rainbow = 0; 

always @ (X,Y) 
begin 
	if(((rgb%60) == 0) && ((rainbow%7) == 0))
	begin 
		R = 4'b1111; 
		G = 4'b0000; 
		B = 4'b0000; 
	end
	if(((rgb%60) == 0) && ((rainbow%7) == 1))
	begin
		R = 4'b1111; 
		G = 4'b1100; 
		B = 4'b0000; 
	end
	if(((rgb%60) == 0) && ((rainbow%7) == 2))
	begin
		R = 4'b1111; 
		G = 4'b1111; 
		B = 4'b0000; 
	end
	if(((rgb%60) == 0) && ((rainbow%7) == 3))
	begin
		R = 4'b0000; 
		G = 4'b1111; 
		B = 4'b0000; 
	end
	if(((rgb%60) == 0) && ((rainbow%7) == 4))
	begin
		R = 4'b0000; 
		G = 4'b0000; 
		B = 4'b1111; 
	end	
	if(((rgb%60) == 0) && ((rainbow%7) == 5))
	begin
		R = 4'b1000; 
		G = 4'b0000; 
		B = 4'b1100; 
	end
	if(((rgb%60) == 0) && ((rainbow%7) == 6))
	begin
		R = 4'b1100; 
		G = 4'b0000; 
		B = 4'b1110; 
	end
end 

always @(posedge(CLK))
begin 
rgb = rgb + 1; 
	if((rgb%60) == 0)
		begin 
		rainbow = rainbow + 1; 
		end 
	end 
endmodule 