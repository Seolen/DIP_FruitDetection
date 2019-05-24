function outImg = kmeansSeg(inputFeature, OptimalK)
% Binary segmentation on feature map using kmeans.
% Note that it is unceartain which class is fruit. Currently, we set
% foreground as fruit.

warning off;
X1 = imgaussfilt(inputFeature, 1);
X1 = reshape(X1, size(inputFeature,1)*size(inputFeature,2),1);
X0 = reshape(inputFeature, size(inputFeature,1)*size(inputFeature,2),1);
X =  cat(2, X0, X1);
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