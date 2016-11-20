
img = imread('Baboon__grey_scale.jpg'); 
img = rgb2gray(img);
img = cast(img, 'double'); 
img = img./max(max(img)); % normalize eimmage depending on Matlab Version
imshow(img);

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

%imshow(subSampledImg2);
%imshow(subSampledImg4);
%imshow(subSampledImg8);
%imshow(subSampledImg16);