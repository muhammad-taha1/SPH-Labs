function unifrom_gaussian_adder

uniform_noise = [];
for k = 1:1000
        uniform_noise =  [sum(-1 + rand(6,1)*2) uniform_noise];
end
figure
hist(uniform_noise)

end