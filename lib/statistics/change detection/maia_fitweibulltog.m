function[a,b,KLD,H,h_KLD,h_H] = maia_fitweibulltog(g,windowsize)
% This function fits the Weibull distribution to the detector function g recursively with a given window size

%% THIS APPROACH DOES NOT WORK!

% Create empty vectors with correct size
a = zeros(length(g),4);
b = zeros(length(g),4);
%pci_a = zeros(length(g),2);
%pci_b = zeros(length(g),2);
KLD = zeros(length(g),4);
H = zeros(length(g),4);
h_H = zeros(length(g),1);
h_KLD = zeros(length(g),1);

a_c(1) = 23.768;
b_c(1) = 1.786;
a_c(2) = 47.494;
b_c(2) = 2.905;
a_c(3) = 37.924;
b_c(3) = 1.866;
a_c(4) = 54.677;
b_c(4) = 2.001;

% Perform blockwise processing
    for k = (200+windowsize)+1:1:length(g)
%         pci_a(k,:) = parapci(1,:);
%         pci_b(k,:) = parapci(2,:);
        
       for l = 1:1:4
            sample = g(k-windowsize:k,l);
            sample(sample<=0) = [];
%             if sample(1) <= 0 % HACK HACK HACK
%                 sample(1) = 0.01;
%             end
%             
%             I = find(sample<=0);
%             while ~isempty(I)
%                 sample(I) = sample(I-1); % Hold when value is non-positive
%                 I = find(sample<=0);
%             end
            
            [paratemp,~] = wblfit(sample);
            a(k,l) = paratemp(1);
            b(k,l) = paratemp(2);
            KLD(k,l) = log(b_c(l)/(a_c(l)^b_c(l))) - log(b(k,l)/(a(k,l)^b(k,l))) + (b_c(l) - b(k,l))*(log(a_c(l)) - (0.5772/b_c(l))) + (a_c(l)/a(k,l))^(b(k,l)) * gamma((b(k,l)/b_c(l))+1) - 1; % Kullback-Leibler Divergence
            H(k,l) = 0.5772 * (1-1/b(k,l)) + log(a(k,l)/b(k,l)) + 1; % Entropy 
       end
       [~,I] = min(H(k,:));
       h_H(k) = I;
       [~,I] = min(KLD(k,:));
       h_KLD(k) = I;
       
        
    end


end