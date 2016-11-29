function noisyPic = GaussianNoiseImage()

img = imread('Baboon__grey_scale.jpg');
img = rgb2gray(img);
img = cast(img, 'double');
%img = img./max(max(img));

%imshow(img)

% assign SNR as constant, specified in qs
SNR_dB = -10;
SNR = 10.^(SNR_dB./10); 

[m, n] = size(img);
Psig = 0;

% calculate Psig
for row = 1 : m
    for col = 1 : n
        Psig = Psig + img(row, col)^2;
    end
end

Psig = Psig/(m*n);

% find noise power from SNR
Pnoise = Psig/SNR;

% generate noise based on Pnoise. standard deviation is sqrt(Pnoise)
noise = sqrt(Pnoise)*randn(m, n);

result = img + noise;
result = result./max(max(result));
imshow(result);
noisyPic = result;
end