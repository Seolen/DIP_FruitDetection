function [hueFeature, satFeature, valueFeature] = HSVfeature(image)
%Get feature map of an image, such as color feature, intensity feature and
%edge feature
%Input: image:rgb image; type:hue|saturation|lightness

citrusHSV = rgb2hsv(image);
hueFeature = citrusHSV(:,:,1);
satFeature = citrusHSV(:,:,2);
valueFeature = citrusHSV(:,:,3);

end

