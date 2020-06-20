%% AMES Output Reader
% Dheepak Krishnamurthy

% This reads the output from stochastic and deterministic files and 
% plots the power levels of different generators along with the 
% actual and the expected load

clc;
clear all; close all;

currPath = pwd;

%%
userinput_NumOfSlowGen = 62
numOfTestCases = 21

%userinput_NumOfSlowGen = userinput_NumOfSlowGen-1;
filesepChar = filesep;

% MAX_DAY is the total number of days in the simulation
% days between START_DAY and MAX_DAY are used to calculate and plot

MAX_DAY = 3; 
START_DAY = 3;

startDayForCostSavings = START_DAY;
endDayForCostSavings = MAX_DAY;

startcase = 0; % this value has to be zero 

plotLoadCode = 0; 

% If calculation is required for all scenarios, then tempscn =1:5 

% Change mainDir to folder where SimTestCase is located
%str = inputdlg('Enter main directory:',...
%             'Main directory Path');
str = input('Main directory path: ','s');         
if(exist(str,'dir'))
         mainDir = str;
else
    display('Path does not exist')
    break
end
%mainDir = 'C:\LocalFiles\PaperResults-20141207';
display(['Reading files from ' str]);

cd(mainDir)

for tempscn=[1:10] %1:10
totalTableSto = [];
totalTableDet = [];
totalSavingsTable = [];
totalSlowGenTableSto = [];
totalSlowGenTableDet = [];
totalSlowGenSavingsTable = [];
% first case is = 0/1 

%%
%
tempcase=[0:(numOfTestCases-1)]; % list cases output has to be calculated for here [0:53]
% exclu=[5,11,17,23,29,35,41,47]; %exclude may 2%w wind cases,exclu=[5,11,17,23,29,35,41,47,53];
% exclu=exclu+[1,1,1,1,1,1,1,1];
% tempcase(exclu)=[];


printplot=1;

% if plotOn = 0 Figures will be printed in the Figures folder without shan
% if plotOn = 1 Figures will be printed in the Figures folder with shan
% if saveOn = 1 Cost savings read from the files will be saved in a matlab file for each scenario
    
plotOn = 1;
saveOn = 1;

%scenario 2 cmpCASE 1 and 14

% 
% tf_ReserveRequirements(tempcase+1)=5000;
% tf_MonthString(tempcase+1,:) = 'May';

load('probability_testcase_realized')

load('treatmentFactors_WindPen')
load('treatmentFactors_noGen')
load('treatmentFactors_ReserveRequirements')
load('treatmentFactors_MonthString')
load('treatmentFactors_MonthNum')



scalingFactor = 1; %0.41822290769659204;


for cmpCASE = tempcase
disp('cmpCASE')
disp(cmpCASE)
NUM_SLOWGEN = userinput_NumOfSlowGen; tf_REQGEN(cmpCASE+1);

for cmpSCN = tempscn

totalSavings = 0;
totalCostDet = 0;
totalCostSto = 0;
    
plotCapacityAvailSto = [];
plotCapacityAvailDet = [];
plotTotalCapacityAvailSto = [];
plotTotalCapacityAvailDet = [];
plotActualLoad = [];
plotExpectedLoad = [];
plotPowerGenSto = [];
plotPowerGenDet = [];
plotPowerSlowGenSto = [];
plotPowerSlowGenDet = [];

totalCostTableDet = [];
totalCostTableSto = [];

totalSlowGenCostTableDet = [];
totalSlowGenCostTableSto = [];

plotProductionCostSto = [];
plotProductionCostDet = [];
plotStartUpCostSto = [];
plotStartUpCostDet = [];
plotShutDownCostSto = [];
plotShutDownCostDet = [];

totalCostPerDayDet = [];
totalCostPerDaySto = [];
totalSlowGenCostPerDayDet = [];
totalSlowGenCostPerDaySto = [];

totalSavingsPerDay = [];
totalSlowGenSavingsPerDay = [];


for cmpDAY = START_DAY:MAX_DAY


NUM_DARTS=5;
NUM_SCN=5;

cmpDART = (cmpSCN);
cmpMONTH = tf_MonthString(cmpCASE+1,:);
cmpDATE = ['2011-01-0' num2str(cmpDAY)];

%%

currDir = [filesepChar 'SimTestCase' filesepChar 'Output' filesepChar];

%cd([mainDir currDir]);

