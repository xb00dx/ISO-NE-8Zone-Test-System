
load('../data/initializeData/gui.mat')

% The output files will be created in 'mainDir\Output'
mainDir = '~/LocalFiles/ResultsFor8ZonePaper/';

testcaseDir = 'Output/SimTestCase/';

[s,mess,messid]=mkdir(fullfile(mainDir,testcaseDir));

% With or Without WIND
% wind in NetLoadCase = 1 for with wind
% wind in NetLoadCase = 0 for without wind

if(max(windPenGUI)~=0)
    windInNetLoadCase = 1;
else
    windInNetLoadCase = 0;    
end

% This creates runs that are either stochastic or deterministic
% To create only deterministic test cases
% typeOfRun = [1];
% To create only stochastic test cases
% typeOfRun = [0];

typeOfRun = typeOfSCUCGUI;

% Default values for capacity margin, scaling
% of startup, shutdown and noload cost
% capmargin value does not matter in version of AMES on 2014/05/03.
% TODO - fix capmargin in AMES
capmargin=capMarGUI; scalesscost = SSSCostGUI; scalenoloadcost(1) = SNLCostGUI;
%capmargin(2)=125; scalesscost(2) = 1; scalenoloadcost(2) = 1; 
%capmargin(3)=125; scalesscost(3) = 1; scalenoloadcost(3) = 1; 

% Set scaling factor for minimum up and down time
SCALEMINUPDOWNTIME = 1;

% To test different reserve margins
scalereserverequirements = SRRGUI;

% To test different penetrations
scalewindpen=windPenGUI;  
% scalewindpen(2)=.2; 
% scalewindpen(3)=.1; 
%scalewindpen(2)=0;

% To test different volatilities
scalewindvol = windVolGUI;
%scalewindvol(2) = .5; 
%scalewindvol(3) = .2; 

% the months that load and wind cases are to be generated for
setOfMonths = setOfMonthsGUI;% 3 5 7 9 11];

% Set maximum number of days
% 
MAX_DAY=maxDayGUI;

if(windInNetLoadCase==1)
    if(MAX_DAY>2)
        display('Error : Maximum day for with wind case = 2')
        break;
    end
end

% Set scaling for load
scalingFactorLoad = scalingFactorLoadGUI;

% Set number of scenarios
NUM_SCENARIOS=numSCNGUI;
NUM_REALIZED_SCENARIOS=numRealizedSCNGUI;

% Set required number of generators. Must be less than 170
%numGenCase(1) = 15;
%numGenCase(2) = 25;
folder = [pwd '/../data/genData/'];
    
if isstr(numGenGUI)
    fullFileName = fullfile(folder, numGenGUI);
    if exist(fullFileName, 'file') == 2
        load(fullFileName);
    else
        display('Stopping : Error Occurred. Generator Data file does not exist')    
        errorCode = 1;
        break
    end
numGenCase(1) = length(dataGen(:,1));
else
numGenCase(1) = numGenGUI;
end

% Set number of darts (number of darts = number of scenarios)
NUM_DARTS = NUM_REALIZED_SCENARIOS;

% Choose if Canary Generators are to be included into the testcase
% CANARYGENERATORS = 0 if no canary generators are required
% CANARYGENERATORS = 1 if canary generators are required
% canary generators are fictional generators
% canary generators provide additional generation at every zone
% canary generators may or may not included in the SCUC
% canary generators are included in the SCED
CANARYGENERATORS = 0;

% Choose if Canary Generators are to be included into the testcase
% as ALERTGENCOS or CANARYGENERATORS.
% ALERTGENCOS are not included in the SCUC
% CANARYGENERATORS are included in the SCUC
% PRINTCANARYGENERATORS = 1 for ALERTGENCOS based on CANARY
PRINTCANARYGENERATORS = 0;

% Choose if Reserve Generators are to be included into the testcase
% RESERVEGENERATORS = 0 if no reserve generators are required
% RESERVEGENERATORS = 1 if reserve generators are required
% reserve units have characteristics from NG generators in dataset
% reserve generators provide additional generation at every zone
% reserve generators may or may not included in the SCUC
% reserve generators are included in the SCED
RESERVEGENERATORS = 1;

% Choose if Reserve Generators are to be included into the testcase
% as ALERTGENCOS or RESERVEGENERATORS.
% ALERTGENCOS are not included in the SCUC
% RESERVEGENERATORS are included in the SCUC
% PRINTRESERVEGENERATORS = 1 for ALERTGENCOS based on RESERVES
PRINTRESERVEGENERATORS = 0;

if(PRINTRESERVEGENERATORS==0&&RESERVEGENERATORS==1)
capmargin(1)=125;
end

% Set hourly system wide reserves
RESERVEREQUIREMENTS = RRGUI; %1000;

TEST = 0;

%
probability = [];
probability_realized = [];
% initialize treatmentfactors to be saved as .mat files
tf_REQGEN = [];
tf_MonthNum = [];
tf_MonthString = [];
tf_ReserveRequirements = [];
tf_WindPen = [];
tf_SSCOST = [];
tf_NOLOADCOST = [];
tf_CAP_MARGIN = [];



% Initializing from ReadData

SCOST=0;
LLIMIT=0;
INITIALMONEY=1000000;
MAXCAP=10000;
SUSCEPTANCE=100;
NOLOADCOST=50;
STARTUPCOST=1;
SHUTDOWNCOST=1;

CANARY_ACOEFF = 150;
CANARY_BCOEFF = .03;
CANARY_MAXCAP = 9999;

FASTSTART_ACOEFF = 75;
FASTSTART_BCOEFF = .02;

% if(exist('REQGEN') == 0)
%     REQGEN = 12;
%     display('Creating REQGEN')
% end

IGNOREFIXEDDEMAND = 1;


% Calculate number of cases
numCases = length(scalewindpen)*length(setOfMonths)*...
    length(scalereserverequirements)*length(numGenCase)*length(scalenoloadcost)...
    *length(scalesscost)*length(capmargin);

display(['Generating ' num2str(numCases) ' Test Cases'])
