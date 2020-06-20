clc
clear

filesepChar = filesep;

str = input('Main directory path: ','s');         
if(exist(str,'dir'))
         mainDir = str;
else
    break
end

cd(mainDir)
load('probability_testcase_realized.mat')
load('expectedSavingsTable');

 %exclu=[3:180]; %exclude may 2%w wind cases,exclu=[5,11,17,23,29,35,41,47,53];
% exclu=exclu+[1,1,1,1,1,1,1,1];
 %probability(exclu,:)=[];


averageCostSavings=[];
CostSavingsPerScn=[];
CostSavingsPerScn_abs = [];
averageStoCost=[];
averageDetCost=[];
for temp =1:10
load(['output_totalSavingsScenario' num2str(temp)])
CostSavingsPerScn_abs = [CostSavingsPerScn_abs totalSavingsTable(:,6)];
CostSavingsPerScn = [CostSavingsPerScn probability_realized(:,temp).*totalSavingsTable(:,6)];
averageStoCost = [averageStoCost probability_realized(:,temp).*totalSavingsTable(:,5)];
averageDetCost = [averageDetCost probability_realized(:,temp).*totalSavingsTable(:,4)];
%scatter(totalSavingsTable(:,1),totalSavingsTable(:,6))
end


 averageStoCost = sum(averageStoCost,2);
 averageDetCost = sum(averageDetCost,2);
 averageCostSavings = sum(CostSavingsPerScn,2);

%% std of cost savings 
[n,k] = size(averageCostSavings);

varSavings = zeros(n,1);
 
for temp =1:10 
for ncase = 1:n
     varSavings(ncase) = varSavings(ncase) + ((CostSavingsPerScn_abs(ncase,temp) - averageCostSavings(ncase))^2) * probability_realized(ncase,temp);
end
end

stdCostSavings= sqrt(varSavings);
 
 AverageCostSavingsTable=[totalSavingsTable(:,1:3),averageDetCost,averageStoCost,averageCostSavings,stdCostSavings];
% AverageCostSavingsTable(:,1) =  AverageCostSavingsTable(:,1).*1000;
save(['output_AverageCostSavingsTable'],'AverageCostSavingsTable');
h=figure(1);
hold on
%grid on

plot(expectedSavings(1:16,2), AverageCostSavingsTable(1:16,6),'linewidth', 2)
width = 20;     % Width in inches
height = 10;    % Height in inches
alw = 1;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize
pos = get(gcf, 'Position');

set(gcf, 'Position', [0 0 width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperType', 'A4');

hXLabel = xlabel('Reserve Requirement (\% of peak load)','FontSize',18,'interpreter','latex');
hYLabel = ylabel('Average Cost Savings (\%)','FontSize',18,'interpreter','latex');

saveas(gcf,['Figures-test' filesepChar 'Savings'],'jpg')
saveas(gcf,['Figures' filesepChar 'Savings'],'eps')
saveas(gcf,['Figures' filesepChar 'Savings'],'fig')
    
%  %% std of $
% outputSto=[];
% outputDet=[];
% 
% for temp =1:5
% load(['output_totalSavingsScenario' num2str(temp)])
% outputSto = [outputSto totalSavingsTable(:,5)];
% outputDet = [outputDet totalSavingsTable(:,4)];
% end
% 
% n = noRows;
% varianceDet = zeros(n,1);
% varianceSto = zeros(n,1);
% 
% for ncase=1:n   
% for temp = 1:5
% 
%     varianceDet(ncase) = varianceDet(ncase) + ((outputDet(ncase,temp) - averageDetCost(ncase))^2) * probability(ncase,temp);
%     varianceSto(ncase) = varianceSto(ncase) + ((outputSto(ncase,temp) - averageStoCost(ncase))^2) * probability(ncase,temp);
% 
% end
% end
% 
% 
% ansStandDevSto = sqrt(varianceSto);
% ansStandDevDet = sqrt(varianceDet);
% 
% excel1Sto=ansStandDevSto(find(totalSavingsTable(:,2)==1));
% excel2Sto=ansStandDevSto(find(totalSavingsTable(:,2)==5));
% excel1Det=ansStandDevDet(find(totalSavingsTable(:,2)==1));
% excel2Det=ansStandDevDet(find(totalSavingsTable(:,2)==5));
% 
% % clc;
% % clear;
% 
% %% 
% n = noRows;
% ansStandDev = zeros(n,1);
% load(['output_averageCostSavings']);
% load(['probability_testcase']);
% for ncase=1:n   
%     for scn=1:5
%         load(['output_totalSavingsScenario' num2str(scn)]);
%         ansStandDev(ncase) = ansStandDev(ncase) + ((averageCostSavings(ncase,4) - totalSavingsTable(ncase,6))^2)*probability(ncase,scn);
% %    avgPercentObjVal = [avgPercentObjVal; sum(percentObjVal(idx1))];
%     end
% end
% 
% ansStandDev = sqrt(ansStandDev);
