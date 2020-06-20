
for SCUC_TYPE=typeOfRun

if(SCUC_TYPE==0)
    nameLoadCase = ['8BusTestCase_Det_Case' num2str(casenumber) '_Scenario' num2str(dart)  '.dat'];
elseif(SCUC_TYPE==1)
    nameLoadCase = ['8BusTestCase_Sto_Case' num2str(casenumber) '_Scenario' num2str(dart) '.dat'];    
end
    
strTemp=[nameLoadCase '\n'];
fprintf(batchFileID,strTemp);

nameLoadCase = ['Output/SimTestCase/' nameLoadCase];

nameBaseLoadProfile='Base_Scenario.dat';
nameExpectedLoadProfile='Expected_Scenario.dat';
nameControlFile = '8BusControlFile.dat';

SaveData_LoadCase

end


