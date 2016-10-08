clear all
clc

load irismat2.mat

% load winemat2.mat
data=[X, y'];

% [mu sigma] = bayes(data);
% p = prior(data);

% Plot decision boundary
classes = unique(y);
% Create grid
xmin = min(X(:,1));
xmax = max(X(:,1));
ymin = min(X(:,2));
ymax = max(X(:,2));
ax = [xmin xmax ymin ymax];

incx = abs(ax(2)-ax(1))/100;
incy = abs(ax(4)-ax(3))/100;
xgr = ax(1):incx:ax(2);
ygr = ax(3):incy:ax(4);
[z1,z2] = meshgrid(xgr, ygr);

% Create decision boundary mask
image_size = size(z1);
z1 = reshape(z1, size(z1,1)*size(z1,2), 1);
z2 = reshape(z2, size(z2,1)*size(z2,2), 1);
% Your discriminant function with your mu?s and Sigmas
% where g returns the PREDICTED CLASS

% % g = discriminant([z1 z2], mu, sigma, p);
% % [dummy class_t] = max(g, [], 2);
% % class_t = class_t - 1;
% % g=class_t
% OR your Adaboost discriminant
% where g returns the PREDICTED CLASS
T = 6;
[mu sigma p alpha classes_t] = adaboost(data, T);
g = adaboost_discriminant([z1 z2], mu, sigma, p, alpha, classes_t, T);


decisionmap = reshape(g, image_size);
% Plot decision boundary
figure;
imagesc(xgr,ygr,decisionmap);
hold on;
set(gca,'ydir','normal');
colormap(getListOfDistinctColors(length(classes)));
% Plot data points
for class = classes
    idx = y == class;
    plot(X(idx,1), X(idx,2),'x'); 
    hold on,
end