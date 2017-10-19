function[g_nu,g_S,g_Snu] = maia_detectchangeintmarginal(data,S_mar,nu_bi,windowsize)

    cutdata = data(370:1150,:);
    [mu0,S0,nu0] = fitt(cutdata);
    %S0 = sqrt(S0);
    
    for k = windowsize+1:1:length(data)
        sample = data(k-windowsize:k,:);
        S = S_mar(k);
        %S = sqrt(S);
        nu = nu_bi(k);
        
        datasum0_nu = sum(log(1+(1/(nu0*(S0))*(sample-mu0).^2)));
        datasum1_nu = sum(log(1+(1/(nu*(S0))*(sample-mu0).^2)));
        
        datasum0_S = sum(log(1+(1/(nu0*S0))*(sample-mu0).^2));
        datasum1_S = sum(log(1+(1/(nu0*S)*(sample-mu0).^2)));
        
        datasum0_Snu = sum(log(1+(1/(nu0*S0))*(sample-mu0).^2));
        datasum1_Snu = sum(log(1+(1/(nu*S)*(sample-mu0).^2)));
        
        g_nu(k) =  - ((2+nu)/2)*datasum1_nu + ((2+nu0)/2)*datasum0_nu;
        g_S(k) = 0.5*(log(abs(S0)) - 0.5*log(abs(S))) - ((2+nu0)/2)*datasum1_S + ((2+nu0)/2)*datasum0_S;
        g_Snu(k) = 0.5*(log(abs(S0)) - 0.5*log(abs(S))) - ((2+nu)/2)*datasum1_Snu + ((2+nu0)/2)*datasum0_Snu;
        
    end

end