%%
% Calculating number of buses.
% Since the Unit Data is in a particular format, we can increment a counter
% every time there is a change in the string Node Name

k=0;temp=0;
for i=2:length(unitData(2:539,2))
    if(strcmp(temp,unitData(i,1)))
    else
        k=k+1;
    end
    temp=unitData(i,1);
  
end

nZones=k;

%%
% Forming busDetails
% Storing names of all the zones in ZoneDetails
% Storing names of all the buses required in BusDetails
% 13 Zone - 8Buses


zoneDetails=cell(nZones,2);

k=0;temp=0;
for i=2:length(unitData(2:539,1))
    if(strcmp(temp,unitData(i,1)))
    else
        k=k+1;
        zoneDetails(k,1)=num2cell(k);
        zoneDetails(k,2)=unitData(i,1);
    end
    temp=unitData(i,1);
end


k=0;temp=0;
tempvar = cell(1);
tempvar{1}=strcat('BOST','/NEMA');
for i=1:nZones
    c1=strcmp(zoneDetails(i,2),'SWCT');
    c2=strcmp(zoneDetails(i,2),'NOR');
    c3=strcmp(zoneDetails(i,2),'CMAN');
    c4=strcmp(zoneDetails(i,2),'SME');
    c5=strcmp(zoneDetails(i,2),'BHE');
    if((c1+c2+c3+c4+c5)>0)
    else
        k=k+1;
        busDetails(k,1)=num2cell(k);
        if(strcmp(zoneDetails(i,2),'BOST'))
        busDetails(k,2)=tempvar;
        else
        busDetails(k,2)=zoneDetails(i,2);
        end
    end
    
end

%%

for i=1:length(busDetails(:,2))

    if(strcmp(busDetails(i,2),'SEMA'))
        busDetails{i,2}='SEMASS';  
    end
    if(strcmp(busDetails(i,2),'WMA'))
        busDetails{i,2}='WCMASS';  
    end
    if(strcmp(busDetails(i,2),'BOST/NEMA'))
        busDetails{i,2}='NEMASSBOST';  
    end
     
end

%%
%LSE


%%
% Branch Details
% From To Reactance

display('Branch Data');


for i=2:26;
    branchDetails(i-1,2)=returnnodenumber_8bus(network2(i,2));
    branchDetails(i-1,3)=returnnodenumber_8bus(network2(i,3));
    branchDetails(i-1,4)=0.001; %network2{i,4};
end

% BranchDetails contains data for all branches (From and To) of a 13 zone
% network. Since we have reduced this to 8 zones, we can delete rows
% that have common from and to nodes.

% IMPORTANT! At a later stage we must see to it that the impedance in each 
% of the deleted row is taken into account while forming the impedance
% between the two zones.

k=0;deleteRow=0;
for i=1:25
    if(branchDetails(i,2)==branchDetails(i,3))
        k=k+1;
        deleteRow(k)=i;
    elseif(or(branchDetails(i,2)==14,branchDetails(i,3)==14))
        k=k+1;
        deleteRow(k)=i;
    end
end

if(deleteRow==0)
else
    for i=1:length(deleteRow);
    branchDetails(deleteRow(length(deleteRow)-i+1),:)=[];
    end
end
for i=1:length(branchDetails(:,2))
    if(branchDetails(i,2)>branchDetails(i,3))
        temp=branchDetails(i,3);
        branchDetails(i,3)=branchDetails(i,2);
        branchDetails(i,2)=temp;
    end
end












%%



for i=2:13393
    if(areaLoad{i,4}(end)==' ')
        areaLoad{i,4}=areaLoad{i,4}(1:end-1);
    end
end

for i=2:13393
    if(areaLoad{i,4}(end)==' ')
        areaLoad{i,4}=areaLoad{i,4}(1:end-1);
    end
end

n=length(areaLoad(:,4))-1;
a=0;k=0;

dataLse(1,1:26)=0;
for i=0:((n/744)-1)
    a=(744*i)+2;
    if(areaLoad{a,5}==1)
        k=k+1;
        temp=returnnodenumber_8bus(areaLoad{a,4});
        
        %TODO - Check temp return in array indice
        
        if(temp>8)
        else
        dataLse(temp,1)=temp;
        dataLse(temp,2)=temp;
        dataLse(temp,3:26)=dataLse(temp,3:26)+[areaLoad{a:a+23,8}];
        end
            
    end
