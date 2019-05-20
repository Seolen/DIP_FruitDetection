%%
clear;
citrus=imread('citrus_3.jpeg');
citrusGray=rgb2gray(citrus);
figure;imshow(citrus);
%% Extract of Intensity and Color Features
citrusHSV=rgb2hsv(citrus);
colorFeature1=citrusHSV(:,:,1);
colorFeature2=citrusHSV(:,:,2);
intensityFeature=citrusHSV(:,:,3);

figure;
subplot(3,1,1); imshow(colorFeature1);title('color Feature 1');
subplot(3,1,2); imshow(colorFeature2);title('color Feature 2');
subplot(3,1,3); imshow(intensityFeature);title('intensity Feature');

%% Extract of Orientation Features
wavelength = 4;
orientation = 0; %0 45 90 135
[mag,phase] = imgaborfilt(citrusGray,wavelength,orientation);
figure;
subplot(1,2,1);imshow(mag,[]);title('Gabor magnitude');
subplot(1,2,2);imshow(phase,[]);title('Gabor phase');
%% Extract of Edge Features
edgeFeature=edge(citrusGray,'Canny');
figure;imshow(edgeFeature);title('edge Feature');
