%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Date 2014-05-03


%%

% for wind data, First day load is repeated
% Therefore MAX_DAY = MAX_DAY+1 

MAX_DAY = MAX_DAY+1;
casenumber = 0;

for iSetOfMonths = setOfMonths
    for iScaleWindPen = scalewindpen
        for iScaleWindVol = scalewindvol
        WIND_PEN = iScaleWindPen;
        numMonthIdx = iSetOfMonths; 
        WIND_VOL = iScaleWindVol;
        if matlabVersion == oldVersion
            [MonthNum,MonthString] = month([sprintf('%02d',iSetOfMonths) '-' sprintf('%02d',iSetOfMonths) '-2004']) ;
        else
            MonthNum = month(datetime([sprintf('%02d',iSetOfMonths) '-' sprintf('%02d',iSetOfMonths) '-2004'],'InputFormat','dd-MM-yyyy')) ;
            MonthString = month(datetime([sprintf('%02d',iSetOfMonths) '-' sprintf('%02d',iSetOfMonths) '-2004'],'InputFormat','dd-MM-yyyy'),'shortname');
        end
            % scenario generation
            windandloadcasegenerator
            tempProbability = p;
            tempProbability_realized = p_realized;
            for iNumGenCase = numGenCase
                for iScaleReserveRequirements = scalereserverequirements
                    for iScaleNoLoadCost = scalenoloadcost
                        for iScaleSSCost = scalesscost
                            for iCapMargin = capmargin
                            
%for casenumber = 0:(numCases-1)
    display(['Iteration ' num2str(casenumber+1)])    
	
    CAP_MARGIN = iCapMargin;
    SCALE_NOLOAD_COST = iScaleNoLoadCost;%scalenoloadcost(rem(casenumber,length(scalewindpen))+1);
    SCALE_SS_COST = iScaleSSCost;%scalesscost(floor((rem(casenumber,9))/3)+1);
    ReserveRequirements = iScaleReserveRequirements*RESERVEREQUIREMENTS;
    REQGEN = iNumGenCase;
    
	display(['Number of generators : ' num2str(REQGEN)])
	display(['Reserve Requirements : ' num2str(ReserveRequirements)])
	display(['Capacity Margin : ' num2str(CAP_MARGIN)])
	display(['Wind penetration : ' num2str(WIND_PEN)])
	
    % Three treatment factors
    %WIND_PEN = scalewindpen(rem(casenumber,length(scalewindpen))+1);
    %numMonthIdx = rem(floor(casenumber/length(scalewindpen)),length(setOfMonths))+1;
    %ReserveRequirements = scalereserverequirements(floor(casenumber/(numCases/length(scalereserverequirements)))+1)*RESERVEREQUIREMENTS;
    
    probability = [probability;tempProbability'];        
    probability_realized = [probability_realized;tempProbability_realized'];        
    tf_SSCOST = [tf_SSCOST; SCALE_SS_COST];
    tf_NOLOADCOST = [tf_NOLOADCOST; SCALE_NOLOAD_COST];
    tf_CAP_MARGIN = [tf_CAP_MARGIN; CAP_MARGIN];
    tf_REQGEN = [tf_REQGEN;REQGEN];
    tf_MonthNum = [tf_MonthNum;MonthNum];
    tf_MonthString = [tf_MonthString;MonthString];
    tf_ReserveRequirements = [tf_ReserveRequirements;ReserveRequirements];
    tf_WindPen = [tf_WindPen; WIND_PEN];
    
%    initializeTestCaseParameters
    
    initializeGenData
    initializeTransmissionLineData
    initializeLoadData
    
    formatGenData    
    formatTransmissionLineData    
    formatLoadData
    
    p = (1:NUM_DARTS)+1;
    
    for dart = 1:NUM_REALIZED_SCENARIOS
        %randomNumber = ceil(dart*NUM_SCENARIOS/NUM_DARTS);
        %randomScenarioNumber = randomNumber;
        SaveData
    end
    
    clc
    
    casenumber = casenumber + 1;
                        end % end cap margin
                    end % end wind pen
                end % end scale sscost
            end % end noload cost
        end % end reserve requirements
        end
    end % end set of months
end % end number of generators

