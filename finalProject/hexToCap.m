function capacitance = hexToCap(hexValue)

value = []; 

value = decimalToBinary(hex2dec(hexValue),32);

cap = 0; 
intIndex = 1;
FracIndex = 0.5; 

for i = 28:32 
		cap = value(i)*intIndex + cap;
		intIndex = 2 * intIndex; 
end

for i = 1: 27
        cap = value(28 - i) * FracIndex + cap ;
        FracIndex = FracIndex * 0.5; 
end

capacitance = cap*10 ;
figure
capacitances = sort([11.108 11.6957 12.3627 12.9509 14.0396 11.0848 11.3534 11.5895 12.3086]); 

pressure =sort([41 154 246 321 405 35 92 134 242]);
plot(pressure, capacitances);
%fittedX = linspace(min(capacitances), max(capacitances), 200)
%p = polyfit(capacitances,pressure,1)
%f = polyval(p,fittedX);
%hold on
%plot(fittedX,f,'--r');
end