function speechProcess

x = audioread('speech.wav');
h = audioread('h.wav');

% part a
%stem(h);
% delayIdx = 0;
% for i = 1 : length(h)
%     if (h(i) ~= 0)
%         delayIdx = i;
%         break;
%     end
% end

% delay = delayIdx/16000;

% speed of sound = 340 m/s
% distance = 340*delay; % distance in meters

% part b
% x_conv = conv(x, h);

%sound(x, 16000);
%sound(h, 16000);
%sound(x_conv, 16000);

% part c
% shifted h => append col of zeros by shifted amout before h
% h_shift = [zeros(3000,1);h];
% h_echo = [h;zeros(3000,1)] + h_shift;
% x_conv = conv(x, h_echo);
%sound(x_conv, 16000);

% part d
% x_flip = flipud(x);
%sound(x_flip, 16000);

% part e
%sound(x, 13000);
%sound(x, 14500);
%sound(x, 17000);
%sound(x, 18500);
%sound(x, 20000);

% part f
% x_sub_2 = [];
% 
% for i = 1 : length(x)
%     if (mod(i, 2) == 0)
%         x_sub_2 = [x_sub_2; x(i)];
%     end
% end
% 
% x_sub_3 = [];
% for i = 1 : length(x)
%     if (mod(i, 3) == 0)
%         x_sub_3 = [x_sub_3; x(i)];
%     end
% end
% 
% x_sub_4 = [];
% for i = 1 : length(x)
%     if (mod(i, 4) == 0)
%         x_sub_4 = [x_sub_4; x(i)];
%     end
% end
% 
% x_sub_5 = [];
% for i = 1 : length(x)
%     if (mod(i, 5) == 0)
%         x_sub_5 = [x_sub_5; x(i)];
%     end
% end
% 
% x_sub_10 = [];
% for i = 1 : length(x)
%     if (mod(i, 10) == 0)
%         x_sub_10 = [x_sub_10; x(i)];
%     end
% end


%sound(x_sub_10, 16000/10);
% stem(fft(x));
% hold on
% stem(fft(x_sub_2));
% hold on
% stem(fft(x_sub_3));
% hold on
% stem(fft(x_sub_4));
% hold on
% stem(fft(x_sub_5));
% hold on
% stem(fft(x_sub_10));
% %stem(fft(x));
% legend('1:1', '2:1', '3:1', '4:1', '5:1', '10:1');

% part g

% For each quantization level, the following approach was taken:
% mutliply signal by 2^(quantization level - 1) (1 bit is to account for 
% sign representation.
% loop over the result and assign any signal going above the quanitization
% range to the max possible bit for that quantization level
% Divide the signal by 2^(quantization level - 1) to normalize
% Plot and listen to resulting quantized signal

% oneBitQuant = x;
% for i = 1 : length(oneBitQuant)
%     if (oneBitQuant(i) > 0)
%         oneBitQuant(i) = 1;
%     end
%     if (oneBitQuant(i) < 0)
%         oneBitQuant(i) = -1;
%     end
% end
% oneBitQuant = oneBitQuant/2^1;
% stem(oneBitQuant);
% sound(oneBitQuant, 16000);

% twoBitQuant = round(x*2^2);
% for i = 1 : length(twoBitQuant)
%     if (twoBitQuant(i) > (2^1 - 1))
%         twoBitQuant(i) = 1;
%     end
%     if (twoBitQuant(i) < -(2^1 - 1))
%         twoBitQuant(i) = -1;
%     end
%     
%     if (x(i) < 0 && twoBitQuant(i) == 0)
%         twoBitQuant(i) = -0.5;
%     end
%     
%     if (x(i) >= 0 && twoBitQuant(i) == 0)
%         twoBitQuant(i) = 0.5;
%     end
% end
% unique(twoBitQuant)
% twoBitQuant = twoBitQuant/2^2;
% stem(twoBitQuant);
% sound(twoBitQuant, 16000);


% fourBitQuant = round(x*2^4);
% for i = 1 : length(fourBitQuant)
%     if (fourBitQuant(i) > (2^3 - 1))
%         fourBitQuant(i) = 7;
%     end
%     if (fourBitQuant(i) < -(2^3 - 1))
%         fourBitQuant(i) = -7;
%     end
%     
%     if (x(i) < 0 && fourBitQuant(i) == 0)
%         fourBitQuant(i) = -0.5;
%     end
%     
%     if (x(i) >= 0 && fourBitQuant(i) == 0)
%         fourBitQuant(i) = 0.5;
%     end
% end
% unique(fourBitQuant)
% fourBitQuant = fourBitQuant/2^4;
% stem(fourBitQuant);
% sound(fourBitQuant, 16000);

EightBitQuant = round(x*2^8);
for i = 1 : length(EightBitQuant)
    if (EightBitQuant(i) > (2^8 - 1))
        EightBitQuant(i) = 127;
    end
    if (EightBitQuant(i) < -(2^8 - 1))
        EightBitQuant(i) = -127;
    end
    
    if (x(i) < 0 && EightBitQuant(i) == 0)
        EightBitQuant(i) = -0.5;
    end
    
    if (x(i) >= 0 && EightBitQuant(i) == 0)
        EightBitQuant(i) = 0.5;
    end

end
EightBitQuant = EightBitQuant/2^8;
stem(EightBitQuant);
sound(EightBitQuant, 16000);

sixteenBitQuant = round(x*2^16);
for i = 1 : length(sixteenBitQuant)
    if (sixteenBitQuant(i) > (2^16 - 1))
        sixteenBitQuant(i) = 32767;
    end
    if (sixteenBitQuant(i) < -(2^16 - 1))
        sixteenBitQuant(i) = -32767;
    end
    
    if (x(i) < 0 && sixteenBitQuant(i) == 0)
        sixteenBitQuant(i) = -0.5;
    end
    
    if (x(i) >= 0 && sixteenBitQuant(i) == 0)
        sixteenBitQuant(i) = 0.5;
    end
end
sixteenBitQuant = sixteenBitQuant/2^16;
stem(sixteenBitQuant);
sound(sixteenBitQuant, 16000);
