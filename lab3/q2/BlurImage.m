function BlurImage()

img = imread('Baboon__grey_scale.jpg');
img = rgb2gray(img);
img = cast(img, 'double');
img = img./max(max(img));

[n, m] = size(img);
% N defines blurring scale
N = 5;

% Make the impulse response. Its an m x n matrix with values represented by
% 1/N^2. h vector should only have 1st row, col and diagnol as values, rest
% are 0

h = ones(N, N);
h = h/N^2;

% 2d convolution
result = conv2(h, img);

% show result
img = result./max(max(result));
img = fft2(img);
img = abs(img);
img = ifft2(img);
imshow(img);
title('Magnitude plot of the low pass filter convoluted with Baboon image');
end