function[g] = maia_detectchangeint(data,pd_t,windowsize)
 
    [mu0,S0,nu0] = fitt(data);
    M = length(data);
    
    for k = windowsize+1:1:length(data)
        sample = data(k-windowsize:k,:);
        mu = pd_t(k,1);
        S = pd_t(k,2);
        nu = pd_t(k,3);
        
        datasum0 = sum(log(1+(1/(nu0*S0)*(sample-mu0).^2)));
        datasum = sum(log(1+(1/(nu*S0)*(sample-mu0).^2)));
        
        g(k) = -((2+nu)/2)*datasum + ((2+nu0)/2)*datasum0;       
        
    end

end