function[g_Snu] = maia_detectchangeintbi_parainject(data,S_ref,nu_ref,S_vec,nu_vec,windowsize)
 
    %[mu0,S0,nu0] = (data(370:1150),:);
    
    mu0 = 0;
    S0 = S_ref;
    nu0 = nu_ref;
   
    S = zeros(2,2);
    
    for k = windowsize+1:1:length(data)
        sample = data(k-windowsize:k,:);
        M = length(sample);
        S(:,:) = S_vec(k,:,:);
        nu = nu_vec(k);
        
        for m = 1:1:length(sample)
            datamulti0(m) = (sample(m,:) - mu0)*inv(S0)*(sample(m,:)-mu0)';
            datamulti1(m) = (sample(m,:) - mu0)*inv(S)*(sample(m,:)-mu0)';
        end

        datasum0_nu = sum(log(1+((1/(nu0))*datamulti0)));
        datasum1_nu = sum(log(1+((1/(nu))*datamulti0)));
        
        datasum0_S = sum(log(1+((1/(nu0))*datamulti0)));
        datasum1_S = sum(log(1+((1/(nu0))*datamulti1)));
        
        datasum0_Snu = sum(log(1+((1/(nu0))*datamulti0)));
        datasum1_Snu = sum(log(1+((1/(nu))*datamulti1)));

        g_Snu(k) = 0.5*M*(log(det(S0)) - log(det(S))) -((2+nu)/2)*datasum1_Snu + ((2+nu0)/2)*datasum0_Snu;
   
    
    end

end