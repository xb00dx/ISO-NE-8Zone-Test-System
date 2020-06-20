%clear
%clc

%%
% Based on data derived from Analog times

 zonenoME = 1;
 zonenoNH = 2;
 zonenoVT = 3;
 zonenoCT = 4;
 zonenoRI = 5;
 zonenoSEMASS = 6;
 zonenoWCMASS = 7;
 zonenoNEMASS = 8;

if(~exist('MAX_DAY'))
    MAX_DAY=5;
end
if(~exist('NUM_ZONES'))
    NUM_ZONES=8;
end

if(~exist('WIND_VOL'))
    WIND_VOL =1;
end

NUM_HOURS=MAX_DAY*24;

% load('selected_wind.mat')
% NUM_SCENARIOS = 5;
% windData = sum(selected_wind,3);

%load('windmass.mat')
%load('wind48hr5zone.mat')
if(~exist('NUM_SCENARIOS'))
    NUM_SCENARIOS = 5;
    display('Creating NUM_SCENARIOS = 5')
end

if(~exist('WIND_PEN'))
    WIND_PEN=0;
    display('Creating WIND_PEN = 0')
end
% if(~exist('WIND_VOL'))
%     WIND_VOL=.2;
%     display('Creating WIND_VOL = 0.2')
% end
if(~exist('MonthString'))
    MonthString='Jan';
    display('Creating MonthString = Jan')
end

%%

display('Loading wind and load data')


if(WIND_PEN == 0)
%folder = [pwd '/../data/windData/'];
%fullFileName = fullfile(folder, strcat('/wind_EWITSSheet1BASECASE_',MonthString,'.mat'));
if matlabVersion == oldVersion
    fileName = fullFileName;
else
    fileName = fullFileName{1};    
end

if exist(fileName, 'file') == 2
load(fileName);
else
display('Stopping : Error Occurred. Wind Data File does not exist')    
break
end

wind = zeros(90,24,8)
temp = wind;
wind(:,:,7:8) = 0;
wind(:,:,1) = 0;
wind(:,:,2) = 0;
wind(:,:,3) = 0;
wind(:,:,4) = 0;
wind(:,:,5) = 0;
wind(:,:,6) = 0;
wind(:,:,7) = 0;
wind(:,:,8) = 0;
end
    
