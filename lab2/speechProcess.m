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
sound(x_flip, 16000);
end