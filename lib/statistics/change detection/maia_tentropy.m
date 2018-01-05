function [H,h] = maia_tentropy(S,nu)

% This function calcuates the entropy of a bivariate t-distribution with
% zero mean, correlation matrix S and degrees of freedom nu.
    H = zeros(length(nu),1);
    h = zeros(length(nu),1);
    temp = zeros(2,2);
    
    for k=1:1:length(nu)
        temp(:,:) = S(k,:,:);
        H(k) = 0.5*log(det(temp)) + log(2*pi) + (1+(2/nu(k)));
    
        if H(k) >= -5.5 % very close ice
            h(k) = 4;
        elseif H(k) >= -7.35 % close ice
            h(k) = 3;            
        elseif  H(k) >= -9.25 % open ice
            h(k) = 2;
        elseif H(k) < -9.25 % open water
            h(k) = 1;
        end
            
    end
    
    
    
        
end