clc;
clear;

startcase = 0; 

% first case is = 0/1 

%%
%

for cmpSCN = 1:5


scalingFactor = 0.41822290769659204;


NUM_DARTS=10;
NUM_SCN=5;

cmpCASE = 0;
cmpDART = (cmpSCN*2)-1;
cmpDAY = 4;
cmpMONTH = 'Jan';
cmpDATE = ['2011-01-0' num2str(cmpDAY)];

%%
mainDir = 'C:\Local Files\TestCases\Output\';

currDir = ['LoadCases\TestCase_' num2str(cmpCASE) '_' cmpMONTH '_' num2str(cmpSCN) '\' cmpDATE '\'];

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

h=figure(1);
hold on;
%plot(capacityAvailDet,'b')
%plot(capacityAvailSto,'r')
plot(actualLoad,'g')
plot(expectedLoad,'y')

%legend('Capacity in Deterministic Case','Capacity in Stochastic Case','Actual Load', 'Expected Load');
%axis([0 25 0 1.15*sum(cell2mat(capacityGenDet))])
axis([0 25 0 1.1*max(actualLoad)])
set(gca,'XTick',[1:24])

%%
end
