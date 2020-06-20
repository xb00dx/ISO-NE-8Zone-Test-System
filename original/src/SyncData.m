
NN=nBus;
PenaltyWeight=.05;
iBranchData=nBranch;
branchName=[1:nBranch]';
%genName=[1:nGen]
lseName=[1:nLse]';
nAlertGenData = nBus;
%%

bPriceSensitiveDemand=1;
bHybridDemand=1;

%%

iGenData=nGen;
iLSEData=nLse;
iAlertGenData=nAlertGenData;
iReserveGenData=nReserveGenData;
%iLSEData_old=nLse_old;

%%

nodeData(1,1)=NN;
nodeData(1,2)=PenaltyWeight;

%%
sbranchData=cell(nBranch,1);
for i=1:nBranch
    sbranchData{i,1}=strcat('Branch',sprintf('%d',branchName(i,1)));
end
branchData(1:nBranch,2:5)=dataBranch(1:nBranch,1:4);

%{

branchData(1:nBranch,3)=dataBranch(1:nBranch,2);%To
branchData(1:nBranch,4)=dataBranch(1:nBranch,3);%MaxCapacity
branchData(1:nBranch,5)=dataBranch(1:nBranch,4);%Reactance
%}
%%
sgenData=cell(nGen,1);
for i=1:nGen
    sgenData{i,1}=strcat('GenCo',sprintf('%d',genName(i)));
end
genData(1:nGen,2:9)=dataGen(1:nGen,1:8);
genCostData(1:nGen,:)=dataGenCost(1:nGen,:);
scucInputData(1:nGen,2:12)=dataScucInput(1:nGen,1:11);

%{
genData(1:nGen,3)=dataGen(1:nGen,2);
genData(1:nGen,4)=dataGen(1:nGen,3);
genData(1:nGen,5)=dataGen(1:nGen,4);
genData(1:nGen,6)=dataGen(1:nGen,5);
genData(1:nGen,7)=dataGen(1:nGen,6);
genData(1:nGen,8)=dataGen(1:nGen,7);
genData(1:nGen,9)=dataGen(1:nGen,8);
%}
%%
slseData=cell(nLse,1);
for i=1:nLse
    slseData{i,1}=strcat('LSE', sprintf('%d',lseName(i)));
end
lseData(1:nLse,2:27)=dataLse(1:nLse,1:26);

%{
lseData(1:nLse,3)=dataLse(1:nLse,2);
lseData(1:nLse,4)=dataLse(1:nLse,3);
lseData(1:nLse,5)=dataLse(1:nLse,4);
lseData(1:nLse,6)=dataLse(1:nLse,5);
lseData(1:nLse,7)=dataLse(1:nLse,6);
lseData(1:nLse,8)=dataLse(1:nLse,7);
lseData(1:nLse,9)=dataLse(1:nLse,8);
lseData(1:nLse,10)=dataLse(1:nLse,9);
lseData(1:nLse,11)=dataLse(1:nLse,10);
lseData(1:nLse,12)=dataLse(1:nLse,11);
lseData(1:nLse,13)=dataLse(1:nLse,12);
lseData(1:nLse,14)=dataLse(1:nLse,13);
lseData(1:nLse,15)=dataLse(1:nLse,14);
lseData(1:nLse,16)=dataLse(1:nLse,15);
lseData(1:nLse,17)=dataLse(1:nLse,16);
lseData(1:nLse,18)=dataLse(1:nLse,17);
lseData(1:nLse,19)=dataLse(1:nLse,18);
lseData(1:nLse,20)=dataLse(1:nLse,19);
lseData(1:nLse,21)=dataLse(1:nLse,20);
lseData(1:nLse,22)=dataLse(1:nLse,21);
lseData(1:nLse,23)=dataLse(1:nLse,22);
lseData(1:nLse,24)=dataLse(1:nLse,23);
lseData(1:nLse,25)=dataLse(1:nLse,24);
lseData(1:nLse,26)=dataLse(1:nLse,25);
lseData(1:nLse,27)=dataLse(1:nLse,26);
%}
%%

k=1;
slsePriceSensitiveDemand=cell(1);
for i=1:nLse
    k=(i-1)*24;
    for h=1:24
        slsePriceSensitiveDemand{k+h,:}=strcat('LSE', sprintf('%d',lseName(i)));
        lsePriceSensitiveDemand(k+h,2:7)=dataLsePriceSensitiveDemand(k+h,1:6);
%{
        lsePriceSensitiveDemand(k+h,3)=dataLsePriceSensitiveDemand(k+h,2);
        lsePriceSensitiveDemand(k+h,4)=dataLsePriceSensitiveDemand(k+h,3);
        lsePriceSensitiveDemand(k+h,5)=dataLsePriceSensitiveDemand(k+h,4);
        lsePriceSensitiveDemand(k+h,6)=dataLsePriceSensitiveDemand(k+h,5);
        lsePriceSensitiveDemand(k+h,7)=dataLsePriceSensitiveDemand(k+h,6);
%}    
    end
end

%%
slseHybridDemand=cell(1);
for i=1:nLse
    slseHybridDemand{i,1}=strcat('LSE',sprintf('%d',(lseName(i))));
end
temp=length(dataLseHybridDemand(:,1));
lseHybridDemand(1:temp,2:27)=dataLseHybridDemand(1:temp,1:26);


%%
temp=length(dataGenLearning(:,1));
genLearningData(1:temp,2:13)=dataGenLearning(1:temp,1:12);

display('Data sync complete.')