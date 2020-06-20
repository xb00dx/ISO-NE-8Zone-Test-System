%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Format Load Data

%%

lseName=[1:nLse]';
bPriceSensitiveDemand=1;
bHybridDemand=1;
iLSEData=nLse;

slseData=cell(nLse,1);
for i=1:nLse
    slseData{i,1}=strcat('LSE', sprintf('%d',lseName(i)));
end
lseData(1:nLse,2:27)=dataLse(1:nLse,1:26);

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

