%%
%

clc
clear

str = input('Main directory path: ','s');         
if(exist(str,'dir'))
         mainDir = str;
else
    display('Path does not exist')
    break
end

cd(mainDir)


load('expectedSavingsTable')
tableData = [expectedSavings(:,1:4) expectedSavings(:,6) expectedSavings(:,5)];

load('output_AverageCostSavingsTable')

tableData = [tableData AverageCostSavingsTable(:,end-1:end)];

%tableData = expectedSavingsPercent;

%%

% columnTitle = {'Reserve Requirement(MW)';'Reserve Requirement(\% of peak load)';'Cost Savings (\%)'};

columnTitle = {'Reserve Requirement(MW)';'Reserve Requirement(% peak load)'...
    ;'Start up';'Shut down';'No load';'Production';'Cost Savings (\%)';...
    'Std of Cost Savings  (\%)'};

filesepChar = filesep;

%
%tableData(:,5) = [];
%tableData(:,4) = [];
% tableData(:,2) = [];
% tableData(:,2) = tableData(:,1)./19000;

mainDir = pwd;
tableName = 'costSavingsByType';
tableCaption = 'Cost Savings By Type (\%)';
tableLabel = 'table-costSavingsByType';

%%


noCols = length(tableData(1,:));
noRows = length(tableData(:,1));

FID = fopen([mainDir filesepChar 'table_' tableName '.tex'], 'w');

fprintf(FID,'\\begin{table}\n');
fprintf(FID,'\\centering \n');
fprintf(FID, '%s' ,['\caption {' tableCaption '} \label{tab:' tableLabel '}' ]); 
fprintf(FID,'\n');
fprintf(FID, '%s' ,['\begin{tabular}{|' repmat('c',1,noCols) '|} \hline']);
fprintf(FID,'\n');

col=1;
fprintf(FID, columnTitle{col,:});
for col=2:noCols
    fprintf(FID, '%s', ['& ' columnTitle{col,:}]);
end

fprintf(FID, '\\\\ \\hline \n');

for row=1:noRows
    col=1;
    fprintf(FID, '%8.0f', tableData(row,col));
    col=2;
    fprintf(FID, '& %8.0f', tableData(row,col));
    for col=3:noCols
        fprintf(FID, ' & %8.2f', tableData(row,col));
    end
    fprintf(FID, ' \\\\ \n');
end

fprintf(FID, '\\hline \n');

fprintf(FID, '\\end{tabular}\n');
fprintf(FID, '\\end{table}\n');
fclose(FID);

display('Done')
