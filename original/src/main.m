%% Eight Zone Test Bed
% Author - Dheepak Krishnamurthy
% Arpae/DOE Project
% Date 2014-05-03

% This is the main function to generate test 
% cases based on ISO-NE data.
% The following parameters must be set by the user
% to vary over different treatment factors

clear all;
clc;
errorCode = 0;
diary('log')

matlabVersion = version('-release')
oldVersion = '2014a';

disp(repmat('#',1,45))
disp(datestr(now))
disp(repmat('#',1,45))
% Check how long it takes to create the test cases
tic 

% Initialize user defined input
initialize

% Open and create batch mode file
openBatchModeFile

% Call function Save.m
Save

% Save all the treatmentfactors as .mat files
saveTreatmentFactors

% Close batch mode file
closeBatchModeFile

% Display status to user 

if errorCode == 1
    display('Error occurred')
else
    display('Completed')
    display([num2str(numCases) ' total ISO NE Generator Test Case(s) created'])
    display('Opening output folder..')
if(ispc)
    winopen([mainDir '/Output'])
elseif(ismac)
    macopen([mainDir '/Output'])
end
end
diary off
% Check how long it takes to create the test cases
toc

