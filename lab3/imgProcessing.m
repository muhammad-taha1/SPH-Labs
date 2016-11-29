
img = imread('Baboon__grey_scale.jpg'); 
img = rgb2gray(img);
img = cast(img, 'double'); 
img = img./max(max(img)); % normalize elements image depending on Matlab Version
%imshow(img);

[rSize cSize] = size(img); 

%% Sub-sampling
%Sub-sample Image by 2:1, 4:1, 8:1, and 16:1 ratios.
%It's in 2-D: sample in one dimention then in another 

subSampledImg2 =[];
subSampledImg4 =[];
subSampledImg8 =[];
subSampledImg16 =[];
i2 = 0; 
i4 = 0; 
i8 = 0; 
i16 = 0; 
j2 = 0; 
j4 = 0; 
j8 = 0; 
j16 = 0; 

for i = 1: rSize   
    i2 = i2 + 1; 
    for j = 1: cSize
        if(mod(j,2) == 0)            
            j2 = j2 + 1;
            subSampledImg2(i2, j2) = img(i,j);         
        end  
    end
    j2 =0;
    if(mod(i, 2) == 0)
        i4 = i4 + 1; 
        i8 = i8 + 1;
        for j = 1 : cSize
            if(mod(j, 2) == 0) 
                j4 = j4 + 1; 
                subSampledImg4(i4, j4) = img(i,j);
            end
            if(mod(j, 4) == 0)
                j8 = j8 + 1; 
                subSampledImg8(i8, j8) = img(i,j);
            end
        end
        j4 =0; 
        j8= 0; 
    end
    if(mod(i, 4) == 0)
        i16 = i16 + 1;   
        for j = 1 : cSize
            if(mod(j, 4) == 0)
                j16 = j16 + 1;                 
                subSampledImg16(i16, j16) = img(i,j); 
            end
        end
        j16 =0;
    end
end

% figure
% imshow(subSampledImg2);
% figure
% imshow(subSampledImg4);
% figure
% imshow(subSampledImg8);
%figure
%imshow(subSampledImg16);

%% Quantization
% Quantize to 6, 4, 2, and 1 bit per pixel. 
% This is done by making ranges 

quantisedImgBy1 = []; 
quantisedImgBy2 = [];
quantisedImgBy4 = [];
quantisedImgBy6 = [];

for i = 1: rSize 
    for j = 1: cSize
        if((0<= img(i,j)) && (img(i,j) < 0.5))
            quantisedImgBy1(i, j)  = 0.25; 
            if((0<= img(i,j)) && (img(i,j) < 0.25))
                quantisedImgBy2(i,j) = 0.125; 
                if((0<= img(i,j)) && (img(i,j) < 0.125))
                    if((0<= img(i,j)) && (img(i,j) < 0.0625))
                        quantisedImgBy4(i,j) = 0.03125;
                    else
                        quantisedImgBy4(i,j) = 0.09375;
                    end
                else
                    if((0.125<= img(i,j)) && (img(i,j) < 0.1875))
                        quantisedImgBy4(i,j) = 0.15625;
                    else
                        quantisedImgBy4(i,j) = 0.21875;
                    end
                end
            else
                quantisedImgBy2(i,j) = 0.375;
                if((0.25<= img(i,j)) && (img(i,j) < 0.375))
                    if((0.25<= img(i,j)) && (img(i,j) < 0.3125))
                        quantisedImgBy4(i,j) = 0.28125;
                    else
                        quantisedImgBy4(i,j) = 0.34375;
                    end
                else
                    if((0.375<= img(i,j)) && (img(i,j) < 0.4375))
                        quantisedImgBy4(i,j) = 0.40625;
                    else
                        quantisedImgBy4(i,j) = 0.46875;
                    end
                end
            end
        else 
            quantisedImgBy1(i, j)  = 0.75;
            if((0.5<= img(i,j)) && (img(i,j) < 0.75))
                quantisedImgBy2(i,j) = 0.625; 
                if((0.5<= img(i,j)) && (img(i,j) < 0.625))
                    if((0.5<= img(i,j)) && (img(i,j) < 0.5625))
                        quantisedImgBy4(i,j) = 0.53125;        
                    else
                        quantisedImgBy4(i,j) = 0.59375;
                    end
                else
                    if((0.625<= img(i,j)) && (img(i,j) < 0.6875))
                        quantisedImgBy4(i,j) = 0.65625;
                    else
                        quantisedImgBy4(i,j) = 0.71875;
                    end
                end
            else
                quantisedImgBy2(i,j) = 0.875;
                if((0.75<= img(i,j)) && (img(i,j) < 0.875))
                    if((0.75<= img(i,j)) && (img(i,j) < 0.8125))
                        quantisedImgBy4(i,j) = 0.78125;        
                    else
                        quantisedImgBy4(i,j) = 0.84375;
                    end
                else
                    if((0.875<= img(i,j)) && (img(i,j) < 0.9375))
                        quantisedImgBy4(i,j) = 0.90625;
                    else
                        quantisedImgBy4(i,j) = 0.96875;
                    end
                end
            end    
        end
    end
end
%Quantize by 6
for i = 1: rSize 
    for j = 1: cSize
        for q = 1 : 64 
            if((0.015625*(q-1) <= img(i,j)) && (img(i,j) < 0.015625*q))
                quantisedImgBy6(i,j) = 0.015625*(q-1) + 0.051625/2;    
                break; 
            else
                if((0.984375 <= img(i,j)) && (img(i,j) <= 1))
                    quantisedImgBy6(i,j) = 0.9921875;  
                    break;
                end
            end 
        end
    end
end

figure
imshow(quantisedImgBy1);
figure
imshow(quantisedImgBy2);
figure
imshow(quantisedImgBy4);
figure
imshow(quantisedImgBy6);
