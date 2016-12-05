module moving_square(X, Y, SW, R, G, B, CLK);

input[9:0] X; 
input[9:0] Y; 
input[17:0] SW;
input CLK;  
output reg [3:0] R = 4'b1111;
output reg [3:0] G = 4'b1111;
output reg [3:0] B = 4'b1111;

integer xr = 0;  
integer yr = 0;
integer rgb = 0;   
integer rainbow = 0;  

always @(X,Y)
begin
	R = 4'b1111; 
	G = 4'b1111; 
	B = 4'b1111;
case(SW)
18'b000000000000000000: 
begin 
	if (((20 <= X) && (X<= 50) && (20 <= Y) &&(Y <= 60)))
			begin
				R = 4'b0000; 
				G = 4'b0000;
				B = 4'b1111;
			end 
end
18'b000000000000000001:
begin
	if (((20 <= X) && (X<= 80) && (20 <= Y) &&(Y <= 100)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end
end
18'b000000000000000010:
begin
	if (((20 <= X) && (X<= 110) && (20 <= Y) &&(Y <= 140)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end
end  
18'b000000000000000100:
begin
	if (((20 <= X) && (X<= 140) && (20 <= Y) &&(Y <= 180)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end
end 
18'b000000000000001000:
begin
	if (((xr) <= X) && (X<= (30 + xr) ) && ((yr)<= Y ) &&(Y <= (40 + yr)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end 
end
18'b000000000000011000:
begin
	if (((xr) <= X) && (X<= (30 + xr) ) && ((yr)<= Y ) &&(Y <= (40 + yr)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end 
end  
18'b000000000000111000:
begin
	if (((xr) <= X) && (X<= (30 + xr) ) && ((yr)<= Y ) &&(Y <= (40 + yr)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end 
end 
18'b000000000001111000:
begin
	if (((xr) <= X) && (X<= (30 + xr) ) && ((yr)<= Y ) &&(Y <= (40 + yr)))
		begin
			R = 4'b0000; 
			G = 4'b0000;
			B = 4'b1111;
		end 
end 
18'b000000000010000000:
begin 
	if (((xr) <= X) && (X<= (30 + xr) ) && ((yr)<= Y ) &&(Y <= (40 + yr)))
		begin
		if((rgb > 0) && (rgb <= 60))
			begin 
			R = 4'b1111; 
			G = 4'b0000; 
			B = 4'b0000; 
		end
		if((rgb > 60) && (rgb <= 120))
		begin
			R = 4'b1111; 
			G = 4'b1100; 
			B = 4'b0000; 
		end
		if((rgb > 120) &&(rgb <= 180))
		begin
			R = 4'b1111; 
			G = 4'b1111; 
			B = 4'b0000; 
		end
		if((rgb > 180) &&(rgb <= 240))
		begin
			R = 4'b0000; 
			G = 4'b1111; 
			B = 4'b0000; 
		end
		if((rgb > 240) &&(rgb <= 300))
		begin
			R = 4'b0000; 
			G = 4'b0000; 
			B = 4'b1111; 
		end	
		if((rgb > 300) &&(rgb <= 360))
		begin
			R = 4'b1000; 
			G = 4'b0000; 
			B = 4'b1100; 
		end
		if((rgb > 360) &&(rgb <= 420))
		begin
			R = 4'b1100; 
			G = 4'b0000; 
			B = 4'b1110; 
		end
	end
end 
endcase
end 

always @(posedge(CLK))
begin
case(SW)
18'b000000000000001000:
begin
	xr = xr + 1; 
	yr = yr + 1; 
end
18'b000000000000011000:
begin
	xr = xr + 2; 
	yr = yr + 2; 
end  
18'b000000000000111000:
begin
	xr = xr + 3; 
	yr = yr + 3; 
end 
18'b000000000001111000:
begin
	xr = xr + 4; 
	yr = yr + 4; 
end 
18'b000000000010000000:
begin  
	xr = xr + 1; 
	yr = yr + 1;
	rgb = rgb + 1; 
		if((rgb == 420))
		begin 
		rgb = 0 ;
		end 
end 
endcase
	if ((xr >= 608) || (yr >= 438))
	begin
		xr = 0; 
		yr = 0; 
	end 

end 

endmodule
