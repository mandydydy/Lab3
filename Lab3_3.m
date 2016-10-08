clear all
clc

load winemat2.mat
test_data=[X, y'];
figure;
hold on;
plot(test_data(:,1), test_data(:,2), '.');
T=6;
[mu sigma] = bayes(test_data);
pt = prior(test_data);

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
g = discriminant(test_data, mu, sigma, pt);
% OR your Adaboost discriminant
% where g returns the PREDICTED CLASS
% g = adaboost_discriminant(test_data, mu, sigma, p, alpha, classes, T)
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
    plot(X(idx,1), X(idx,2),'x','Color',colorList(3+class,:)); hold on,
end