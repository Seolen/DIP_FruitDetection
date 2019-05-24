function outImg = kmeansSeg3(inputFeature, OptimalK)
% Binary segmentation on feature map using kmeans.
% Note that it is unceartain which class is fruit. Currently, we set
% foreground as fruit.

warning off;
% gaussian pyramid
sigma1 = 1; sigma2 = 2; sigma3 = 3;
g1 = imgaussfilt(inputFeature, sigma1);
g2 = imgaussfilt(inputFeature, sigma2);
g3 = imgaussfilt(inputFeature, sigma3);
X1 = reshape(g1, size(inputFeature,1)*size(inputFeature,2),1);
X2 = reshape(g2, size(inputFeature,1)*size(inputFeature,2),1);
X3 = reshape(g3, size(inputFeature,1)*size(inputFeature,2),1);
X0 = reshape(inputFeature, size(inputFeature,1)*size(inputFeature,2),1);

X = cat(2, X1, X2, X3, X0);
% klist=1:20;%the number of clusters you want to try
% myfunc = @(X,K)(kmeans(X, K));
% eva = evalclusters(X,myfunc,'CalinskiHarabasz','klist',klist);
% optimalK = eva.OptimalK;

if (nargin<2)
    OptimalK = 2;
end

[idx,C,sumd,D] = kmeans(X, OptimalK);

outImg = reshape(idx, size(inputFeature,1), size(inputFeature,2));

end