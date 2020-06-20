%% Dheepak Krishnamurthy
% Plot load 10 scenarios and reduced scenarios

clear
clc
filesepChar = filesep;

load('../data/loadData/LoadData_Plots')
totalLoadDataRealized = sum(loadDataRealized,3);
totalLoadData = sum(loadData,3);

for i = 1:length(totalLoadDataRealized(1,:))
hLine1 = plot(totalLoadDataRealized(:,i),'-.r*','LineWidth',2);
    if i == 1
        hold on
    end
end

for i = 1:length(totalLoadData(1,:))
hLine5 = plot(totalLoadData(:,i),'b','LineWidth',2);
end

legend([hLine5,hLine1], '5 Scenarios', '10 Scenarios')

hXLabel = xlabel(' Hours (H) ','FontSize',18,'interpreter','latex');
hYLabel = ylabel(' Load (MW) ','FontSize',18,'interpreter','latex');

title('Load Profile for two consecutive days','FontSize',18,'interpreter','latex')
width = 9.5;     % Width in inches
height = 6.5;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize
pos = get(gcf, 'Position');
set(gcf, 'Position', [0 0 width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties



%Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);




set(gcf, 'PaperPositionMode', 'auto');


print('-depsc',['loadPlot'])
print('-djpeg',['loadPlot'])
   


