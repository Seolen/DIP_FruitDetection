function [FR_map] = featureIntegration(Features, max_cluster, featureNum)
%Integrate four feature maps of color, intensity, orientation and edge to one final fruit map. 
%   Input: Features, concatenation of four feature maps
%   Output: One fruit map with the same size of original color image
%   Method: 1.compute consipicuity map for each feature map, based on region and boundary -> 2.compute
%   feature weight for each, based on useful points distribution -> 3.weighted sum

if (nargin<2)
    max_cluster = 20;
    featureNum = 4;
end

% feature processing and get weights
visualize = 1;
Weights = [];
for i=1:featureNum
    Fc = ConspicuityMap(squeeze(Features(i, :, :)), visualize);
    [W_final, optimalK] = getFeatureWeight(Fc, max_cluster);    % what if optimalK different?
    Weights = cat(1, Weights, W_final);    
end

% weights normalization and weighted sum
Weights = Weights ./ sum(Weights(:));
FR_map = Weights(1) .* squeeze(Features(1,:,:));
for i=2:featureNum
    FR_map = FR_map + Weights(i) .* squeeze(Features(i,:,:));
end


end

