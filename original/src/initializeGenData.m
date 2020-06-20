%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Initialize Generator Data

%%
    
% Run initialize input data    
% ReadData_8Zone_8bus_Ngenerators


%% 

display('Generator Data from ISO-NE file');

    folder = [pwd '/../data/genData/'];
    
    if isstr(numGenGUI)
        fullFileName = fullfile(folder, numGenGUI);
    else
        if REQGEN == 50;
            fullFileName = fullfile(folder, ['genData_ISONE.mat']);
        else
        fullFileName = fullfile(folder, ['genData_test.mat'] );
        end
    end
    
    if exist(fullFileName, 'file') == 2
        load(fullFileName);
    else
        display('Stopping : Error Occurred. Generator Data file does not exist')    
        errorCode = 1;
        break
    end
    
% Initializations.

nGen=length(dataGen(:,1));

nReserveGenData = length(reserveName);