listOfFiles = dir(fullfile([mainDir currDir '*_Case' num2str(cmpCASE) '*Scenario' num2str(cmpSCN) '*.out']));

len = length(listOfFiles);

for i=1:length(listOfFiles)
    
    num1 = cmpCASE; 
    
    casetypepos = (strfind(listOfFiles(i).name,'Case_'));
    casetype = listOfFiles(i).name((casetypepos+5):(casetypepos+7));
    
    fileID = fopen(fullfile([mainDir currDir listOfFiles(i).name]));
    NUM_GEN = cell2mat(textscan(fileID,['%*f %*f %f %*f'],1,'delimiter','\t','EmptyValue',-Inf,'HeaderLines',8));
    fclose(fileID);
    
    fileID = fopen(fullfile([mainDir currDir listOfFiles(i).name]));
    s = textscan(fileID, '%s', 'delimiter', '\n');
    
    temp = strfind([s{1}],'iMaxDay');
    idx1 = find(~cellfun(@isempty, temp));
    idx2 = idx1+1+24;
    buffer  = s{1}(idx1+1:idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    NUM_DAY = cell2mat(textscan(dataTxt,['%*f %f %*f %*f %*f %*f %*f']));

    %
    
    idx1 = find(strcmp(s{1}, '#GeneratorRealTimeCommitmentDataStart'), 1, 'first');
    idx1 = idx1+2+(cmpDAY-2)*24;
    idx2 = idx1+23;
    buffer  = s{1}(idx1:idx2);
    dataTxt = sprintf('%s\n',buffer{:});
    if(strcmp(casetype,'Sto'))
        powerGenSto = sum([cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_GEN)]))]',1);
        powerSlowGenSto = sum([cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_SLOWGEN) repmat(' %*f',1,NUM_GEN-NUM_SLOWGEN)]))]',1);
    else
        powerGenDet = sum([cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_GEN)]))]',1);
        powerSlowGenDet = sum([cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_SLOWGEN) repmat(' %*f',1,NUM_GEN-NUM_SLOWGEN)]))]',1);
    end
    
    %
    
    idx1 = find(strcmp(s{1}, '#GeneratorSupplyOfferDataStart'), 1, 'first');
    temp = strfind([s{1}],'GenCo10');
    temp = find(~cellfun(@isempty, temp));
    temp = temp(find(temp>idx1));
    idx2 = idx1+2+NUM_SLOWGEN;%temp(1);
    buffer  = s{1}(idx1+2:idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    if(strcmp(casetype,'Sto'))
        genNamesSto = textscan(dataTxt,['%*f %s %*f %*f %*f %*f']);
        capacityGenSto = textscan(dataTxt,['%*f %*s %*f %*f %*f %f']);
    else
        genNamesDet = textscan(dataTxt,['%*f %s %*f %*f %*f %*f']);
        capacityGenDet = textscan(dataTxt,['%*f %*s %*f %*f %*f %f']);
    end
    
    %
    
    idx1 = find(strcmp(s{1}, '#CommitmentDecisionsStart'), 1, 'first');
    temp = strfind([s{1}],'GenCo10 ');
    temp = find(~cellfun(@isempty, temp));
    temp = temp(find(temp>idx1));
    idx2 = idx1+2+NUM_SLOWGEN*(NUM_DAY-1);%temp(1);
    buffer  = s{1}(idx1+2+cmpDAY-2:(NUM_DAY-1):idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    if(strcmp(casetype,'Sto'))
        commitmentVectorSto = textscan(dataTxt,['%*s %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f']);
    else
        commitmentVectorDet = textscan(dataTxt,['%*s %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f']);
    end
    
    %
        idx1 = find(strcmp(s{1}, '#GeneratorSupplyOfferDataStart'), 1, 'first');
%     temp = strfind([s{1}],'#CommitmentDecisionsEnd');
%     temp = find(~cellfun(@isempty, temp));
%     temp = temp(find(temp>idx1));
    idx2 = idx1+2+NUM_GEN;%temp(1);
    buffer  = s{1}(idx1+2:idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    if(strcmp(casetype,'Sto'))
        totalCapacityGenSto = textscan(dataTxt,['%*f %*s %*f %*f %*f %f']);
    else
        totalCapacityGenDet = textscan(dataTxt,['%*f %*s %*f %*f %*f %f']);
    end
    
    %
    
    idx1 = find(strcmp(s{1}, '#CommitmentDecisionsStart'), 1, 'first');
%     temp = strfind([s{1}],'#CommitmentDecisionsEnd ');
%     temp = find(~cellfun(@isempty, temp));
%     temp = temp(find(temp>idx1));
    idx2 = idx1+2+NUM_GEN*(NUM_DAY-1);%temp(1);
    buffer  = s{1}(idx1+2+cmpDAY-2:(NUM_DAY-1):idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    if(strcmp(casetype,'Sto'))
        totalCommitmentVectorSto = textscan(dataTxt,['%*s %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f']);
    else
        totalCommitmentVectorDet = textscan(dataTxt,['%*s %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f']);
    end
    
    % Total cost savings
    
    idx1 = find(strcmp(s{1}, '#ObjectiveCostStart'), 1, 'first');
    idx1 = idx1+1 + (cmpDAY-2);
    idx2 = idx1+1;
    buffer  = s{1}(idx1:idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    if(strcmp(casetype,'Sto'))
        totalCostDaySto = cell2mat(textscan(dataTxt,['The objective function value for day %*f is : %f']));
    else
        totalCostDayDet = cell2mat(textscan(dataTxt,['The objective function value for day %*f is : %f']));
    end
    
    
    
    % Calculate out cost comparison
    
    idx1 = find(strcmp(s{1}, '#GeneratorProductionCostsStart'), 1, 'first');
    idx1=idx1+1;
    idx2 = idx1+NUM_GEN*(NUM_DAY+1);
    buffer  = s{1}(idx1+cmpDAY:(NUM_DAY+1):idx2);
    dataTxt = sprintf('%s\n',buffer{:});
    
    if(strcmp(casetype,'Sto'))
        productionCostSto = sum(cell2mat(textscan(dataTxt,['%*s %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f'])),1);
    else
        productionCostDet = sum(cell2mat(textscan(dataTxt,['%*s %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f'])),1);
    end
    
    idx1 = find(strcmp(s{1}, '#GeneratorStartupCostsStart'), 1, 'first');
    idx1=idx1+2 + (cmpDAY-2)*24;
    idx2=idx1+24-1;
    buffer  = s{1}(idx1:idx2);
    dataTxt = sprintf('%s\n',buffer{:});
    
    if(strcmp(casetype,'Sto'))
        startUpCostSto = [sum(cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_GEN)])),2)]';
    else
        startUpCostDet = [sum(cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_GEN)])),2)]';
    end
    
    idx1 = find(strcmp(s{1}, '#GeneratorShutdownCostsStart'), 1, 'first');
    idx1=idx1+2 + (cmpDAY-2)*24;
    idx2=idx1+24-1;
    buffer  = s{1}(idx1:idx2);
    dataTxt = sprintf('%s\n',buffer{:});
    
    if(strcmp(casetype,'Sto'))
        shutDownCostSto = [sum(cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_GEN)])),2)]';
    else
        shutDownCostDet = [sum(cell2mat(textscan(dataTxt,['%*f %*f' repmat(' %f',1,NUM_GEN)])),2)]';
    end
    
    idx1 = find(strcmp(s{1}, '#GeneratorTotalCostsByTypeStart' ),1,'first');
    idx2 = idx1+2+NUM_GEN*(NUM_DAY-1);%temp(1);
    buffer  = s{1}(idx1+2+cmpDAY-2:(NUM_DAY-1):idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    
    if(strcmp(casetype,'Sto'))
        totalCostTableStoPerOutput = sum(cell2mat(textscan(dataTxt,['%*f %*s %f %f %f %f %f'])),1);
        totalCostTableStoPerOutput(:,3) =  totalCostTableStoPerOutput(:,3) - totalCostTableStoPerOutput(:,4);  
        totalCostTableStoPerOutput(:,5) =  totalCostTableStoPerOutput(:,5) - totalCostTableStoPerOutput(:,4);  
    else
        totalCostTableDetPerOutput = sum(cell2mat(textscan(dataTxt,['%*f %*s %f %f %f %f %f'])),1);
        totalCostTableDetPerOutput(:,3) =  totalCostTableDetPerOutput(:,3) - totalCostTableDetPerOutput(:,4);  
        totalCostTableDetPerOutput(:,5) =  totalCostTableDetPerOutput(:,5) - totalCostTableDetPerOutput(:,4);  
    end
    

    idx1 = find(strcmp(s{1}, '#GeneratorTotalCostsByTypeStart' ),1,'first');
    idx2 = idx1+2+NUM_SLOWGEN*(NUM_DAY-1);%temp(1);
    buffer  = s{1}(idx1+2+cmpDAY-2:(NUM_DAY-1):idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    
    if(strcmp(casetype,'Sto'))
        totalSlowGenCostTableStoPerOutput = sum(cell2mat(textscan(dataTxt,['%*f %*s %f %f %f %f %f'])),1);
        totalSlowGenCostTableStoPerOutput(:,3) =  totalSlowGenCostTableStoPerOutput(:,3) - totalSlowGenCostTableStoPerOutput(:,4);  
        totalSlowGenCostTableStoPerOutput(:,5) =  totalSlowGenCostTableStoPerOutput(:,5) - totalSlowGenCostTableStoPerOutput(:,4);  
    else
        totalSlowGenCostTableDetPerOutput = sum(cell2mat(textscan(dataTxt,['%*f %*s %f %f %f %f %f'])),1);
        totalSlowGenCostTableDetPerOutput(:,3) =  totalSlowGenCostTableDetPerOutput(:,3) - totalSlowGenCostTableDetPerOutput(:,4);  
        totalSlowGenCostTableDetPerOutput(:,5) =  totalSlowGenCostTableDetPerOutput(:,5) - totalSlowGenCostTableDetPerOutput(:,4);  
    end

    fclose(fileID);
    
    
    
    % calculate capacity
    
    if(strcmp(casetype,'Sto'))
        capacityAvailSto = sum(cell2mat(commitmentVectorSto).*repmat(cell2mat(capacityGenSto),1,24),1);
        totalCapacityAvailSto = sum(cell2mat(totalCommitmentVectorSto).*repmat(cell2mat(totalCapacityGenSto),1,24),1);
    else
        capacityAvailDet = sum(cell2mat(commitmentVectorDet).*repmat(cell2mat(capacityGenDet),1,24),1);
        totalCapacityAvailDet = sum(cell2mat(totalCommitmentVectorDet).*repmat(cell2mat(totalCapacityGenDet),1,24),1);
    end
    
end

%%
cmpWIND = tf_WindPen(cmpCASE+1)*100;
currDir = [filesepChar 'LoadCases' filesepChar 'TestCase_' num2str(cmpWIND) '_' cmpMONTH '_' num2str(cmpSCN) filesepChar cmpDATE filesepChar];

%cd([mainDir currDir]);

listOfFiles = dir(fullfile([mainDir currDir '*Expected*.dat']));
temp = dir(fullfile([mainDir currDir '*Actual*.dat']));

listOfFiles=[listOfFiles;temp];

len = length(listOfFiles);

for i=1:length(listOfFiles)
    
    loadtype = listOfFiles(i).name(1:6);
    
    fileID = fopen(fullfile([mainDir currDir listOfFiles(i).name]));
    s = textscan(fileID, '%s', 'delimiter', '\n');
    % search for your Region:

    temp = strfind([s{1}],'Hour');
    idx1 = find(~cellfun(@isempty, temp));
    idx2 = idx1+1+24;
    buffer  = s{1}(idx1+1:idx2-1);
    dataTxt = sprintf('%s\n',buffer{:});
    
    if(strcmp(loadtype,'Actual'))
        actualLoad = scalingFactor.*[sum(cell2mat(textscan(dataTxt,['%*f %f %f %f %f %f %f %f %f'])),2)]';
    else
        expectedLoad = scalingFactor.*[sum(cell2mat(textscan(dataTxt,['%*f %f %f %f %f %f %f %f %f'])),2)]';
    end
    fclose(fileID);

end

%%


plotCapacityAvailSto = [plotCapacityAvailSto capacityAvailSto];
plotCapacityAvailDet = [plotCapacityAvailDet capacityAvailDet];
plotTotalCapacityAvailSto = [plotTotalCapacityAvailSto totalCapacityAvailSto];
plotTotalCapacityAvailDet = [plotTotalCapacityAvailDet totalCapacityAvailDet];
plotActualLoad = [plotActualLoad actualLoad];
plotExpectedLoad = [plotExpectedLoad expectedLoad];

plotPowerGenSto = [plotPowerGenSto powerGenSto];
plotPowerGenDet = [plotPowerGenDet powerGenDet];
plotPowerSlowGenSto = [plotPowerSlowGenSto powerSlowGenSto];
plotPowerSlowGenDet = [plotPowerSlowGenDet powerSlowGenDet];

plotProductionCostSto = [plotProductionCostSto productionCostSto];
plotProductionCostDet = [plotProductionCostDet productionCostDet];
plotStartUpCostSto = [plotStartUpCostSto startUpCostSto];
plotStartUpCostDet = [plotStartUpCostDet startUpCostDet];
plotShutDownCostSto = [plotShutDownCostSto shutDownCostSto];
plotShutDownCostDet = [plotShutDownCostDet shutDownCostDet];

totalCostDayDet = sum(totalCostTableDetPerOutput) + sum(totalSlowGenCostTableDetPerOutput);
totalCostDaySto = sum(totalCostTableStoPerOutput) + sum(totalSlowGenCostTableStoPerOutput);

totalCostTableDet = [totalCostTableDet totalCostTableDetPerOutput];
totalCostTableSto = [totalCostTableSto totalCostTableStoPerOutput];

totalSlowGenCostTableDet = [totalSlowGenCostTableDet totalSlowGenCostTableDetPerOutput];
totalSlowGenCostTableSto = [totalSlowGenCostTableSto totalSlowGenCostTableStoPerOutput];

totalCostPerDayDet = [totalCostPerDayDet totalCostDayDet];
totalCostPerDaySto = [totalCostPerDaySto totalCostDaySto];

totalSavingsPerDay = [totalSavingsPerDay (sum(totalCostDayDet) - (totalCostDaySto))/(totalCostDayDet)*100];


end



%%
if(plotLoadCode~=1)
    fHand=figure(1);
    aHand = axes('parent', fHand);
else
    if(cmpSCN==1)
        fHand=figure(1);
        aHand = axes('parent', fHand);
    end
end

if(plotLoadCode~=1)
%plot(plotCapacityAvailDet,'b')
hold on;
%plot(plotCapacityAvailSto,'r')
hArrayLegend = plot(plotTotalCapacityAvailDet,'b','LineWidth', 4, 'LineStyle','--');
hArrayLegend = [hArrayLegend, plot(plotTotalCapacityAvailSto,'r','LineWidth', 4, 'LineStyle','-')];

%plot(plotActualLoad,'green','LineWidth', 3, 'LineStyle','-')
hArrayLegend = [hArrayLegend, plot(plotExpectedLoad,'black','LineWidth', 4, 'LineStyle','-.')];
end

% if(plotLoadCode==1)
% hold on;
% end

 


% bar(plotPowerGenSto,'r');
% bar(plotPowerGenDet,'b');
 for cmpDay=startDayForCostSavings:endDayForCostSavings
       totalSavings = totalSavings + totalSavingsPerDay(cmpDay-startDayForCostSavings+1); 
       totalCostDet = totalCostDet + totalCostPerDayDet(cmpDay-startDayForCostSavings+1); 
       totalCostSto = totalCostSto + totalCostPerDaySto(cmpDay-startDayForCostSavings+1); 
 end
    
    totalSavingsTable = [totalSavingsTable; [tf_ReserveRequirements(cmpCASE+1) tf_MonthNum(cmpCASE+1) tf_WindPen(cmpCASE+1) totalCostDet totalCostSto totalSavings]];
    cmpDAY = MAX_DAY - START_DAY+2;
    
if(plotLoadCode~=1)
fsz = 20;      % Fontsize

temp = bar([plotPowerGenDet' plotPowerGenSto']);
    hArrayLegend = [hArrayLegend,temp(1)];
%    bar([plotPowerGenDet']);
    hArray = bar([plotPowerSlowGenDet' plotPowerSlowGenSto']);
%    hArray = bar([plotPowerSlowGenDet']);
    set(hArray(1),'FaceColor','white','LineWidth',1);
    set(hArray(2),'FaceColor','white','LineWidth',1);

%    plot(plotTotalCapacityAvailDet,'b')
%    plot(plotTotalCapacityAvailSto,'r')

    %totalSavings = (cell2mat(totalCostPerDayDet) - cell2mat(totalCostPerDaySto)) / cell2mat(totalCostPerDayDet)*100;
    
%     for cmpDay=startDayForCostSavings:endDayForCostSavings
%        totalSavings = totalSavings + totalSavingsPerDay(cmpDay-startDayForCostSavings+1); 
%        totalCostDet = totalCostDet + totalCostPerDayDet(cmpDay-startDayForCostSavings+1); 
%        totalCostSto = totalCostSto + totalCostPerDaySto(cmpDay-startDayForCostSavings+1); 
%     end
%     
%     totalSavingsTable = [totalSavingsTable; [tf_ReserveRequirements(cmpCASE+1) tf_MonthNum(cmpCASE+1) tf_WindPen(cmpCASE+1) totalCostDet totalCostSto totalSavings]];
%     cmpDAY = MAX_DAY - START_DAY+2;
    set(gca,'XTick',[0:4:((cmpDAY-1)*24)])
    
    hXLabel = xlabel('Time (hours)','FontSize',fsz,'interpreter','latex');

    %axis([0 ((cmpDAY-1)*24 +1) 10000 2.8205e+04 ]); %max([1.15*sum(cell2mat(totalCapacityGenDet)) 1.1*max(actualLoad)])])
        axis([0 ((cmpDAY-1)*24 +1) 0.70e+04 2.3005e+04 ]); %max([1.15*sum(cell2mat(totalCapacityGenDet)) 1.1*max(actualLoad)])])
%    hLegend  = legend(sprintf('Capacity\nDet (MW)'),sprintf('Capacity\nSto (MW)'), sprintf('Expected\nLoad (MW)'), sprintf('Fast Generation\nDispatched (MW)')); % 'Actual Load (MW)',
   % hLegend  = legend(sprintf('Capacity\nDet (MW)'),sprintf('Capacity\nSto (MW)'), sprintf('Expected\nLoad (MW)'), sprintf('Fast Generation\nDispatched (MW)')); % 'Actual Load (MW)',
  % hLegend  = legend(sprintf('Capacity\nDet (MW)'),sprintf('Capacity\nSto (MW)'), sprintf('Expected\nLoad (MW)'));
    
if sum(plotPowerSlowGenDet)==sum(plotPowerGenDet)
   hLegend  = legend(sprintf('Capacity\nDet (MW)'),sprintf('Capacity\nSto (MW)'), sprintf('Forecasted\nLoad (MW)') ); 
else
   hLegend  = legend(sprintf('Capacity\nDet (MW)'),sprintf('Capacity\nSto (MW)'), sprintf('Forecasted\nLoad (MW)'), sprintf('Peaker Units\nDispatched (MW)')); 
end  % hLegend  = legend(sprintf('Capacity\nDet (MW)'),sprintf('Capacity\nSto (MW)'), sprintf('Forecasted\nLoad (MW)')); 
  
   % hLegend  = legend('Capacity \n Det (MW)','Cap - Sto (MW)', 'Actual Load (MW)', 'Expected Load (MW)'); % 'Actual Load (MW)',
   %     hLegend  = legend('Cap - Det (MW)','Cap - Sto (MW)', 'Expected Load (MW)'); % 'Actual Load (MW)',
    set(hLegend ,'Orientation','horizontal','location', 'north','FontSize',fsz)
    
    hYLabel  = ylabel('Capacity / Power (MW)','FontSize',fsz,'interpreter','latex');

   %text((cmpDAY-1)*24*2/30,.95*2.8205e+04,['Wind penetration : ' num2str(tf_WindPen(cmpCASE+1,:)*10),' | Month : ' tf_MonthString(cmpCASE+1,:),'   | Reserves : ' num2str(tf_ReserveRequirements(cmpCASE+1)) ' MW']);
   %text((cmpDAY-1)*24*2/5,.95*2.8205e+04,['No of Gen : ' num2str(NUM_GEN)])
%   text((cmpDAY-1)*24*2/30,.6*2.8205e+04,['Cost Savings : ' num2str(totalSavings) '%'])
%   text((cmpDAY-1)*24*2/5,.875*2.8205e+04,['Deterministic cost ($) : ' num2str((totalCostDet),'%10.4e') ' | Stochastic cost ($) : ' num2str((totalCostSto),'%10.4e')])
%   text((cmpDAY-1)*24*2/30,.925*2.8205e+04,['Scenario number ' num2str(cmpSCN) '''s probability : ' num2str(probability_realized(cmpCASE+1,cmpSCN))])
   %text((cmpDAY-1)*24*2/5,.825*2.8205e+04,['Month : ' tf_MonthString(cmpCASE+1,:)])
   %text((cmpDAY-1)*24*2/5,.8*2.8205e+04,['Wind penetration : ' num2str(tf_WindPen(cmpCASE+1,:)*10),' | Month : ' tf_MonthString(cmpCASE+1,:)] )
   %text((cmpDAY-1)*24*2/30,.875*2.8205e+04,['Type    StartUp       ShutDown       Production        Noload       Total : ' ])
%   text((cmpDAY-1)*24*2/30,.85*2.8205e+04,['Det : ' num2str((totalCostTableDetPerOutput),'%10.4e   ')])
%   text((cmpDAY-1)*24*2/30,.825*2.8205e+04,['Sto : ' num2str((totalCostTableStoPerOutput),'%10.4e   ')])
  % hTitle  = title('Capacity and Power Dispatched versus Time','interpreter','latex','FontSize',18);


%Defaults for this blog post
width = 20;     % Width in inches
height = 10;    % Height in inches
alw = 0.75;    % AxesLineWidth
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

    hold off;
    if(plotOn==1)
        if( ...
            or( ...
                or( ...
                    and( and(cmpCASE==0,tf_ReserveRequirements(cmpCASE+1)==0) ...
                            ,or(cmpSCN==10,cmpSCN==3)), ... 
                    and( and(cmpCASE==13,tf_ReserveRequirements(cmpCASE+1)==6500) ...
                            ,or(cmpSCN==10,cmpSCN==3)) ...
                   ) , ... 
                    and( and(cmpCASE==8,tf_ReserveRequirements(cmpCASE+1)==4000) ...
                            ,cmpSCN==10) ...
               ) ...
           )  
    [s,mess,messid] = mkdir('Figures-test');
    [s,mess,messid] = mkdir('Figures');
    set(gcf,'renderer','painters')
    %print -depsc Figures/finalPlot1.eps
%    print('-djpeg',['Figures-test' filesepChar 'plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)])
%    print('-depsc2',['Figures' filesepChar 'plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)])
    saveas(gcf,['Figures-test' filesepChar 'plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)],'jpg')
    saveas(gcf,['Figures' filesepChar 'plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)],'fig')
        end
    close all;
    
    %print('-depsc',['Figures-test' filesepChar 'plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)])
   
    
    %print_eps(['Figures/plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)],fHand);
%    print(fHand,['Figures/plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)], '-deps');    
%    plot2svg('myfile.svg',fHand,'png')
    %matlab2tikz(['Figures/plot_' num2str(cmpCASE) '_Gen' num2str(NUM_GEN) '_Reserve' num2str(tf_ReserveRequirements(cmpCASE+1)) '_' tf_MonthString(cmpCASE+1,:) '_' num2str(cmpSCN) '_StartDay' num2str(startDayForCostSavings) 'EndDay' num2str(endDayForCostSavings)], 'height', '\figureheight', 'width', '\figurewidth'); 
    end
    %delete(fHand)
end


end

% if(plotLoadCode==1)
% 
%     set(gca,'XTick',[1:((cmpDAY-1)*24)])
%     axis([0 ((cmpDAY-1)*24 +1) 0 max([1.15*sum(cell2mat(totalCapacityGenDet)) 1.1*max(actualLoad)])])
%     xlabel('Time (hours)','FontSize',12);
%     ylabel('Load (MW)','FontSize',12);
%     title('Load Scenarios')
%     legend('Scenarios Load', 'Expected Load');
%     
%     % Defaults for this blog post
%     width = 15;     % Width in inches
%     height = 10;    % Height in inches
%     alw = 0.75;    % AxesLineWidth
%     fsz = 11;      % Fontsize
%     lw = 1.5;      % LineWidth
%     msz = 8;       % MarkerSize
%     pos = get(gcf, 'Position');
%     %set(gcf, 'Position', [0 0 width*100, height*100]); %<- Set size
%     set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% 
%     % Here we preserve the size of the image when we save it.
%     set(gcf,'InvertHardcopy','on');
%     set(gcf,'PaperUnits', 'inches');
%     papersize = get(gcf, 'PaperSize');
%     left = (papersize(1)- width)/2;
%     bottom = (papersize(2)- height)/2;
%     myfiguresize = [left, bottom, width, height];
%     set(gcf,'PaperPosition', myfiguresize);
% 
%     
%     print(fHand,['loadscenarios'], '-dpng', '-r300');
% end

% if(saveOn)
    save(['output_totalSavingsScenario' num2str(cmpSCN)],'totalSavingsTable');
% end

totalTableSto = [totalTableSto ; totalCostTableSto];
%    sum(plotStartUpCostSto) sum(plotProductionCostSto) ...
%    sum(plotShutDownCostSto)];
totalTableDet = [totalTableDet ; totalCostTableDet];
%    sum(plotStartUpCostDet) sum(plotProductionCostDet) ...
%    sum(plotShutDownCostDet)];
totalSlowGenTableSto = [totalSlowGenTableSto ; totalSlowGenCostTableSto];
totalSlowGenTableDet = [totalSlowGenTableDet ; totalSlowGenCostTableDet];

save(['totalTable' num2str(cmpSCN)], ... 
    'totalTableDet', 'totalTableSto','totalSlowGenTableSto','totalSlowGenTableDet');


end
%%


end
%%
% 
 expectedDet = zeros(size(totalTableDet));
 expectedSto = zeros(size(totalTableSto));
% expectedSlowGenDet = zeros(size(totalTableDet));
% expectedSlowGenSto = zeros(size(totalTableSto));
 
 load('probability_testcase_realized');
% %probability([3:180],:)=[];
 for iSCN = [1:10]
% 
     load(['totalTable' num2str(iSCN)]);
     expectedDet = expectedDet+totalTableDet.*repmat(probability_realized(:,iSCN),1,5);
     expectedSto = expectedSto+totalTableSto.*repmat(probability_realized(:,iSCN),1,5);
     %expectedSlowGenDet = expectedSlowGenDet+totalSlowGenTableDet.*repmat(probability(:,iSCN),1,4);
     %expectedSlowGenSto = expectedSlowGenSto+totalSlowGenTableSto.*repmat(probability(:,iSCN),1,4);
 
 end
 
 save(['expectedTable'], ... 
     'expectedDet', 'expectedSto');%, 'expectedSlowGenDet', 'expectedSlowGenSto');
 
%%
% 
 clear
 clc
% 

PEAK_LOAD = 13965.12

 load('expectedTable')
% 
 load('treatmentFactors_WindPen')
 load('treatmentFactors_noGen')
 load('treatmentFactors_ReserveRequirements')

 [rows cols] = size(expectedDet);
 expectedSavings = zeros(rows,cols);
 expectedSavingsPercent = zeros(rows,cols);
 %expectedSlowGenSavings = zeros(rows,cols);
 %expectedSlowGenSavingsPercent = zeros(rows,cols);
% 
 for iRow = [1:rows]
     for iCol = [1:cols]
         expectedSavings(iRow,iCol) = (expectedDet(iRow,iCol) - ...
             expectedSto(iRow,iCol)); 
         expectedSavingsPercent(iRow,iCol) = (expectedDet(iRow,iCol) - ...
             expectedSto(iRow,iCol)) / expectedDet(iRow,iCol); 
         %expectedSlowGenSavings(iRow,iCol) = (expectedSlowGenDet(iRow,iCol) - ...
             %expectedSlowGenSto(iRow,iCol)); 
         %expectedSlowGenSavingsPercent(iRow,iCol) = (expectedSlowGenDet(iRow,iCol) - ...
             %expectedSlowGenSto(iRow,iCol)) / expectedSlowGenDet(iRow,iCol); 
     end
 end
 
 expectedSavings = [tf_ReserveRequirements expectedSavings];
 expectedSavings = [expectedSavings(:,1) expectedSavings(:,1)./PEAK_LOAD.*100 expectedSavings(:,2:6)];
 expectedSavingsPercent = [tf_ReserveRequirements expectedSavingsPercent];
 %expectedSlowGenSavings = [tf_MonthNum tf_ReserveRequirements expectedSlowGenSavings];
 %expectedSlowGenSavingsPercent = [tf_MonthNum tf_ReserveRequirements expectedSlowGenSavingsPercent];
 %expectedFastGenSavings = expectedSavings - expectedSlowGenSavings;
 
 % expectedSavings = [expectedSavings(:,1:4) expectedSlowGenSavings(:,5) ... 
 %     expectedFastGenSavings(:,5) expectedSavings(:,6)];
 
 % expectedSavings = [expectedSavings(:,1:4) expectedSavings(:,6)];
 
 save(['expectedSavingsTable'], ... 
     'expectedSavings', 'expectedSavingsPercent');

