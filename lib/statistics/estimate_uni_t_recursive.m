function [pd_n,pd_t] = estimate_uni_t_recursive(data,windowsize)

%% Output: pd_n = [mu,sig,p-value]
%          pd_t = [mu,S,nu,p-value]

%%

% Create empty vectors with correct size
sample = zeros(windowsize,1);
pd_n = zeros(length(data),3);
pd_t = zeros(length(data),4);
	
% Perform blockwise processing
	for k = windowsize+1:1:length(data)
        sample = data(k-windowsize:k,:);
        % Parameter estimation normal distribution
        pd_n_temp = mle(sample,'dist','Normal');
        
        % Estimate testing normal distribution
       	test_cdf = makedist('Normal','mu',pd_n_temp(1),'sigma',pd_n_temp(2));
        [m,p_n,ksstest,cv] = kstest(sample,'CDF',test_cdf);
        pd_n(k,:) = [pd_n_temp,p_n];
        
        % Parameter estimation univariate t-distribution
        [pd_t_temp(1),pd_t_temp(2),pd_t_temp(3)] = fitt(sample);
        pd_t_temp(2) = sqrt(pd_t_temp(2));
        
        % Estimate testing t distribution
        test_cdf = makedist('tlocationscale','mu',pd_t_temp(1),'sigma',pd_t_temp(2),'nu',pd_t_temp(3));
        [m,p_t,ksstest,cv] = kstest(sample,'CDF',test_cdf);
        pd_t(k,:) = [pd_t_temp,p_t];
	end


end