
%if(exist('MAX_DAY') == 0)
%    MAX_DAY=2;
%    display('Creating MAX_DAY')
%end

%MAX_DAY;
% currDir = pwd;
% mainDir  = fileparts(currDir);
% % MAX_DAY=3;
% % NUM_SCENARIOS=8;
% % REQGEN = 30;
% % CAP_MARGIN = capmargin(1);
% SCALE_SSN_COST = 1;%scalessncost(1) ;
% % SCUC_TYPE = 0;
%%
% Using ISO-NE dataset

%%

GENERATORSTOBEEXCLUDED = 312-REQGEN; % Number Less than 304


%%
% Reading input data.
display('Reading input data...');

    folder = [pwd '\..\data\genData\'];
    fullFileName = fullfile(folder, ['genData.mat']);
    if exist(fullFileName, 'file')
    load(fullFileName);
    else
    display('Stopping : Error Occurred. Generator Data file does not exist')    
    break
    end

display('Initializing...');


%%
% Fixing all negative values

idx = (find([unitData{2:539,3}]<0)')+1;
unitData(idx,3) = num2cell([[unitData{idx,3}]*-1]');

%%
% Load busDetails
folder = [pwd '\..\data\transmissionLineData\'];
fullFileName = fullfile(folder, ['gridDetails.mat']);
if exist(fullFileName, 'file')
    load(fullFileName);
else
    display('Stopping : Error Occurred. Generator Data file does not exist')    
    break
end


display('Generator Data');



%%


fixFinalGenerators


%% fuelDetails contains a and b coefficients for the different types of fuel


% Coefficients using cost curve fitting

CostCurveModeling

% ramprateDetails 

RampRateModeling
NoLoadCostModeling

% Cost per MMBtu

CalculateCostPerMMBtu


%%
% Initializations.


%%
nCan = 0;
if(CANARYGENERATORS)
    nCan = 8;
end
genDetails=cell(538+nCan,9);
genCost=cell(538+nCan,1);
scucInputDetails=cell(538+nCan,8);
for i=2:539
    genDetails{i-1,1}=returnnodename(returnnodenumber_8bus(unitData...
        {i,1}),busDetails); 
    genDetails{i-1,2}=returnnodenumber_8bus(unitData{i,1});
    genDetails{i-1,3}=SCOST;
    genDetails{i-1,4}=fuelDetails(i-1,1);
    genDetails{i-1,5}=fuelDetails(i-1,2);
    genDetails{i-1,6}=LLIMIT;
    genDetails{i-1,7}=(unitData(i,3));
    genDetails{i-1,8}=INITIALMONEY;
    genDetails{i-1,9}=unitData(i,6);
    scucInputDetails{i-1,1}=returnnodename(returnnodenumber_8bus...
        (unitData{i,1}),busDetails);
    scucInputDetails{i-1,2}=(unitData{i,3});
    scucInputDetails{i-1,3}=(num2cell(1));
    scucInputDetails{i-1,4}=min(24,round(SCALEMINUPDOWNTIME*unitData{i,13}));
    scucInputDetails{i-1,5}=min(24,round(SCALEMINUPDOWNTIME*unitData{i,14}));
    idx = find(strcmp(RampRateKey(:,1),unitData{i,6}));
    scucInputDetails{i-1,6}=num2cell(unitData{i,3}*RampRateKey{idx,2}/100);
    scucInputDetails{i-1,7}=num2cell(unitData{i,3}*RampRateKey{idx,2}/100);
    scucInputDetails{i-1,8}=num2cell(unitData{i,3}*sRampRateKey{idx,2}/100);
    scucInputDetails{i-1,9}=num2cell(unitData{i,3}*sRampRateKey{idx,2}/100);
    scucInputDetails{i-1,10}=(num2cell(1));
    scucInputDetails{i-1,11}=(num2cell(1));

        genCost{i-1,1} = num2cell(min(999999,costNoLoad(i-1)*SCALE_NOLOAD_COST));
    
    if(unitData{i,10}==0)
        genCost{i-1,2} = num2cell(min(999999,35000*costPerMMBtu(i-1,1)*SCALE_SS_COST)); %approx 20$ per mmbtu
    else
        genCost{i-1,2} = num2cell(min(999999,unitData{i,10}*costPerMMBtu(i-1,1)*SCALE_SS_COST)); %approx 20$ per mmbtu
    end
    
    if(unitData{i,12}==0)
        genCost{i-1,3} = num2cell(min(999999,35000*costPerMMBtu(i-1,1)*SCALE_SS_COST)); %approx 20$ per mmbtu
    else
        genCost{i-1,3} = num2cell(min(999999,unitData{i,12}*costPerMMBtu(i-1,1)*SCALE_SS_COST)); %approx 20$ per mmbtu
    end
    
    
    if(unitData{i,10}==0)
        genCost{i-1,4} = num2cell(min(999999,35000*costPerMMBtu(i-1,1)*SCALE_SS_COST));
    else
        genCost{i-1,4} = num2cell(min(999999,unitData{i,10}*costPerMMBtu(i-1,1)*SCALE_SS_COST));
    end
    
end

%http://www.unitedpower.com/documents/CostofDeliveredEnergyperMMBTUofHeat_Jan2010_000.pdf

if(CANARYGENERATORS==1)
    for k=i+1:i+nBus
        genDetails{k-1,1}=returnnodename((k-i),busDetails); 
        genDetails{k-1,2}=k-i;
        genDetails{k-1,3}=SCOST;
        genDetails{k-1,4}=num2cell(CANARY_ACOEFF);
        genDetails{k-1,5}=num2cell(CANARY_BCOEFF);
        genDetails{k-1,6}=LLIMIT;
        genDetails{k-1,7}=num2cell(CANARY_MAXCAP);
        genDetails{k-1,8}=INITIALMONEY;
        scucInputDetails{k-1,1}=returnnodename(returnnodenumber_8bus(k-i),busDetails);
        scucInputDetails{k-1,2}=num2cell(CANARY_MAXCAP);
        scucInputDetails{k-1,3}=(num2cell(1));
        scucInputDetails{k-1,4}=(num2cell(0));
        scucInputDetails{k-1,5}=(num2cell(0));
        scucInputDetails{k-1,6}=(num2cell(CANARY_MAXCAP));
        scucInputDetails{k-1,7}=(num2cell(CANARY_MAXCAP));
        scucInputDetails{k-1,8}=(num2cell(CANARY_MAXCAP));
        scucInputDetails{k-1,9}=(num2cell(CANARY_MAXCAP));
        scucInputDetails{k-1,10}=(num2cell(1));
        scucInputDetails{k-1,11}=(num2cell(1));
        genCost{k-1,1} = num2cell(0);
        genCost{k-1,2} = num2cell(0);
        genCost{k-1,3} = num2cell(0);
        genCost{k-1,4} = num2cell(0);

    end
end

% Deleting Hydro Generators

k=1;
for i=1:length(genDetails(:,4))
    if((genDetails{i,4}{1,1}==0)*(genDetails{i,5}{1,1}==0))
        idx(k) = i;
        k=k+1;
    end
end
genName=[1:length(genDetails(:,4))]';
NOHYDROGENERATORS = length(idx);
scucInputDetails(idx(:),:)=[];
genCost(idx(:),:)=[];
genDetails(idx(:),:)=[];
genName(idx(:),:)=[];

%[sortedGenDetailsByFuel,idx_fuelname] = sortrows([genDetails{:,9}]');
idx_NG = [1:length(genDetails)]';
pattern = 'NG\w*';
NGgen = regexp([genDetails{:,9}]',pattern,'match');
empties = find(cellfun(@isempty,NGgen));
idx_NG(empties)=[];
reserveDetails = genDetails(idx_NG,:);
reserveName=genName(idx_NG,:);
reservescucInputDetails=scucInputDetails(idx_NG,:);
reserveCost=genCost(idx_NG,:);

[sortedGenDetails,idx] = sortrows([genDetails{:,7}]');
deletenumberofgen = GENERATORSTOBEEXCLUDED;

genDetails(idx(1:deletenumberofgen),:)=[];
genName(idx(1:deletenumberofgen),:)=[];
scucInputDetails(idx(1:deletenumberofgen),:)=[];
genCost(idx(1:deletenumberofgen),:)=[];

pattern = 'NG\w*';
NGgen = regexp([genDetails{:,9}]',pattern,'match');
idx = 1:length(genDetails(:,9));
empties = find(cellfun(@isempty,NGgen));
idx(empties)=[];
for i=1:length(idx)
    genDetails{idx(i),4}=num2cell(genDetails{idx(i),4}{1,1}/2);
    genDetails{idx(i),5}=num2cell(genDetails{idx(i),5}{1,1}/2);
end

[C,ia,ib] = intersect(genName,reserveName);
reserveDetails(ib,:)=[];
reserveName(ib,:)=[];
reservescucInputDetails(ib,:)=[];
reserveCost(ib,:)=[];

[sortedreserveDetails,idx_r] = sortrows([reserveDetails{:,7}]');
deletenumberofgen = floor(length(reserveDetails)/2);

reserveDetails(idx_r(1:deletenumberofgen),:)=[];
reserveName(idx_r(1:deletenumberofgen),:)=[];
reservescucInputDetails(idx_r(1:deletenumberofgen),:)=[];
reserveCost(idx_r(1:deletenumberofgen),:)=[];


for i=1:length(reserveCost)
    for j=1:length(reserveCost(1,:))
        reserveCost{i,j} = num2cell(0);
        if(j==1)
            reserveCost{i,j} = num2cell(0);
        end
    end
end


for i=1:length(reservescucInputDetails)
    for j=4:5
        reservescucInputDetails(i,j) = num2cell(0);
    end
end

for i=1:length(reserveDetails)
    reserveDetails{i,4}=num2cell(CANARY_ACOEFF);
    reserveDetails{i,5}=num2cell(CANARY_BCOEFF);
end

nReserveGenData = length(reserveName);

if(RESERVEGENERATORS==1)
    genDetails=[genDetails;reserveDetails];
    genName=[genName;reserveName];
    scucInputDetails=[scucInputDetails;reservescucInputDetails];
    genCost=[genCost;reserveCost];
end


%%

%%
% LoadData
% Load Data for January Day 1



