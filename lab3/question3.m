%img = imread('Baboon__grey_scale.jpg');
%img = imread('lena_grey_scale.png');
%img = imread('1280px-Flag_of_Japan.svg.png');
%img = imread('gabor_tutorial_08.png');
%img = imread('Spot light effect_DSC6360.jpg');
img = imread('black-dot.jpg');
%img = imread('const.png');

img = rgb2gray(img);
img = cast(img, 'double');
%img = img./max(max(img));

img = fft2(img);

% img = abs(img);
%img = ifft2(img);

% ** part a & b
figure
% subplot magnitude
subplot(211)
stem(abs(img))
title('magnitude')
% subplot phase
subplot(212)
stem(img./abs(img))
title('phase')


% img = img./max(max(img));

%imshow(img);
img = img./abs(img);
% img = angle(img);
img = ifft2(img);
img = img./max(max(img));

%figure
%imshow(img);
%img(1,1)