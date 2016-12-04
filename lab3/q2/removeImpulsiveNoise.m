function removeImpulsiveNoise()

% get noisy pic from function written for 1d
noisyPic = ImpulsiveNoiseImage();

% implementing LP filters as in 2a
N = 5;
h = ones(N, N);
h = h/N^2;

% 2d convolution
result = conv2(h, noisyPic);

% show result
result = result./max(max(result));
figure
suptitle('Low pass filter to reduce Impulsive Noise; N = 5, Piid=10%');
subplot(121)
imshow(noisyPic);
title('Before');
subplot(122)
imshow(result);
title('After');
end