%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Date 2014-05-03

% Creates batch mode file in testcaseDir

nameBatchModeFile='BatchModeFile.bth';
batchname=fullfile(mainDir,[testcaseDir nameBatchModeFile]);

batchFileID = fopen(batchname,'w');

strTemp='//Batch File\n';

strTemp=strcat(strTemp,'#RandomSeedsDataStart','\n');
% random seed
strTemp=strcat(strTemp,num2str(2096966936), '\n');
strTemp=strcat(strTemp,'#RandomSeedsDataEnd','\n\n');
strTemp=strcat(strTemp,'#MultiCasesDataStart', '\n');

fprintf(batchFileID,strTemp);