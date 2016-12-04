function removeGaussianNoise()

% get noisy pic from function written for 1c
noisyPic = GaussianNoiseImage();

% implementing LP filters as in 2a
N = 5;
h = ones(N, N);
h = h/N^2;


% 2d convolution
result = fft2(conv2(h, noisyPic));
result = ifft2(result);
% show result
result = result./max(max(result));
figure
suptitle('Low pass filter to reduce Gaussian Noise; N = 5, SNR=10dB');
subplot(121)
imshow(noisyPic);
title('Before');
subplot(122)
imshow(result);
title('After');
end