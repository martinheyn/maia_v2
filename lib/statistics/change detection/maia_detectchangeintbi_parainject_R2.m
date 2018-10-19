function[g_Snu] = maia_detectchangeintbi_parainject_R2(data,S_ref,nu_ref,S_vec,nu_vec,windowsize)
 
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
            pdf0(m) = (1/(2*pi*sqrt(det(S0))))*(1+((1/nu0)*((sample(m,:) - mu0)*inv(S0)*(sample(m,:)-mu0)')))^(-(2+nu0)/2);
            pdf1(m) = (1/(2*pi*sqrt(det(S))))*(1+((1/nu)*((sample(m,:) - mu0)*inv(S)*(sample(m,:)-mu0)')))^(-(2+nu)/2);
        end
        
        %g_Snu(k) = sum(pdf1.*log(pdf1./pdf0));
        g_Snu(k) = sum(log(pdf1./pdf0));
    end

end