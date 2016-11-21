function noisyPic = ImpulsiveNoiseImage()

img = imread('Baboon__grey_scale.jpg');
img = rgb2gray(img);
img = cast(img, 'double');
%img = img./max(max(img));
[m, n] = size(img);
%imshow(img)
impulseProb = 10;
noise = (rand(m, n) < impulseProb/100)*max(max(img));

result = img + noise;
result = result./max(max(result));
noisyPic = result;
%imshow(result);
end