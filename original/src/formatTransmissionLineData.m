%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Format Load Data

% Transmission Line Data

NN=nBus;
PenaltyWeight=.05;
iBranchData=nBranch;
branchName=[1:nBranch]';

nodeData(1,1)=NN;
nodeData(1,2)=PenaltyWeight;

sbranchData=cell(nBranch,1);
for i=1:nBranch
    sbranchData{i,1}=strcat('Branch',sprintf('%d',branchName(i,1)));
end
branchData(1:nBranch,2:5)=dataBranch(1:nBranch,1:4);
