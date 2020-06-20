clc;
clear;

startcase = 1; 

% first case is = 0/1 

%%
%cd('C:\Local Files\AMESRepo\ames\TEST-DATA\8BusSCEDComparison\Output')

% mainDir = 'C:\Local Files\Dec2ndResults\';
% mainDir = 'C:\Local Files\AMESRepo\ames\TEST-DATA\';

mainDir = 'C:\Local Files\TestCases\';

%currDir = 'DesktopResults\';
%currDir = 'SimTestCase\';

currDir = ['Output\Test\'];
%currDir = 'ClusterResults\Output\';

NUM_DARTS=5;
NUM_GEN = 426-377;

%%


listOfFiles = dir(fullfile([mainDir currDir '*.dat']));
len = length(listOfFiles);

NUM_CASES=len/NUM_DARTS/2;

% fieldsListOfFiles = fieldnames(listOfFiles);
% listOfFiles_cell = struct2cell(listOfFiles);
% sizeListOfFiles = size(listOfFiles_cell);
% 
% listOfFiles_cell = reshape(listOfFiles_cell, sizeListOfFiles(1), []); 
% listOfFiles_cell=listOfFiles_cell';
% listOfFiles_cell=sortrows(listOfFiles_cell,1);
%%


% for iter=0:len-1
%     if(listOfFiles(len-iter).isdir)
%         listOfFiles(len-iter)=[];
%         display(['Deleted element ' num2str(iter+1)]); 
%     elseif(strfind(listOfFiles(len-iter).name,'.out'))
%     else
%         listOfFiles(len-iter)=[];
%         display(['Deleted element ' num2str(iter+1)]);
%     end
% end

%%

lineNumber = 31;

distribution = zeros(5,9);

for i=1:length(listOfFiles)

    fileID = fopen(fullfile([mainDir currDir listOfFiles(i).name]));
    C = textscan(fileID,'%s %s',1,'HeaderLines',lineNumber);
    fclose(fileID);

    strLine = (C{1,2}{1});

    scenarioStartIdx = regexp(strLine,'[0-9]/master*');
    scenario = str2num(strLine(scenarioStartIdx));
    
    casenumberpos = (strfind(listOfFiles(i).name,'Case'));
    casenumber = listOfFiles(i).name((casenumberpos(2)+4):(casenumberpos(2)+5));
    num1 = sscanf(casenumber,'%d')+startcase;
    
    distribution(scenario,num1) = distribution(scenario,num1) + 1;
        
end


distribution = distribution/2;