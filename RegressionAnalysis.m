% init params
N = 1000; % sample size
muX = 12; % params explanatory variable
sigmaX = 2.3;
coeff = 0.8; % regression coefficient

intcept = 4.3; % regression intercept
% simulate explanatory variable
X = normrnd(muX,sigmaX,N,1);
% simulate standard normally distributed innovations
epsilon = randn(N,1);
% calculate Y according to linear model
Y = intcept + coeff*X + epsilon; 
%Parameters are estimated on the basis of values simulated.
% because of intercept, expand matrix of explanatory variables
X = [ones(N,1) X];
% OLS estimation
paramsHat = inv(X'*X)*X'*Y; % usual estimation formula
% avoiding single matrix inversion as mlint warning suggests
paramsHat2 = (X'*X)\(X'*Y); % faster way
paramsHat3 = X\Y; % best way
% calculate regression line
xLimits = [floor(min(X(:,2))) ceil(max(X(:,2)))]; % use nearest
% neighbouring integer numbers
grid = xLimits(1):0.1:xLimits(2);
vals = paramsHat(1)+paramsHat(2)*grid;
% plotting data
close
scatter(X(:,2),Y,'.'); % used for visualizing points cloud
% include regression line
hold on; 
plot(grid,vals,'LineWidth',2,'Color','r')
set(gca,'xLim',xLimits)
xlabel('regressor variable')
ylabel('dependent variable')
title(['Linear model: estimated beta is ' num2str(paramsHat(2))])