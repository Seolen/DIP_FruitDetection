function [W_final, optimalK] = getFeatureWeight(Fc, max_cluster)
%Get weight of conspicious feature map F
%   Input: F, double ,feature map
%   Output: W_final assigned to F, a double scalar, taking account of local points,
%   global points and distribution of F.

if (nargin<2)
    max_cluster = 20;
end
warning off;

% useful points W_A
T = mean(Fc(:));    % useful points
W_A = Fc>T; % it is a mask

% location cirterion W_L
[M, N] = size(W_A);
location_center = [[floor(M/2)+1, floor(N/2)+1]];
[row, col] = find(abs(W_A) > 0.001);
X = cat(2, row, col);
W_L = pdist2(X, location_center);   % Eucleadian distance, Size(X)*1
W_L_mean = mean(W_L(:));

% cluster distribution
klist=1:max_cluster;%the number of clusters you want to try
myfunc = @(X,K)(kmeans(X, K));
eva = evalclusters(X,myfunc,'CalinskiHarabasz','klist',klist);
% classes=kmeans(X,eva.OptimalK);

optimalK = eva.OptimalK;
[idx,C,sumd,D] = kmeans(X, eva.OptimalK);    % returns distances from each point to every centroid in the n-by-k matrix D
% W_D = min(D, [], 2);    % n-by-1
W_D = sum(sumd(:)) ./ size(row);

% integration, note that three variables must be the same quantity level.
W_A_scalar = sqrt(sum(W_A(:)));
W_L_scalar = W_L_mean;
W_D_scalar = W_D(1);
W_final = W_A_scalar + W_L_scalar + W_D_scalar;

end