end

%%
% Ames rtm Load Data

n=length(areaLoad(:,4))-1;
a=0;k=0;
nDay =31;
nHour = 24;
nZone = 8;
rMonth = 1;
dataLse_rtm(nZone,1:nHour,nDay,rMonth)=0;
for rDay=1:nDay
for i=0:((n/744)-1)
    a=(744*i)+2+(rDay-1)*nHour;
    if(areaLoad{a,5}==rDay)
        k=k+1;
        nameofbus=returnnodenumber_8bus(areaLoad{a,4});
        
        if(nameofbus>8)
        else
            for rHour=1:24;    
            dataLse_rtm(nameofbus,rHour,rDay,rMonth)=dataLse_rtm(nameofbus,rHour,rDay,rMonth)+[areaLoad{a+rHour-1,8}];
            end
        end
            
    end
end
end



%%
%        1-ID 2-atBus 3-Scost 4-a 5-b 6-CapL 7-CapU 8-InitMoney

% genDetails_N=cell(nGen,8);
% 
% for i=1:nBus
%     genDetails_N{i,7}=0;
%     genDetails_N{i,6}=0;
% 
% end
% k=0;
% new=1;
% temp=0;
% for i=1:length(genDetails(:,1))
%     
%         k=genDetails{i,2};
%         genDetails_N{i,2}=genDetails{i,2};
%         genDetails_N{i,3}=genDetails{i,3};
%         genDetails_N(i,4)=genDetails(i,4);
%         genDetails_N(i,5)=genDetails(i,5);
%         genDetails_N(i,8)=genDetails(i,8);
%         genDetails_N{i,6}=genDetails_N{i,6}+genDetails{i,6};
%         genDetails_N{i,7}=genDetails_N{i,7}+genDetails{i,7}{1,1};
%     
% end

noBus=nGen;
dataGen = [];
dataGenCost = [];

dataGen(:,1)=[1:noBus]';
dataGenCost(:,1)=[1:noBus]';

for i=1:noBus
    dataGen(i,2)=genDetails{i,2};
end
dataGen(:,3)=genDetails{1:noBus,3};

for i=1:noBus
        dataGen(i,4)=genDetails{i,4}{1,1};
        dataGen(i,5)=genDetails{i,5}{1,1};
        dataGen(i,7)=abs(genDetails{i,7}{1,1});
        dataGen(i,6)=genDetails{i,6};
end
    
dataGen(:,8)=[genDetails{1:noBus,8}];
noBus=nGen;
dataScucInput = [];
dataScucInput(:,1)=[1:noBus]';

for i=1:noBus
    if(CANARYGENERATORS==1)
        if(i<=noBus-8)
            dataScucInput(i,2)=scucInputDetails{i,2};
            dataScucInput(i,4)=scucInputDetails{i,4};
            dataScucInput(i,5)=scucInputDetails{i,5};
        else
            dataScucInput(i,2)=scucInputDetails{i,2}{1,1};
            dataScucInput(i,4)=scucInputDetails{i,4}{1,1};
            dataScucInput(i,5)=scucInputDetails{i,5}{1,1};
        end
    else
            dataScucInput(i,2)=scucInputDetails{i,2};
            dataScucInput(i,4)=scucInputDetails{i,4};
            dataScucInput(i,5)=scucInputDetails{i,5};
        
    end
    dataScucInput(i,3)=scucInputDetails{i,3}{1,1};
    dataScucInput(i,7)=scucInputDetails{i,7}{1,1};
    dataScucInput(i,8)=scucInputDetails{i,8}{1,1};
    dataScucInput(i,9)=scucInputDetails{i,9}{1,1};
    dataScucInput(i,10)=scucInputDetails{i,10}{1,1};
    dataScucInput(i,11)=scucInputDetails{i,11}{1,1};
    dataScucInput(i,6)=scucInputDetails{i,6}{1,1};
    dataGenCost(i,1)=genCost{i,1}{1,1};
    dataGenCost(i,2)=genCost{i,2}{1,1};
    dataGenCost(i,3)=genCost{i,3}{1,1};
    dataGenCost(i,4)=genCost{i,4}{1,1};
end

%%

dataGenLearning=unitDataLearning_int(1:538,1:12);
dataGenLearning = [dataGenLearning;zeros(nBus,12)];
