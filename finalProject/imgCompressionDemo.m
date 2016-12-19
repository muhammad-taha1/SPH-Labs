function imgCompression()
%% Create Raw Image
% 512 by 512 pixels binary image that has a sqaure 180 by 180 pixels square
% on left
rawImg = ones(5*7*50,5*7*50);

for i= 1: 5*7*50
    for j=1: 5*7*50
        if (((i == 10*7) || (i == 100*7)) && ((j>=10*7) && (j<=100*7)))
            rawImg(i,j) = 0;
        elseif ( ((j == 10*7) || (j == 100*7)) && ((i>=10*7) && (i<=100*7)))
            rawImg(i,j) = 0;
        else
            rawImg(i,j) = 1;
        end
        
        % random tilted square
        if (abs(i-5*7) + abs(j-200*7) == 90*7)
            rawImg(i,j) = 0;
        end
        
        % rectangle from 180-250 at i and 10-100 in j
        if (((i == 180*7) || (i == 250*7)) && ((j>=10*7) && (j<=100*7)))
            rawImg(i,j) = 0;
        elseif ( ((j == 10*7) || (j == 100*7)) && ((i>=180*7) && (i<=250*7)))
            rawImg(i,j) = 0;
        end
        
    end
end

circImg = ones(5*7*50, 5*7*50);
for i= 1: 5*7*50
    for j=1: 5*7*50
        % create bolded circle in of radius 50 pixels, centered at 90,100
        if ((i-90*7)^2 + (j-100*7)^2 <= (50*7)^2)
            circImg(i,j) = 0;
        end
        % remove all inner circle pixels
        if ((i-90*7)^2 + (j-100*7)^2 <= (48*7)^2)
            circImg(i,j) = 1;
        end
        
        % create another circle in of radius 20 pixels, centered at 200,200
        if ((i-215*7)^2 + (j-50*7)^2 <= (20*7)^2)
            circImg(i,j) = 0;
        end
        % remove all inner circle pixels
        if ((i-215*7)^2 + (j-50*7)^2 <= (19*7)^2)
            circImg(i,j) = 1;
        end
        
        
        % create another circle in of radius 30 pixels, centered at 200,200
        % circle within square
        if ((i-200*7)^2 + (j-200*7)^2 <= (30*7)^2)
            circImg(i,j) = 0;
        end
        % remove all inner circle pixels
        if ((i-200*7)^2 + (j-200*7)^2 <= (29*7)^2)
            circImg(i,j) = 1;
        end
    end
end

rawImg = mod((rawImg + circImg), 2);
% mod2 addition inverts img, so invert it
rawImg = ~rawImg;


%% Image size
[rSize, cSize] = size(rawImg);

%% Parameters to check performance
compSize = 0;
originalImgSize = rSize*cSize;

% apparently, white spots are indicated by 1 and black by 0. So now we flip
% these things (essentially make a negative of the image). The image will
% be flipped back again after decompression
for row = 1 : rSize
    for col = 1 : cSize
        rawImg(row, col) = ~rawImg(row, col);
    end
end
% figure

% get p0 and p1 from img
p1 = 0;
p0 = 0;
for row = 1 : rSize
    for col = 1 : cSize
        if (rawImg(row, col) == 1)
            p1 = p1 + 1;
        else
            p0 = p0 + 1;
        end
    end
end

p0 = p0/(rSize*cSize);
p1 = p1/(rSize*cSize);


%% Encode img, and save the result in compImg.mat file
% The whole img is converted into an array(one row) and then reshaped
% after being also decompressed as one row.

rawImg = reshape(rawImg, 1, []);
n = 25;
% Markov computations
ProbZeroAtOne = 1 - p1;
ProbOneAtZero = 1 - p0;

pieZero = ProbZeroAtOne / (ProbZeroAtOne + ProbOneAtZero);
pieOne = 1 - pieZero;
Hx = pieZero * (p0 * log2(1/p0) + ProbOneAtZero * log2(1/ProbOneAtZero)) + pieOne * (p1 * log2(1/p1) + ProbZeroAtOne * log2(1/ProbZeroAtOne));

% W is the window size according to formula provided by Proff
w = n^2*(2^(n*Hx));
w3 = 0;
rem =(3 - mod(ceil(2^(n*Hx)), n)) + ceil( 2^(n*Hx));
if (mod(w,n) == 0)
    w3 = w;
else
    w3 = n^2 * rem;
end

% encoding v1
[encoded1, ~] = LempelZivEncoder1(rawImg, 14, 28);
%decoded1 = LempelZivDecoder1(encoded1, n, w);
compressionRatio1 = length(encoded1)/length(rawImg)

% v2
[encoded2, ~] = LempelZivEncoder2(rawImg, 50, 400);
compressionRatio2 = length(encoded2)/length(rawImg)


% v3
[encoded3, ~] = LempelZivEncoder3(rawImg, 50, 400);
%decoded3 = LempelZivDecoder3(encoded3, n, w3);
compressionRatio3 = length(encoded3)/length(rawImg)

OriginalImg = reshape(rawImg, rSize, cSize); 
% decompressedImg1 = reshape(decoded1, rSize, cSize); 
% decompressedImg3 = reshape(decoded3, rSize, cSize); 
% 
% 
 OriginalImg = ~OriginalImg;
 imshow(OriginalImg);
% decompressedImg1 = ~decompressedImg1;
% decompressedImg3 = ~decompressedImg3;
% 
% str10 = strcat(', pMatch = ', num2str(P_match1)); 
% str11 = strcat(num2str(compressionRatio1), str10);
% 
% str30 = strcat(', pMatch = ', num2str(P_match3)); 
% str31 = strcat(num2str(compressionRatio3), str30);

% figure
% suptitle(strcat('Encoder v1 Compression ratio: ', str11));
% subplot(121);
% imshow(OriginalImg);
% title('Before');
% subplot(122);
% imshow(decompressedImg1);
% title('After');
% 
% figure
% suptitle(strcat('Encoder v3 Compression ratio: ', str31));
% subplot(121);
% imshow(OriginalImg);
% title('Before');
% subplot(122);
% imshow(decompressedImg3);
% title('After');
end