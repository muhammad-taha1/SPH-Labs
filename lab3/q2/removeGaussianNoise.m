function removeGaussianNoise()

% get noisy pic from function written for 1c
noisyPic = GaussianNoiseImage();

% implementing LP filters as in 2a
N = 3;
h = ones(N, N);
h = h/N^2;

%TODO: I don't get this part
h_f = fft(h);

% 2d convolution
result = conv2(h, noisyPic);

% show result
result = result./max(max(result));
imshow(result);
end