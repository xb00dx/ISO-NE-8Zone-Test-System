%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Initialize Transmission Line Data

%%
% From To MaxCap Reactance Susceptance

display('Transmission Data from ISO-NE file');

%%
% Load busDetails
folder = [pwd '/../data/transmissionLineData/'];
fullFileName = fullfile(folder, ['gridDetails.mat']);
if exist(fullFileName, 'file')
    load(fullFileName);
else
    display('Stopping : Error Occurred. Transmission Data file does not exist')    
    break
end

dataBranch(:,1)=branchDetails(:,2);
dataBranch(:,2)=branchDetails(:,3);
dataBranch(:,3)=MAXCAP;
dataBranch(:,4)=branchDetails(:,4);
dataBranch(:,5)=SUSCEPTANCE;

nBus=length(busDetails(:,1));
nBranch=length(branchDetails);