if(WIND_PEN == .1)
folder = [pwd '\..\data\windData\'];
fullFileName = fullfile(folder, ['/wind_EWITSSheet1BASECASE_' MonthString '.mat']);
if exist(fullFileName, 'file')
load(fullFileName);
else
display('Stopping : Error Occurred. Wind Data File does not exist')    
break
end
temp = wind;
wind(:,:,7:8) = 0;
wind(:,:,1) = temp(:,:,3);
wind(:,:,2) = temp(:,:,4);
wind(:,:,3) = temp(:,:,5);
wind(:,:,4) = temp(:,:,1);
wind(:,:,5) = temp(:,:,2);
wind(:,:,6) = temp(:,:,6);
wind(:,:,7) = 0;
wind(:,:,8) = 0;
end

if(WIND_PEN == .2)
folder = [pwd '\..\data\windData\'];
fullFileName = fullfile(folder, ['wind_EWITSOffshore_Sites10PERCENT_' MonthString '.mat']);
if exist(fullFileName, 'file')
load(fullFileName);
else
display('Stopping : Error Occurred. Wind Data File does not exist')    
break
end
temp = wind;
windOffShore = wind;
windOffShore(:,:,7:8) = 0;
windOffShore(:,:,1) = temp(:,:,3);
windOffShore(:,:,2) = temp(:,:,4);
windOffShore(:,:,3) = temp(:,:,5);
windOffShore(:,:,4) = temp(:,:,1);
windOffShore(:,:,5) = temp(:,:,2);
windOffShore(:,:,6) = temp(:,:,6);
windOffShore(:,:,7) = 0;
windOffShore(:,:,8) = 0;
folder = [pwd '\..\data\windData\'];
fullFileName = fullfile(folder, ['wind_EWITSOnshore_Sites10PERCENT_' MonthString '.mat']);
if exist(fullFileName, 'file')
load(fullFileName);
else
display('Stopping : Error Occurred. Wind Data File does not exist')    
break
end
windOnShore = wind;
wind(:,:,7:8) = 0;
wind(:,:,1) = windOnShore(:,:,3) + windOffShore(:,:,3);
wind(:,:,2) = windOnShore(:,:,4) + windOffShore(:,:,4);
wind(:,:,3) = windOnShore(:,:,5) + windOffShore(:,:,5);
wind(:,:,4) = windOnShore(:,:,1) + windOffShore(:,:,1);
wind(:,:,5) = windOnShore(:,:,2) + windOffShore(:,:,2);
wind(:,:,6) = windOffShore(:,:,6);
wind(:,:,7) = windOnShore(:,:,6);
wind(:,:,8) = 0;
end

if(WIND_PEN == .3)
folder = [pwd '\..\data\windData\'];
fullFileName = fullfile(folder, ['wind_EWITSOffshore_Sites20PERCENT_' MonthString '.mat']);
if exist(fullFileName, 'file')
load(fullFileName);
else
display('Stopping : Error Occurred. Wind Data File does not exist')    
break
end
temp = wind;
windOffShore = wind;
windOffShore(:,:,7:8) = 0;
windOffShore(:,:,1) = temp(:,:,3);
windOffShore(:,:,2) = temp(:,:,4);
windOffShore(:,:,3) = temp(:,:,5);
windOffShore(:,:,4) = temp(:,:,1);
windOffShore(:,:,5) = temp(:,:,2);
windOffShore(:,:,6) = temp(:,:,6);
windOffShore(:,:,7) = 0;
windOffShore(:,:,8) = 0;
folder = [pwd '\..\data\windData\'];
fullFileName = fullfile(folder, ['wind_EWITSOnshore_Sites20PERCENT_' MonthString '.mat']);
if exist(fullFileName, 'file')
load(fullFileName);
else
display('Stopping : Error Occurred. Wind Data file does not exist')    
break
end
windOnShore = wind;
wind(:,:,7:8) = 0;
wind(:,:,1) = windOnShore(:,:,3) + windOffShore(:,:,3);
wind(:,:,2) = windOnShore(:,:,4) + windOffShore(:,:,4);
wind(:,:,3) = windOnShore(:,:,5) + windOffShore(:,:,5);
wind(:,:,4) = windOnShore(:,:,1) + windOffShore(:,:,1);
wind(:,:,5) = windOnShore(:,:,2) + windOffShore(:,:,2);
wind(:,:,6) = windOffShore(:,:,6);
wind(:,:,7) = windOnShore(:,:,6);
wind(:,:,8) = 0;
end

% load('windloadData.mat')
% load('windScenariosData.mat');

if(WIND_PEN==0)
    windData = zeros([(MAX_DAY-1)*24 90 8]);
else       
    windData = wind;
end

windPenetration = WIND_PEN;

windVolatility = WIND_VOL;

loadForecastErrorPercent = 0;
scaleErrorLoad=0;

date = '1/1/2011';

%%

if(exist('load')~=1)
    folder = [pwd '/../data/loadData/'];
    if(WIND_PEN==0)
        if((MAX_DAY-1)==2)
            fullFileName = fullfile(folder, strcat('conventionalLoad_',MonthString,'.mat'));
        else
            fullFileName = fullfile(folder, strcat('conventionalLoad_',MonthString,'_',num2str(MAX_DAY-1),'.mat'));
        end
    else
        fullFileName = fullfile(folder, ['conventionalLoad_' MonthString '.mat']);
    end
    
    if matlabVersion == oldVersion
        fileName = fullFileName;
    else
        fileName = fullFileName{1};    
    end

    if exist(fileName, 'file') == 2
    load(fileName);
    else    
    
    display('Stopping : Error Occurred. Conventional Load file does not exist')    
    break
    end
end

%%
%

display('Scenario Reduction')

    windScaled=windData;
    select_num=NUM_SCENARIOS;
    windandloadScenarioReduction
    temp = p;
    
    for zone=1:NUM_ZONES
        for scenario=1:NUM_SCENARIOS
            windData(:,scenario,zone)=selected_scenarios(scenario,1+HOURS*(zone-1):HOURS*zone);    
            loadData(:,scenario,zone)=selected_scenarios(scenario,((MAX_DAY-1)*24*NUM_ZONES+(1+HOURS*(zone-1))):((MAX_DAY-1)*24*NUM_ZONES+HOURS*zone));    
        end
    end
    
    % Scale the Load and the Wind according to scaling factor
windData = windData * scalingFactorLoad;
loadData = loadData * scalingFactorLoad;

    select_num=NUM_REALIZED_SCENARIOS;
    windandloadScenarioReduction

    for zone=1:NUM_ZONES
        for scenario=1:NUM_REALIZED_SCENARIOS
            windDataRealized(:,scenario,zone)=selected_scenarios(scenario,1+HOURS*(zone-1):HOURS*zone);    
            loadDataRealized(:,scenario,zone)=selected_scenarios(scenario,((MAX_DAY-1)*24*NUM_ZONES+(1+HOURS*(zone-1))):((MAX_DAY-1)*24*NUM_ZONES+HOURS*zone));    
        end
    end
    
    % Scale the Load and the Wind according to scaling factor
windDataRealized = windDataRealized * scalingFactorLoad;
loadDataRealized = loadDataRealized * scalingFactorLoad;


clear load;
p_realized = p;
p = temp;
    
%    p = p - 0.00001;
    
%    1- sum(p)
% % New England 1,184
% % Connecticut 0
% % Maine 657
% % Massachusetts 120
% % New Hampshire 255
% % Rhode Island 0
% % Vermont 149
% 


%%
% control file
for realizedScenarioNumber = 1:NUM_REALIZED_SCENARIOS
display(['Test Case - Actualized load equal to scenario ' num2str(realizedScenarioNumber)])       

%realizedScenarioNumber = round(rand(1)*(NUM_SCENARIOS-1) + 1);
if (~exist('mainDir'))
    currDir = pwd;
    mainDir  = fileparts(currDir);
end

name = ['master_control_file.dat'];
testcaseFolderName=strcat('TestCase_',num2str(windPenetration*100),'_',MonthString,'_',num2str(realizedScenarioNumber));

if matlabVersion == oldVersion
    testcaseFolder = testcaseFolderName;
else
    testcaseFolder = testcaseFolderName{1};    
end

[s,mess,messid]=mkdir(fullfile(mainDir,'Output/LoadCases/',testcaseFolder));
name = fullfile(mainDir,strcat('Output/LoadCases/',testcaseFolder,'/',name));

if matlabVersion == oldVersion
    fileName = name;
else
    fileName = name{1};    
end

fileID = fopen(fileName,'w');

strTemp = 'CaseName : AMESsingle\n';
strTemp = [strTemp 'NumZones : 8\n'];
strTemp = [strTemp 'NumScenarios : ' num2str(NUM_SCENARIOS) '\n'];
strTemp = [strTemp 'MaxDay : ' num2str(MAX_DAY) '\n'];
   
for day=1:MAX_DAY

    dateString = datestr(datenum(date,'mm/dd/yyyy',1900)+day-1,'yyyy-mm-dd');
    strTemp = [strTemp 'Day ' num2str(day) ' Aux_Control_File : ' dateString '/aux_control.dat\n'];
    
end

fprintf(fileID,strTemp);
fclose(fileID);

%%
% load

fakeday = 1;

for day=1:MAX_DAY
    
    dayExists=0;

    dateString = datestr(datenum(date,'mm/dd/yyyy',1900)+day-1,'mm/dd/yyyy');

    aLoad = [];
    aWind = [];
    
    scenario = realizedScenarioNumber;
    
    if(day>1)
        fakeday = 0;
        day=day-1;
    end
    
    for hour=1:24
%        aLoad(:,hour) = [numDataNH(hour,2);numDataVT(hour,2);numDataME(hour,2);numDataCT(hour,2);numDataRI(hour,2);numDataSEMASS(hour,2);numDataWCMASS(hour,2);numDataNEMASS(hour,2)];
        aLoad(:,hour) = [loadDataRealized((day-1)*24+hour,scenario,1);
                            loadDataRealized((day-1)*24+hour,scenario,2);
                            loadDataRealized((day-1)*24+hour,scenario,3);
                            loadDataRealized((day-1)*24+hour,scenario,4);
                            loadDataRealized((day-1)*24+hour,scenario,5);
                            loadDataRealized((day-1)*24+hour,scenario,6);
                            loadDataRealized((day-1)*24+hour,scenario,7);
                            loadDataRealized((day-1)*24+hour,scenario,8)];
        aWind(:,hour) = [windDataRealized((day-1)*24+hour,scenario,1);
                            windDataRealized((day-1)*24+hour,scenario,2);
                            windDataRealized((day-1)*24+hour,scenario,3);
                            windDataRealized((day-1)*24+hour,scenario,4);
                            windDataRealized((day-1)*24+hour,scenario,5);
                            windDataRealized((day-1)*24+hour,scenario,6);
                            windDataRealized((day-1)*24+hour,scenario,7);
                            windDataRealized((day-1)*24+hour,scenario,8)];
    end

        
    for scenario=1:NUM_SCENARIOS
            for hour=1:24
                sLoad(scenario,:,hour)=[loadData((day-1)*24+hour,scenario,1);loadData((day-1)*24+hour,scenario,2);loadData((day-1)*24+hour,scenario,3);loadData((day-1)*24+hour,scenario,4);loadData((day-1)*24+hour,scenario,5);loadData((day-1)*24+hour,scenario,6);loadData((day-1)*24+hour,scenario,7);loadData((day-1)*24+hour,scenario,8)];
            end
    end

    eLoad = zeros(NUM_ZONES,24);
 
     for scenario=1:NUM_SCENARIOS
        for hour=1:24
             sWind(scenario,:,hour)=[windData((day-1)*24+hour,scenario,1);windData((day-1)*24+hour,scenario,2);windData((day-1)*24+hour,scenario,3);windData((day-1)*24+hour,scenario,4);windData((day-1)*24+hour,scenario,5);windData((day-1)*24+hour,scenario,6);windData((day-1)*24+hour,scenario,7);windData((day-1)*24+hour,scenario,8)];          
        end
     end
    
     
% from scenarios find expected


    for zone=1:NUM_ZONES
        for hour=1:24
            for scenario=1:NUM_SCENARIOS
            eLoad(zone,hour) = eLoad(zone,hour) +  p(scenario)*(sLoad(scenario,zone,hour)); 
            end
        end
    end
    

%     for scenario=1:NUM_SCENARIOS
%     
%         avgWind = mean(reshape(sWind(scenario,:,:),[],24),2);
%            
%         for zone=1:NUM_ZONES
%             for hour=1:24
%                 sWind(scenario,zone,hour) = avgWind(zone) + windVolatility*(sWind(scenario,zone,hour)-avgWind(zone));
%             end
%         end
%     
%     end
    
%    sWind(find(sWind<0)) = 0;
    
    eWind = zeros(NUM_ZONES,24);

    for zone=1:NUM_ZONES
        for hour=1:24
            for scenario=1:NUM_SCENARIOS
            eWind(zone,hour) = eWind(zone,hour) +  p(scenario)*sWind(scenario,zone,hour); 
            end
        end
    end

    
%%
    
%    eWind(find(eWind<0)) = 0;
%    day = temp;
%   actualLoad;

    if(fakeday~=1)
        day=day+1;
    end
    
    dateString = datestr(datenum(date,'mm/dd/yyyy',1900)+day-1,'yyyy-mm-dd');
    folderName = dateString;
    temp = strcat('Output/LoadCases/',testcaseFolder,'/',folderName);
    if matlabVersion == oldVersion
        fileName = temp;
    else
        fileName = temp{1};    
    end
    [s,mess,messid]=mkdir(fullfile(mainDir,fileName));
    name = fullfile(mainDir,strcat('Output/LoadCases/',testcaseFolder,'/',folderName,'/','ActualLoadData_',num2str(day),'.dat'));
    if matlabVersion == oldVersion
        fileName = name;
    else
        fileName = name{1};    
    end
    fileID = fopen(fileName,'w');
    strTemp = ['//Actual Loads for day ' num2str(day) '\n'];
    strTemp = strcat(strTemp,'PartOf : AMESsingle , ActualLoad\n');
    strTemp = strcat(strTemp,['Day : ' num2str(day) '\n']);
    strTemp = strcat(strTemp,'Hour ME NH VT CT RI SEMASS WCMASS NEMASSBOST\n');
    for hour=1:24
        for zone=1:8
            if(zone==1)
                strTemp = strcat(strTemp,[num2str(hour) ' ' num2str(aLoad(zone,hour)-aWind(zone,hour)) ' \t']);
            elseif(zone==8)
                strTemp = strcat(strTemp,[num2str(aLoad(zone,hour)-aWind(zone,hour)) ' ' '\n']);
            else
                strTemp = strcat(strTemp,[num2str(aLoad(zone,hour)-aWind(zone,hour)) ' \t']);
            end
        end
    end
    fprintf(fileID,strTemp);
    fclose(fileID);
    

% expected load  

    name = fullfile(mainDir,strcat('Output/LoadCases/',testcaseFolderName,'/',folderName,'/','ExpectedLoad_',num2str(day),'.dat'));
    if matlabVersion == oldVersion
        fileName = name;
    else
        fileName = name{1};    
    end
    fileID = fopen(fileName,'w');
    strTemp = ['//Expected Loads for day ' num2str(day) '\n'];
    strTemp = strcat(strTemp,'PartOf : AMESsingle , ExpectedLoad\n');
    strTemp = strcat(strTemp,['Day : ' num2str(day) '\n']);
    strTemp = strcat(strTemp,'Hour ME NH VT CT RI SEMASS WCMASS NEMASSBOST\n');
    for hour=1:24
        for zone=1:8
            if(zone==1)
                strTemp = strcat(strTemp,[num2str(hour) ' ' num2str(eLoad(zone,hour)-eWind(zone,hour)) ' \t']);
            elseif(zone==8)
                strTemp = strcat(strTemp,[num2str(eLoad(zone,hour)-eWind(zone,hour)) ' ' '\n']);
            else
                strTemp = strcat(strTemp,[num2str(eLoad(zone,hour)-eWind(zone,hour)) ' \t']);
            end
        end
    end
    fprintf(fileID,strTemp);
    fclose(fileID);
    
%  scenarioLoad;

    for scenario=1:NUM_SCENARIOS
        
        name = fullfile(mainDir,strcat('Output/LoadCases/',testcaseFolderName,'/',folderName,'/','AMESscenLoad',num2str(scenario),'_',num2str(day),'.dat'));
        if matlabVersion == oldVersion
            fileName = name;
        else
            fileName = name{1};    
        end
        fileID = fopen(fileName,'w');
        strTemp = ['//Scenario ' num2str(scenario) 'Loads for day ' num2str(day) '\n'];
        strTemp = strcat(strTemp,['PartOf : AMESsingle , Scenario ' num2str(scenario) ' Load\n']);
        strTemp = strcat(strTemp,['Day : ' num2str(day) '\n']);
        strTemp = strcat(strTemp,'Hour ME NH VT CT RI SEMASS WCMASS NEMASSBOST\n');
        for hour=1:24
            for zone=1:8
                if(zone==1)
                    strTemp = strcat(strTemp,[num2str(hour) ' ' num2str(sLoad(scenario,zone,hour)) ' \t']);
                elseif(zone==8)
                    strTemp = strcat(strTemp,[num2str(sLoad(scenario,zone,hour)) ' ' '\n']);
                else
                    strTemp = strcat(strTemp,[num2str(sLoad(scenario,zone,hour)) ' \t']);
                end
            end
        end
        fprintf(fileID,strTemp);
        fclose(fileID);
    
    end
    
    % scenarioWind;
    
    for scenario=1:NUM_SCENARIOS
        
        name = fullfile(mainDir,strcat('Output/LoadCases/',testcaseFolderName,'/',folderName,'/','AMESWind',num2str(scenario),'_',num2str(day),'.dat'));
        if matlabVersion == oldVersion
            fileName = name;
        else
            fileName = name{1};    
        end
        fileID = fopen(fileName,'w');
        strTemp = ['//Wind Data file for scenario number' num2str(scenario) ' for day ' num2str(day) '\n'];
        strTemp = strcat(strTemp,['PartOf : AMESsingle , Scenario ' num2str(scenario) ' Wind\n']);
        strTemp = strcat(strTemp,['Day : ' num2str(day) '\n']);
        strTemp = strcat(strTemp,'Hour ME NH VT CT RI SEMASS WCMASS NEMASSBOST\n');
        for hour=1:24
            for zone=1:8
                if(zone==1)
                    strTemp = strcat(strTemp,[num2str(hour) ' ' num2str(sWind(scenario,zone,hour)) ' \t']);
                elseif(zone==8)
                    strTemp = strcat(strTemp,[num2str(sWind(scenario,zone,hour)) ' ' '\n']);
                else
                    strTemp = strcat(strTemp,[num2str(sWind(scenario,zone,hour)) ' \t']);
                end
            end
        end
        fprintf(fileID,strTemp);
        fclose(fileID);
    
    end
    
    name = fullfile(mainDir,strcat('Output/LoadCases/',testcaseFolderName,'/',folderName,'/','aux_control.dat'));
        if matlabVersion == oldVersion
            fileName = name;
        else
            fileName = name{1};    
        end
        fileID = fopen(fileName,'w');
    strTemp = ['//Auxillary control file for day ' num2str(day) '\n'];    
    strTemp = strcat(strTemp, 'CaseName: AMESsingle\n');
    
    for scenario=1:NUM_SCENARIOS
        strTemp = strcat(strTemp, ['Scenario ' num2str(scenario) ' Day ' num2str(day) ' Prob : ' sprintf('%0.9f',p(scenario)) '\n']);
    end
    for scenario=1:NUM_SCENARIOS
        strTemp = strcat(strTemp, ['Scenario ' num2str(scenario) ' Load Day ' num2str(day) ' File : AMESscenLoad' num2str(scenario) '_' num2str(day) '.dat\n']);
        strTemp = strcat(strTemp, ['Scenario ' num2str(scenario) ' Wind Day ' num2str(day) ' File : AMESWind' num2str(scenario) '_' num2str(day) '.dat\n']);
    end
    strTemp = strcat(strTemp, ['ExpectedLoad Day ' num2str(day) ' : ExpectedLoad_' num2str(day) '.dat\n']);
    strTemp = strcat(strTemp, ['ActualLoad Day ' num2str(day) ' : ActualLoadData_' num2str(day) '.dat\n']);
    fprintf(fileID,strTemp);
    fclose(fileID);
    
end
    
end


%save(['windVol_' num2str(windVolatility) '_' MonthString '.mat'], 'sWind', 'sLoad', 'aWind', 'aLoad', 'eLoad', 'eWind')

%winopen('../Output');
