img = imread('Baboon__grey_scale.jpg'); 
img = rgb2gray(img);
img = cast(img, 'double'); 
%img = img./max(max(img));

img = fft2(img);

% img = abs(img);
%img = ifft2(img);
figure  
stem(img) 
% img = img./max(max(img));

 %imshow(img); 
 img = img./abs(img);
% img = angle(img);
 img = ifft2(img);
 img = img./max(max(img));
figure
 imshow(img);
%img(1,1)