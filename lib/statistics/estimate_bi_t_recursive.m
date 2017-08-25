function [mu,S,nu,p] = estimate_bi_t_recursive(data,windowsize)

%% Output: pd_t = [mu,S,nu,p-value_marginalx1,p-value_marginalx2]

%%

% Create empty vectors with correct size
sample = zeros(windowsize,2);
mu = zeros(length(data),2);
S = zeros(length(data),2,2);
nu = zeros(length(data),1);
p_x1 = zeros(length(data),1);
p_x2 = zeros(length(data),1);

mu_temp = [0,0];
S_temp = zeros(2,2);
nu_temp = 0;
	
% Perform blockwise processing
	for k = windowsize+1:1:length(data)
        sample = data(k-windowsize:k,:);
        
        % Parameter estimation bivariate t-distribution
        [mu_temp(:),S_temp(:,:),nu_temp] = fitt(sample);
        S_temp = sqrt(abs(S_temp));
        
        mu(k,:) = mu_temp;
        S(k,:,:) = S_temp;
        nu(k) = nu_temp;
        
        % Estimate testing marginal t distribution
        test_cdf = makedist('tlocationscale','mu',mu_temp(1),'sigma',S_temp(1,1),'nu',nu_temp);
        [m,p_x1(k),ksstest,cv] = kstest(sample(:,1),'CDF',test_cdf);
        clear test_cdf
        test_cdf = makedist('tlocationscale','mu',mu_temp(2),'sigma',S_temp(2,2),'nu',nu_temp);
        [m,p_x2(k),ksstest,cv] = kstest(sample(:,2),'CDF',test_cdf);
        clear test_cdf
        
    end

p = [p_x1,p_x2];

end