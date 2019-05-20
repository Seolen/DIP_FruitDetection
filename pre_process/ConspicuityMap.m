function F_c = ConspicuityMap(F, visualize)
%Intergrated feature maps computation from low-level features
%   Shuailin Li, May 15, 2019
% Input: feature map F (general 'double' datatype)
% Output: feature map Fc£¬ range(0,1)

if (nargin<2)
    visualize = 0;
end

F = rescale(F);

% local points region       
% Approach:     reconstuct the image with phase values of frequency spectrum
% Intention:    eliminate the influence of magnititude specturm and get the region of interest
G=fft2(double(F));
% FG=abs(fftshift(G));
PG=angle(G);
IPG=ifft2(exp(1j*PG));
F_local = abs(IPG);
% figure; imshow(F_local, [])

% global points region      
% Approach:     amplify region values which are salient in distribution
% Intention:    get the most probable location of the fruit region
m = mean(F(:));
F_global = exp((abs(F)-m) / m);
% figure; imshow(F_global, [])

% rare points region    [do we really need it?]
% Approach:     inverse of the histogram of the feature map
% Intention:    As rare feature values. (Instead, local and global points as novel feature values)
x = int16(rescale(F).*255);
a = unique(x);
[M, N] = size(x);
freq = double(histc(x(:),a) ./ (M*N));
freq_inv = 1.0./freq;
F_rare = zeros(M, N);
[M, N] = size(a);
for i=1: M
    F_rare(x==a(i)) = freq_inv(i);
end
% figure; imshow(F_rare, [])

% combined conspicuity map
% Approach:     weighted sum of three fature points, where weight calculated using each variance
% Intention:    The higher the variance is the more important the feature points are

% rescale
F_local = rescale(F_local);
F_global = rescale(F_global);
F_rare = rescale(F_rare);

variance = [var(F_local(:)), var(F_global(:)), var(F_rare(:))];
w = variance ./ sum(variance);
F_c = w(1) .* F_local + w(2) .* F_global + w(3) .* F_rare;

% visualization
if (visualize == 1)
    figure;
    subplot(2,2,1); imshow(F_local, []); title('F_{local}');
    subplot(2,2,2); imshow(F_global, []); title('F_{global}');
    subplot(2,2,3); imshow(F_rare, []); title('F_{rare}');
    subplot(2,2,4); imshow(F_c, []); title('Fc');
end

end

