%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Format Generator Data


%%

nAlertGenData = nBus;
iGenData=nGen;
iAlertGenData=nAlertGenData;
iReserveGenData=nReserveGenData;

%%
sgenData=cell(nGen,1);
for i=1:nGen
    sgenData{i,1}=strcat('GenCo',sprintf('%d',genName(i)));
end
genData(1:nGen,2:9)=dataGen(1:nGen,1:8);
genCostData(1:nGen,:)=dataGenCost(1:nGen,:);
scucInputData(1:nGen,2:12)=dataScucInput(1:nGen,1:11);

%%

temp=length(dataGenLearning(:,1));
genLearningData(1:temp,2:13)=dataGenLearning(1:temp,1:12);
