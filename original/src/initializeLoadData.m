%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Initialize Load Data

%%

display('Load Data from ISO-NE file');


    folder = [pwd '/../data/testcaseData/'];
    fullFileName = fullfile(folder, ['loadData_ISONE.mat']);
    if exist(fullFileName, 'file')
    load(fullFileName);
    else
    display('Stopping : Error Occurred. Test Case Load Data file does not exist')    
    break
    end
    
nLse=length(dataLse(:,1));
