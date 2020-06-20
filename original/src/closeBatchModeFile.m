%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Date 2014-05-03

% Close batchmode file

strTemp='';
strTemp=strcat(strTemp,'#MultiCasesDataEnd', '\n');
fprintf(batchFileID,strTemp);
fclose('all');