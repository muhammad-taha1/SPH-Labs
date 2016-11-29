function medianFilter(s)

% get noisy pic from function written for 1c
noisyPic = ImpulsiveNoiseImage();
%imshow(noisyPic)
[row, col] = size(noisyPic);
resImg = zeros(row,col);

for i = 1 : row - s
    for j = 1 : col - s
        subMatrix = noisyPic(i:i+s-1, j:j+s-1);
        medianOfSub = median(median(subMatrix));
        resImg(i:i+s-1, j:j+s-1) = medianOfSub*ones(s,s);
    end
end
%resImg = resImg./max(max(resImg));
imshow(resImg)
end