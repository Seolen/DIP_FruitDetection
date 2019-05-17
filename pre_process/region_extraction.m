%
%   Intergrated feature maps computation from low-level features
%   Shuailin Li, May 15, 2019

% Input: feature map F (general 'double' datatype)
% Output: feature map Fc

% local points region       
% Approach:     reconstuct the image with phase values of frequency spectrum
% Intention:    eliminate the influence of magnititude specturm and get the region of interest
G=fft2(double(F));
G=abs(fftshift(G));
PG=angle(G);
IPG=ifft2(exp(j*PG));
F_local = IPG;

% global points region      
% Approach:     amplify region values which are salient in distribution
% Intention:    get the most probable location of the fruit region
m = mean(F(:));
F_global = exp((abs(F)-m) / m)

% rare points region    [do we really need it?]
% Approach:     inverse of the histogram of the feature map
% Intention:    As rare feature values. (Instead, local and global points as novel feature values)
x = int8(F);
a = unique(x);
[M, N] = size(x);
freq = double(histc(x(:),a) ./ (M*N));
freq_inv = 1.0./freq;
F_rare = zeros(M, N);
[M, N] = size(a);
for i=1: M
    F_rare(x==a(i)) = freq_inv(i);
end

% combined conspicuity map
% Approach:     weighted sum of three fature points, where weight calculated using each variance
% Intention:    The higher the variance is the more important the feature points are
var = [var(F_local(:)), var(F_global(:)), var(F_rare(:))];
w = var ./ sum(var);
F_c = w(1) * F_local + w(2) * F_global + w(3) * F_rare;



% as a module
funtion F_c = ConspicuityMap(F)


end

