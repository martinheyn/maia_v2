function[filteredcolbar] = maia_gp_meanfiltered(colorbarinfo,windowsize)

count = zeros(3,1);

filteredcolbar = zeros(size(colorbarinfo));


for k = windowsize+1:1:size(colorbarinfo)
    
    datawindow = colorbarinfo(k-windowsize:k-1);
    
    count(1) = size(find(datawindow == 1),1);
    count(2) = size(find(datawindow == 2),1);
    count(3) = size(find(datawindow == 3),1);
    
    [counti,pos] = max(count);
    
    switch pos
        case 1
            filteredcolbar(k) = 1;
        case 2
            filteredcolbar(k) = 2;
        case 3
            filteredcolbar(k) = 3;
    end
end
% 
% colmap = [1,1,1;0,0.45,0.74;0.92,0.28,0.29;1,1,0];
% h=figure
% heatmap(filteredcolbar');
% colormap(colmap);
% %ylabel({'Side of';'ice action'})
% set(gca,'FontSize',12,'FontName','Times New Roman')
% 


end