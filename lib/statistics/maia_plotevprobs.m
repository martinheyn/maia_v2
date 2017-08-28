function [] = maia_plotevprobs(x,blocksize)

    h = figure
    maia_plotweib(x,blocksize,h);
    
    g = figure
    maia_plotfrech(x,blocksize,g);
    
    k = figure
    maia_plotgumb(x,blocksize,k);
    

end

function [] = maia_plotweib(x,blocksize,h)
lambda = 1.01*max(x);

F=edf(x);

u = -log(lambda-F(:,1));
v = -log(-log(F(:,2)));


p_label = [0.01 0.2 0.4 0.6 0.8 0.9 0.95 0.98 0.99 0.995 0.999];
p_return_label = (blocksize/100).*(1./(1-p_label)); % Return period is tau = 1/(1-p)
p_label_inv = -log(-log(p_label));

x_label_inv = linspace(min(u),max(u),6);
x_label = round(lambda-exp(-x_label_inv),3);

yyaxis left
h=plot(u,v,'b.','markersize',12);
hold on
grid on

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Probability')

[f,gof] = fit(u,v,'poly1');

a = f.p1;
b = f.p2;

CI = confint(f);

vf = a.*u + b;
vb = CI(1,1).*u + CI(1,2);
vc = CI(2,1).*u + CI(2,2);

text(0.98,0.05,strcat('R^2: ',' ',num2str(gof.rsquare)),'Units','normalized','HorizontalAlignment','right','FontSize',10)

yyaxis right
h=plot(u,vf,'r-');

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_return_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Return Period [s]')


%h=plot(u,vb,'k--');
%h=plot(u,vc,'k--');

title('Weibull Probability Plot')
xlabel('Acceleration in [m/s^2]')

end

% Function for Frechet Paper (x is data, h is handle to figure)
function [] = maia_plotfrech(x,blocksize,h)
if min(x) <= 0
    lambda = 1.05*min(x);
else
    lambda = 0*min(x);
end

F=edf(x); %Empirical distribution function

u = log(F(:,1)-lambda);
v = -log(-log(F(:,2)));

p_label = [0.01 0.2 0.4 0.6 0.8 0.9 0.95 0.98 0.99 0.995 0.999];
p_return_label = (blocksize/100).*1./(1-p_label); % Return period is tau = 1/(1-p)
p_label_inv = -log(-log(p_label));

x_label_inv = linspace(min(u),max(u),6);
x_label = round((exp(x_label_inv)+lambda),3);

yyaxis left
h=plot(u,v,'b.','markersize',12);
hold on
grid on

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Probability')

[f,gof] = fit(u,v,'poly1');
text(0.98,0.05,strcat('R^2: ',' ',num2str(gof.rsquare)),'Units','normalized','HorizontalAlignment','right','FontSize',10)

a = f.p1;
b = f.p2;

CI = confint(f);

vf = a.*u + b;
vb = CI(1,1).*u + CI(1,2);
vc = CI(2,1).*u + CI(2,2);

yyaxis right
h=plot(u,vf,'r-');
%h=plot(u,vb,'k--');
%h=plot(u,vc,'k--');

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_return_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Return Period [s]')

title('Frechet Probability Plot')
xlabel('Acceleration [m/s^2]')

% Function for Gumbel Paper (x is data, h is handle to figure)

end

function [] = maia_plotgumb(x,blocksize,h)

F=edf(x);

p_label = [0.01 0.2 0.4 0.6 0.8 0.9 0.95 0.98 0.99 0.995 0.999];
p_return_label = (blocksize/100).*1./(1-p_label); % Return period is tau = 1/(1-p)
p_label_inv = -log(-log(p_label));

x_label = round(linspace(min(x),max(x),6),3);
x_label_inv = x_label;

u = F(:,1);
v = -log(-log(F(:,2)));

yyaxis left
h=plot(u,v,'b.','markersize',12);
hold on
grid on

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Probability')

[f,gof] = fit(u,v,'poly1');
text(0.98,0.05,strcat('R^2: ',' ',num2str(gof.rsquare)),'Units','normalized','HorizontalAlignment','right','FontSize',10)

a = f.p1;
b = f.p2;

CI = confint(f);

vf = a.*u + b;
vb = CI(1,1).*u + CI(1,2);
vc = CI(2,1).*u + CI(2,2);

yyaxis right
h=plot(u,vf,'r-');
%h=plot(u,vb,'k--');
%h=plot(u,vc,'k--');

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_return_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Return Period [s]')

title('Gumbel Probability Plot')
xlabel('Acceleration [m/s^2]')

end
