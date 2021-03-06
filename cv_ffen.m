function yfit = cv_ffen( xtrain,ytrain,xtest, alpha,lambda2, para,sigma, use_spiral, options )
% xtrain: rows are samples, columns are variables
% ytrain: vector of labels
% xtest: same as xtrain
% alpha: see docs for LASSO
% lambda2: see docs for LASSO
% fits a FFEN model and predicts the labels for xtest

% if options.UseParallel
%     xtrain = gpuArray(xtrain);
%     xtest = gpuArray(xtest);
% end
phitrain = FastfoodForKernel(xtrain',para,sigma,use_spiral)'; % calculate the projections of the training samples
B = lasso(phitrain,ytrain,'alpha',alpha,'lambda',lambda2,'options',options); % perform LASSO on the projections to learn regression coefficients
phitest = FastfoodForKernel(xtest',para,sigma,use_spiral)'; % calculate the projections of the testing samples
% if options.UseParallel
%     phitest = gpuArray(phitest);
% end
yfit = phitest*B; % perform regression