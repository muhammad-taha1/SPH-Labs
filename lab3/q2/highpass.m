function highpass()

img = imread('Baboon__grey_scale.jpg');
img = rgb2gray(img);
img = cast(img, 'double');

h = [0 -1/4 0; -1/4 1 -1/4; 0 -1/4 0];

res = conv2(img, h);
res = fft2(res);
res = abs(res);
res = ifft2(res);

%res = res./max(max(res));

imshow(res);
title('Magnitude plot of the high pass filter convoluted with Baboon image');
end
