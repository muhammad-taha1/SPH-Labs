function highpass()

img = imread('Baboon__grey_scale.jpg');
img = rgb2gray(img);
img = cast(img, 'double');

h = [0 -1/4 0; -1/4 1 -1/4; 0 -1/4 0];

res = conv2(img, h);
img = img./max(max(img));
imshow(res)
end
