% concatenate four feature maps
Features = cat(3, colorFeature1, colorFeature2, intensityFeature, mag);
% Features = cat(3, intensityFeature, intensityFeature, intensityFeature, intensityFeature);
Features = permute(Features, [3 1 2]);
% compute final fruit map
FR_map = featureIntegration(Features);
figure; imshow(FR_map, []); title('Final fruit map');

% determine threshold and obtain binary mask
figure; imhist(FR_map);
% look at histogram and determine threshold by hand
T = 0.7; figure; imshow(FR_map>T, []);  % otsu method suffer from over-segmentation