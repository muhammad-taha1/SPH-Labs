function noisyPic = ImpulsiveNoiseImage()

img = imread('Baboon__grey_scale.jpg');
img = rgb2gray(img);
img = cast(img, 'double');
%img = img./max(max(img));
[m, n] = size(img);
%imshow(img)
impulseProb = 10;
noise = (rand(m, n) < impulseProb/100)*max(max(img))/2;

Psig = 0;
Pnoise = 0;

for row = 1 : m
    for col = 1 : n
        Psig = Psig + img(row, col)^2;
    end
end

for row = 1 : m
    for col = 1 : n
        Pnoise = Pnoise + noise(row, col)^2;
    end
end

SNR = 10*log10(Psig/Pnoise) % just a printout
result = img + noise;
result = result./max(max(result));
noisyPic = result;
%imshow(result);
end