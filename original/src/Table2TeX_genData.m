%%
%

clc
clear

% str = input('Main directory path: ','s');         
% if(exist(str,'dir'))
%          mainDir = str;
% else
%     display('Path does not exist')
%     break
% end

cd(pwd)

load('../data/genData/tableData_dheepak')
%load('../data/genData/genData_GUI_dheepak')
%load('../data/genData/fueltype')


%tableData = {strcat(repmat('Gen',length(dataGen(:,1)),1), num2str(dataGen(:,1),'%02.0f')) ... 
%             dataGen(:,2) dataGen(:,7) fueltype(:) ...
%            dataScucInput(:,4) dataScucInput(:,5) dataScucInput(:,6)  ... 
%            dataGenCost(:,2) dataGen(:,5) dataGen(:,4) };

titleData = {' GenName ', ' Bus No. ', ' Capacity (MW) ', ' Fuel Type ', ... 
    ' Minimum up time ' , ' Minimum down time ' , ' Ramp rate ' , ...
    ' Startup costs ', ' No load costs ', ' a ', ' b ' };
outfile = 'genTable';
formatString = {'%s','%d','%4.2f', '%s' , '%4.1f', '%4.1f', '%4.0f', ...
    '%4.2f', '%4.2f', '%4.5f','%4.2f'};

Table2TeX(outfile,tableData,titleData,formatString)

