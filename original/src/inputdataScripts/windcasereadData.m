
for iter=1:4
    clc
    clearvars -except iter
    num_days = 4;


if iter==1
    windcase = 'BASECASE';
elseif iter==2
    windcase = '10PERCENT';
elseif iter==3
    windcase = '20PERCENT';
else
    windcase = 'MAXPERCENT';
    display(windcase);
end

%%
% change folderAnalogTimes and folderWindData to actual data location

%folderAnalogTimes = 'C:\Users\wanningl\Dropbox\ARPA-E Stochastic SCUC\3TIERData\sandia_arpa-e_analog_forecasts\';
%fileAnalogTimes = 'ISONE-00UTC-analog-times.csv';

folderAnalogTimes = 'C:\Local Files\Dropbox\Archive\SharedFolder\ARPA-E Stochastic SCUC\WIND\Wind-3TIER\sandia_arpa-e_analog_forecasts\';
fileAnalogTimes = 'ISONE-00UTC-analog-times.csv';

% folderWindData = 'C:\Users\wanningl\Downloads\Onshore_Forecasts_nonPJM\';
% fileSummary = 'eastern_wind_dataset_site_summary.xlsx';

folderWindData = 'C:\Local Files\ISONE_WindData\';

if(strcmp(windcase,'BASECASE'))
    fileSummary = 'eastern_wind_dataset_site_summary2.xlsx';
elseif(strcmp(windcase,'10PERCENT'))
    fileSummary = 'eastern_wind_dataset_site_summary3.xlsx';
elseif(strcmp(windcase,'20PERCENT'))
    fileSummary = 'eastern_wind_dataset_site_summary4.xlsx';
else
    fileSummary = 'eastern_wind_dataset_site_summary.xlsx';
end
%%
%

if(strcmp(windcase,'10PERCENT')|strcmp(windcase,'20PERCENT'))
    numSheets = 2;
else
    numSheets = 1;
end
    
for iSheet=1:numSheets

fileName = fullfile(folderWindData,fileSummary);
if(strcmp(windcase,'BASECASE'))
    sheet = 'Sheet1';
    folderWindType = 'Onshore_Forecasts_nonPJM\';
else
    if(iSheet==2)
        sheet = 'Onshore_Sites';
        folderWindType = 'Onshore_Forecasts_nonPJM\';
    else
        sheet = 'Offshore_Sites'; 
        folderWindType = 'Offshore_ND_Forecasts_nonPJM\';
    end
end
    
if(exist(fullfile(pwd,['wind_' sheet windcase '_' num2str(num_days) '.mat']), 'file'))
    continue
end

[numData,textData,rawData] = xlsread(fileName,sheet);


%%
%

if strcmp(sheet,'Offshore_Sites')
STATE_NAMES = {'CT';
    'RI';
    'ME';
    'NH';   
    'VT';
    'MA'};
else
STATE_NAMES = {'Connecticut';
    'Rhode Island';
    'Maine';
    'New Hampshire';   
    'Vermont';
    'Massachusetts'};
end
    for i=1:length(STATE_NAMES)
        if(~isempty(find(strcmp(STATE_NAMES(i),textData))))
            filesNumber{i,1} = numData(find(strcmp(STATE_NAMES(i),textData))-length(textData)-1);
        end
    end
    

%%
%
fileID = fopen(fullfile(folderAnalogTimes,fileAnalogTimes));
C = textscan(fileID, ['%*s %*s ' repmat('%s ',1,50)],'HeaderLines', 1, 'Delimiter', ',');
fclose(fileID);

%%
%

NUM_ZONES=6;
NUM_SCENARIOS=50; %length(C)
NUM_HOURS=24*num_days; %length([C{1}{:}])

disp('Generating Scenario load')    
displayPrint = 'Generating Scenario load\n';


disp(['wind_' sheet windcase])

wind = zeros(NUM_HOURS,NUM_SCENARIOS,NUM_ZONES);

for scenario=1:NUM_SCENARIOS
    for hour=1:NUM_HOURS  
        str = C{scenario}{hour};
        str=regexp(str,'[0-9- ]+:','match','once');
        dateVector=datevec(str); dateVector(5:end) = [];
        for zone=1:NUM_ZONES
            for file=1:length(filesNumber{zone,1})
                temp = dir(fullfile([folderWindData folderWindType 'ND'],['*' sprintf('%05.0f',filesNumber{zone,1}(file)) '*.csv']));
                if(isempty(temp))
                    display('Empty file')
                    continue;
                else
                    fileID = fopen([folderWindData folderWindType 'ND\' temp.name]);
                    data = textscan(fileID,'%s %s %f %*s %*s','HeaderLines', 1, 'Delimiter', ',');
                    data{1,1}=strtrim(data{1,1});
                    ele = find(strcmp([num2str(dateVector(1)) sprintf('%02d',dateVector(2)) sprintf('%02d',dateVector(3))],data{1,1}),1,'first')+dateVector(4);
                    wind(hour,scenario,zone) = wind(hour,scenario,zone) + data{1,3}(ele);
                    fclose(fileID);
                end
            end
        end
    disp(['Hour ' num2str(hour)])        
    end
    clc
    fprintf(displayPrint)
    disp(['Scenario ' num2str(scenario) ' wind completed'])
    displayPrint = [displayPrint 'Scenario ' num2str(scenario) ' wind completed\n'];
end

save(['wind_' sheet windcase '_' num2str(num_days)], 'wind')
clc

end % end sheet

end % end iter
