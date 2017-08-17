%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This functions creates a probability plot and compares to a normal cdf%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%
% Inputs:
% [data] = Acceleration data to be analysed
%
% Outputs:
% [pd_t,pd_l,pd_c] = Fitted probability density function
%  
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-04-07  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%
%http://se.mathworks.com/help/stats/probplot.html?requestedDomain=www.mathworks.com

function [pd_n,pd_t,pd_c] = plotpdfoft(data,h)

	% Normal distribution
	pdrequest = 'Normal';
	pd_n = mle(data,'dist',pdrequest)';
	test_cdf = makedist(pdrequest,'mu',pd_n(1),'sigma',pd_n(2));
	[k,p_n,ksstest,cv] = kstest(data,'CDF',test_cdf);
	pd_n = [pd_n;p_n];

	% t location scale
	pdrequest = 'tlocationscale';
	%pd_t = mle(data,'dist',pdrequest);
	
	[pd_t(1),pd_t(2),pd_t(3)] = fitt(data);
	
	pd_t(2) = sqrt(pd_t(2));
	
	pd_t = pd_t';
	if nargin == 2
		probplot(data);

		t = @(data,mu,sig,df)cdf(pdrequest,data,mu,sig,df);
		h = probplot(gca,t,pd_t);
	end

	test_cdf = makedist(pdrequest,'mu',pd_t(1),'sigma',pd_t(2),'nu',pd_t(3));
	
	[k,p_t,ksstest,cv] = kstest(data,'CDF',test_cdf);
	pd_t = [pd_t;p_t];
	
	% Cauchy cdf
	[pd_c,~]= cauchyfit(data);

	pd_c = pd_c';
	if nargin == 3
		p = @(data,a,b)cauchycdf(data,a,b);
		l = probplot(gca,p,pd_c);
	end

	test_cdf = [data,cauchycdf(data,pd_c(1),pd_c(2))];
	[k,p_c,ksstest,cv] = kstest(data,'CDF',test_cdf);
	pd_c = [pd_c;p_c];
	
	
	% Plot all together in one plot
	if nargin == 2
		% Merge all plots together
		h.Color = [1 0 0];
		h.LineStyle = '-';
		h.LineWidth = 1;
		l.Color = [1 0.4 1];
		l.LineStyle = '-.';
		l.LineWidth = 1;

		legend('Gaussian','data','t','Cauchy','Location','NW')
		yticks([-3.291 -2.326 -1.282 0 1.282 2.326 3.291])
		yticklabels({'0.0005','0.01','0.1','0.5','0.9','0.99','0.9995'})
		grid on
		%legend('Normal',datastring,strcat(pdrequest,'(',num2str(pd),'),p-value',{' '},num2str(p)),'Location','NW')
	end
	
end