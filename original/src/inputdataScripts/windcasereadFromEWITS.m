
for iter=1:3
    clc
    clearvars -except iter
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

folderWindData = 'C:\Local Files\ISONE_WindData\';
%folderWindData = '/Users/Dheepak/Desktop';

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
    
for numMonth=1:12

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

[MonthNum, MonthString] = month([sprintf('%02d',numMonth) '-' sprintf('%02d',numMonth) '-2004']);

if(exist(fullfile(pwd,['wind_EWITS' sheet windcase '_' MonthString '.mat']), 'file'))
    disp(['wind_EWITS' sheet windcase '_' MonthString '.mat already exists'] )
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
    

% %%
% %
% fileID = fopen(fullfile(folderAnalogTimes,fileAnalogTimes));
% C = textscan(fileID, ['%*s %*s ' repmat('%s ',1,50)],'HeaderLines', 1, 'Delimiter', ',');
% fclose(fileID);

%%
%

NUM_ZONES=6;
NUM_SCENARIOS=30*3; %length(C)
NUM_HOURS=48; %length([C{1}{:}])

disp('Generating Scenario wind')    
displayPrint = 'Generating Scenario wind\n';


disp(['wind_' sheet windcase '_' MonthString])

wind = zeros(NUM_HOURS,NUM_SCENARIOS,NUM_ZONES);

for scenario=1:NUM_SCENARIOS
        dateVector=datevec([num2str(2004+floor((scenario-1)/30)) '-' sprintf('%02d',numMonth) '-' num2str(rem(scenario-1,30)+1)]); dateVector(5:end) = [];
        for zone=1:NUM_ZONES
            for file=1:length(filesNumber{zone,1})
                temp = dir(fullfile([folderWindData folderWindType 'ND'],['*' sprintf('%05.0f',filesNumber{zone,1}(file)) '*.csv']));
                if(isempty(temp))
                    continue
                end
                fileID = fopen([folderWindData folderWindType 'ND\' temp.name]);
                data = textscan(fileID,'%s %s %f %*s %*s','HeaderLines', 1, 'Delimiter', ',');
                fclose(fileID);
                data{1,1}=strtrim(data{1,1});
                dateVector(4)=0;
                ele = find(strcmp([num2str(dateVector(1)) sprintf('%02d',dateVector(2)) sprintf('%02d',dateVector(3))],data{1,1}),1,'first')+dateVector(4);
                for hour=1:NUM_HOURS  
                    wind(hour,scenario,zone) = wind(hour,scenario,zone) + data{1,3}(ele);
                    ele=ele+1;
                    %disp(['Hour ' num2str(hour)])        
                end
            end
        end
    disp(['Scenario ' num2str(scenario) ' wind completed'])
%    displayPrint = [displayPrint 'Scenario ' num2str(scenario) ' wind completed\n'];
end

save(['wind_EWITS' sheet windcase '_' MonthString], 'wind')
clc

end % end sheet

end

end