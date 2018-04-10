function [blockmax,mleev] = maia_recursiveev(data,timevect,windowlength,blocklength,frequency)

L = length(data);

mleev.windowlength = windowlength;
mleev.blocklength = blocklength;
mleev.frequency = frequency;
%blockmax = zeros(L,);
mleev.estimate = zeros(L,3);
mleev.CIdown = zeros(L,3);
mleev.CIup = zeros(L,3);
mleev.ks = zeros(L,2);
mleev.matdatenum = timevect;
%mleevSEs = zeros(L,3);

for k = 1+windowlength:1:L
    
    if mod(k,1000) == 0
    k    
    end
    
    datawindow = data(k-windowlength:k);
    blockmax(k,:) = maia_blockandmax(datawindow,blocklength,'bla');
    
    [mleevtemp,mleevCItemp] = gevfit(blockmax(k,:));
    mleev.estimate(k,:) = mleevtemp;
    mleev.CIdown(k,:) = mleevCItemp(1,:);
    mleev.CIup(k,:) = mleevCItemp(2,:);
    
    % KS Test
    test_cdf = [blockmax(k,:);gevcdf(blockmax(k,:),mleevtemp(1),mleevtemp(2),mleevtemp(3))]';
    [mleev.ks(k,1),mleev.ks(k,2)] = kstest(blockmax(k,:),'CDF',test_cdf,'Alpha',0.05);
    
    
%     [~,mleevACOVtemp] = gevlike(mleevtemp,blockmax);
%     mleevSEs(k,:) = sqrt(diag(mleevACOVtemp));
end

end