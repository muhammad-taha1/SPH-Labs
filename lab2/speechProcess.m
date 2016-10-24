function speechProcess

x = audioread('speech.wav');
h = audioread('h.wav');

% part a
%stem(h);
delayIdx = 0;
for i = 1 : length(h)
    if (h(i) ~= 0)
        delayIdx = i;
        break;
    end
end

delay = delayIdx/16000;

% speed of sound = 340 m/s
distance = 340*delay; % distance in meters

% part b
x_conv = conv(x, h);

%sound(x, 16000);
%sound(h, 16000);
%sound(x_conv, 16000);

% part c
% shifted h => append col of zeros by shifted amout before h
h_shift = [zeros(3000,1);h];
h_echo = [h;zeros(3000,1)] + h_shift;
x_conv = conv(x, h_echo);
%sound(x_conv, 16000);

% part d
x_flip = flipud(x);
%sound(x_flip, 16000);

% part e
%sound(x, 13000);
%sound(x, 14500);
%sound(x, 17000);
%sound(x, 18500);
%sound(x, 20000);

% part f
x_sub_2 = [];

for i = 1 : length(x)
    if (mod(i, 2) == 0)
        x_sub_2 = [x_sub_2; x(i)];
    end
end

x_sub_3 = [];
for i = 1 : length(x)
    if (mod(i, 3) == 0)
        x_sub_3 = [x_sub_3; x(i)];
    end
end

x_sub_4 = [];
for i = 1 : length(x)
    if (mod(i, 4) == 0)
        x_sub_4 = [x_sub_4; x(i)];
    end
end

x_sub_5 = [];
for i = 1 : length(x)
    if (mod(i, 5) == 0)
        x_sub_5 = [x_sub_5; x(i)];
    end
end

x_sub_10 = [];
for i = 1 : length(x)
    if (mod(i, 10) == 0)
        x_sub_10 = [x_sub_10; x(i)];
    end
end
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
%x_quantized = ceil(x*1)/1;
%stem(x)
end