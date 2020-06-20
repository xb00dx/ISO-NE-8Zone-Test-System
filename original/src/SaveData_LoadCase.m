
%Code to convert data from Matlab arrays to Test Case format for AMES
%
%Version1.2

%To do List
% Check temp array indice in LSEData



PRECISION=8;

%%
name=fullfile(mainDir,nameLoadCase);
fileID = fopen(name,'w');
strTemp='';

strTemp = ['// FILENAME ' nameLoadCase '\n'];

fprintf(fileID,strTemp,'\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// UNIT	SI\n');
fprintf(fileID,'// SI (International System of Units) such as MW\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// Case Data File Format 2.0\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// NN: Number of Buses\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// PenaltyWeight: Penalty weight for DC-OPF objective function\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// MaxCap: Thermal limits\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// X: Reactance\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// FCost,a,b: GenCo''s cost attributes\n');
fprintf(fileID,'//\n');
fprintf(fileID,'// capL,capU: GenCo''s operating capacity limits\n');
fprintf(fileID,'//\n');
fprintf(fileID,'//\n');
fprintf(fileID,'//\n');
fprintf(fileID,'\n');

fprintf(fileID,'// UNIT	SI\n');
fprintf(fileID,'BASE_S	100\n');
fprintf(fileID,'BASE_V	10\n\n');

fprintf(fileID,'// Simulation Parameters\n');

fprintf(fileID,['Max_Day       ' num2str(MAX_DAY) '	\n']);
fprintf(fileID,'Random_Seed 67657657\n');
fprintf(fileID,'Threshold_Probability 0.999\n');
if(SCUC_TYPE)
    fprintf(fileID,['Reserve_Requirement ' num2str(0) '\n']);
else
    fprintf(fileID,['Reserve_Requirement ' num2str(ReserveRequirements) '\n']);
end
if(TEST == 1)
        fprintf(fileID,['Load_Case_Control_File ../LoadCases/MATLABGENSCEN/master_control_file.dat\n']);
elseif(TEST == 2)
        fprintf(fileID,['Load_Case_Control_File ../LoadCases/TESTAMESSCEN/master_control_file.dat\n']);
else    
%        fprintf(fileID,['Load_Case_Control_File ../LoadCases/' 'TestCase_' num2str(WIND_PEN*100) '_' num2str(WIND_VOL*100) '_' num2str(randomScenarioNumber) '/master_control_file.dat\n']);
        temp = strcat('Load_Case_Control_File ../LoadCases/','TestCase_',num2str(WIND_PEN*100),'_',MonthString,'_',num2str(dart),'/master_control_file.dat\n');
        if matlabVersion == oldVersion
            fileName = temp;
        else
            fileName = temp{1};    
        end
        fprintf(fileID,fileName);
end
%fprintf(fileID, ['//Load_Case_Control_File ../LoadCase_Dheepak/aux_control.dat\n' '//Load_Case_Control_File 8BusControlFile.dat\n' '//Load_Case_Control_File ../LoadCases/8Bus10Scenario-2013-03-22/master_control_file.dat\n']);

fprintf(fileID, ['Capacity_Margin ' num2str(CAP_MARGIN) '\n']);
fprintf(fileID,'LSEDemandSource LoadCase\n');
if(SCUC_TYPE)
    fprintf(fileID,'SCUC_Type Stochastic\n\n');
else
    fprintf(fileID,'SCUC_Type Deterministic\n\n');
end
%%
fprintf(fileID,'#ZoneNamesStart\n');


for i=1:nBus

    iTemp=returnnodename(i,busDetails);
    strTemp=sprintf('%1$10s',iTemp{1,1});
    strTemp=strcat(strTemp,'\n');
    fprintf(fileID, strTemp);

end

fprintf(fileID,'#ZoneNamesEnd\n\n');


%%

fprintf(fileID,'#NodeDataStart\n');
strTemp=sprintf('//%1$8s\t%2$15s\n', 'NN', 'PenaltyWeight');

fprintf(fileID,strTemp);

dTemp=nodeData(0+1,0+1);
strTemp=sprintf('%1$10.0f', dTemp);

dTemp=nodeData(0+1,1+1);
strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f\n', dTemp));
fprintf(fileID, strTemp);
fprintf(fileID,'\n');
fprintf(fileID,'#NodeDataEnd\n\n');

fprintf(fileID,'#BranchDataStart\n');
strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$15s\t%5$15s\n', 'Name', 'From', 'To', 'MaxCap', 'Reactance');
fprintf(fileID, strTemp);
% fprintf(fileID, '\n');
i=1;j=1;
% strTemp='\n';
iTemp = 1;

%%

for i=1:iBranchData
    
    strTemp=num2str(sbranchData{i,:});
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
    for j=2:5
        
        if(j<(4))
            
            iTemp=returnnodename(branchData(i,j),busDetails);
            strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
        
        elseif(j==(4))
            
            iTemp=branchData(i,j);
            strTemp=strcat(strTemp,'\t', sprintf('%1$10d', iTemp));
            
        else
            dTemp=branchData(i,j);
            strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
            
        end
        
    end
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp);
    
end
fprintf(fileID,'#BranchDataEnd\n');

fprintf(fileID,'\n');
%%


fprintf(fileID,'#GenDataStart\n');
strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$15s\t%5$15s\t%6$15s\t%7$15s\t%8$15s\t%9$15s\n','Name', 'ID', 'atBus', 'FCost', 'a', 'b', 'capL', 'capU', 'InitMoney');
fprintf(fileID,strTemp);
for i=1:(iGenData)
    strTemp=num2str(sgenData{i,:});
    strTemp=sprintf('%1$10s', strTemp);
    
    for j=1+1:9
        
        
        if(j==(3))
            
            iTemp=returnnodename(genData(i,j),busDetails);
            strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
        
        elseif(j<(4))
        
            iTemp=genData(i,j);
            strTemp=strcat(strTemp,'\t',sprintf('%1$10d', iTemp));
            
        else
            dTemp=genData(i,j);
            strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
        end
        
    end
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp);
    
end

fprintf(fileID,'#GenDataEnd\n');
fprintf(fileID,'\n');

%%
%Print Alert GenCo Names

if(PRINTCANARYGENERATORS)
fprintf(fileID,'#AlertGenCoStart\n');
strTemp=sprintf('//%1$8s\n','Name');
fprintf(fileID,strTemp);
for i=1:iAlertGenData
    strTemp=num2str(sgenData{iGenData-iAlertGenData+i,:});
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp);
    
end

fprintf(fileID,'#AlertGenCoEnd\n');
fprintf(fileID,'\n');

%Print reserve GenCo Names

elseif(PRINTRESERVEGENERATORS)
fprintf(fileID,'#AlertGenCoStart\n');
strTemp=sprintf('//%1$8s\n','Name');
fprintf(fileID,strTemp);
for i=1:iReserveGenData
    strTemp=num2str(sgenData{iGenData-iReserveGenData+i,:});
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp);
    
end

fprintf(fileID,'#AlertGenCoEnd\n');
fprintf(fileID,'\n');

end

%%

%Print GenCo NoLoad Cost

fprintf(fileID,'#GenCostStart\n');
strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$10s\t%5$10s\n','GenCo','No Load Cost','Cold Startup Cost','Hot Startup Cost', 'Shutdown Cost');
fprintf(fileID,strTemp);
for i=1:(iGenData)
    strTemp=num2str(sgenData{i,:});
    strTemp=sprintf('%1$10s', strTemp);
    for j=1:length(genCostData(i,:))
            dTemp=genCostData(i,j);
            strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
    end
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp);
    
end

fprintf(fileID,'#GenCostEnd\n');
fprintf(fileID,'\n');

%%

fprintf(fileID,'#ScucInputDataStart\n');

strTemp = sprintf('//%1$10s\t%2$10s\t%3$10s\t%4$10s\t%5$10s\t%6$10s\t%7$10s\t%8$10s\t%9$10s\t%10$10s\t%11$10s\n','Name','PowerT0','UnitOnT0', 'MinUpTime','MinDownTime','NominalRampUp','NominalRampDown','StartupRampLim','ShutdownRampLim','Schedule','Schedule2');
fprintf(fileID,strTemp);

% removed t%10$10s\t%11$10s

for i=1:(iGenData)
    strTemp=num2str(sgenData{i,:});
    strTemp=sprintf('%1$10s', strTemp);
    
    for j=3:12
        
        if(j>=4&j<=6)|(j>10)
        
            iTemp=scucInputData(i,j);
            strTemp=strcat(strTemp,'\t',sprintf('%1$10d', iTemp));
            
        else
            dTemp=scucInputData(i,j);
            strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
        end
        
    end
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp);

    
end

fprintf(fileID,'#ScucInputDataEnd\n\n');


%%

if(IGNOREFIXEDDEMAND==0)


fprintf(fileID,'#LSEDataFixedDemandStart\n');
strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$15s\t%5$15s\t%6$15s\t%7$15s\t%8$15s\t%9$15s\t%10$15s\t%11$15s\n','Name', 'ID', 'atBus', 'H-00', 'H-01', 'H-02', 'H-03', 'H-04', 'H-05', 'H-06', 'H-07');
fprintf(fileID,strTemp);
for i=1:iLSEData;
    
    strTemp=num2str(slseData{i,:}); %.toString();
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
    for j=1+1:10+1
        
        if(j==3)
            iTemp=returnnodename(lseData(i,j),busDetails);
            strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
        
        elseif(j<(3+1))
            
            iTemp=(lseData(i,j));
            strTemp=strcat(strTemp,'\t',sprintf('%1$10d', iTemp));
            
        else
            dTemp=(lseData(i,j));
            strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
        end
        
    end
    
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp,'\n');
    
end





strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$15s\t%5$15s\t%6$15s\t%7$15s\t%8$15s\t%9$15s\t%10$15s\t%11$15s\n','Name', 'ID', 'atBus', 'H-08', 'H-09', 'H-10', 'H-11', 'H-12', 'H-13', 'H-14', 'H-15');
fprintf(fileID,strTemp);
for i=1:iLSEData
    
    strTemp=num2str(slseData{i,:});
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
        j=2;
        iTemp=lseData(i,j);
        strTemp=strcat(strTemp,'\t',sprintf('%1$10d', iTemp));
        j=3;
        iTemp=returnnodename(lseData(i,j),busDetails);
        strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
    
    for j=1:8
        
        dTemp=(lseData(i,j+11));
        strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
    end
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp,'\n');
    
end

strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$15s\t%5$15s\t%6$15s\t%7$15s\t%8$15s\t%9$15s\t%10$15s\t%11$15s\n','Name', 'ID', 'atBus', 'H-16', 'H-17', 'H-18', 'H-19', 'H-20', 'H-21', 'H-22', 'H-23');
fprintf(fileID,strTemp, '\n');
for i=1:iLSEData
    
    strTemp=num2str(slseData{i,:});
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
        j=2;
        iTemp=lseData(i,j);
        strTemp=strcat(strTemp,'\t',sprintf('%1$10d', iTemp));
        j=3;
        iTemp=returnnodename(lseData(i,j),busDetails);
        strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
        
    for j=1:8;
        
        dTemp=(lseData(i,j+19));
        strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
    end
    
    
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp, '\n');
    
end





fprintf(fileID,'#LSEDataFixedDemandEnd\n');
fprintf(fileID,'\n');

end

%%


if(bPriceSensitiveDemand)
    fprintf(fileID,'\n');
    
    fprintf(fileID,'#LSEDataPriceSensitiveDemandStart\n');
    strTemp=sprintf('//%1$8s\t%2$10s\t%3$10s\t%4$10s\t%5$15s\t%6$15s\t%7$15s\n','Name', 'ID', 'atBus', 'hourIndex', 'c', 'd', 'SLMax');
    fprintf(fileID,strTemp,'\n');
    
    for i=1:iLSEData
        k=(i-1)*24;
        
        for h=1:24
            
            strTemp=num2str(slsePriceSensitiveDemand{h+k,:});
            strTemp=sprintf('%1$10s', strTemp,'\n');
            
            for j=1+1:6+1
                
                if(j==3)
                    iTemp=returnnodename(lsePriceSensitiveDemand(k+h,j),busDetails);
                    strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));

                elseif(j<4+1)
                    iTemp=(lsePriceSensitiveDemand(k+h,j));
                    strTemp=strcat(strTemp,'\t',sprintf('%1$10d', iTemp));
                    
                else
                    dTemp=(lsePriceSensitiveDemand(k+h,j));
                    strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', dTemp));
                    
                end
            end
            
            strTemp = strcat(strTemp,'\n');
            fprintf(fileID,strTemp,'\n');
        end
    end
    fprintf(fileID,'#LSEDataPriceSensitiveDemandEnd\n');
    fprintf(fileID,'\n');
end

%%


if(bHybridDemand)
    fprintf(fileID,'\n');
    fprintf(fileID,'//LSE Data Hybrid Demand Flags: 1-> only fixed demand; 2-> only p-s demand; 3-> both\n');
    
    fprintf(fileID,'#LSEDataHybridDemandStart\n');
    strTemp=sprintf('//%1$8s\t%2$5s\t%3$5s\t%4$5s\t%5$5s\t%6$5s\t%7$5s\t%8$5s\t%9$5s\t%10$5s\t%11$5s\n', 'Name', 'ID', 'atBus', 'H-00', 'H-01', 'H-02', 'H-03', 'H-04', 'H-05', 'H-06', 'H-07');
    fprintf(fileID,strTemp,'\n');
    for i=1:iLSEData
        
        strTemp=slseHybridDemand{i,:};
        strTemp=sprintf('%1$10s', strTemp,'\n');
        
        for j=1+1:11
            
                if(j==3)
                    iTemp=returnnodename(lseHybridDemand(i,j),busDetails);
                    strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
                elseif(j>3)
                    iTemp=1;
                    strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
                else
                    iTemp=lseHybridDemand(i,j);
                    strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
                end
        end
        
        strTemp = strcat(strTemp,'\n');
        fprintf(fileID,strTemp,'\n');
        
    end
    
    strTemp=sprintf('//%1$8s\t%2$5s\t%3$5s\t%4$5s\t%5$5s\t%6$5s\t%7$5s\t%8$5s\t%9$5s\t%10$5s\t%11$5s\n', 'Name', 'ID', 'atBus', 'H-08', 'H-09', 'H-10', 'H-11', 'H-12', 'H-13', 'H-14', 'H-15');
    fprintf(fileID,strTemp,'\n');
    for i=1:iLSEData
        strTemp=slseHybridDemand{i,:};
        strTemp=sprintf('%1$10s', strTemp,'\n');
        
        for j=2:3
                if(j==3)
                    iTemp=returnnodename(lseHybridDemand(i,j),busDetails);
                    strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
                else
                    iTemp=lseHybridDemand(i,j);
                    strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
                end
        end
        
        for j=1:8
            iTemp=1;%lseHybridDemand(i,j+11);
            strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
        end
        
        strTemp = strcat(strTemp,'\n');
        fprintf(fileID,strTemp,'\n');
        
    end
    
    strTemp=sprintf('//%1$8s\t%2$5s\t%3$5s\t%4$5s\t%5$5s\t%6$5s\t%7$5s\t%8$5s\t%9$5s\t%10$5s\t%11$5s\n', 'Name', 'ID', 'atBus', 'H-16', 'H-17', 'H-18', 'H-19', 'H-20', 'H-21', 'H-22', 'H-23');
    fprintf(fileID,strTemp,'\n');
    for i=0+1:iLSEData
        strTemp=slseHybridDemand{i,:};
        strTemp=sprintf('%1$10s', strTemp,'\n');
        
        for j=2:3
                if(j==3)
                    iTemp=returnnodename(lseHybridDemand(i,j),busDetails);
                    strTemp=strcat(strTemp,'\t', sprintf('%1$10s',iTemp{1,1}));
                elseif(j>3)
                    iTemp=1;
                    strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
                else
                    iTemp=lseHybridDemand(i,j);
                    strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
                end
        end
        
        for j=1:8
            iTemp=1;%lseHybridDemand(i,j+19);
            strTemp=strcat(strTemp,'\t',sprintf('%1$5d', iTemp));
        end
        
        strTemp = strcat(strTemp,'\n');
        fprintf(fileID,strTemp,'\n');
        
    end
    
    
    fprintf(fileID,'#LSEDataHybridDemandEnd\n');
    fprintf(fileID,'\n');
end

%%

fprintf(fileID,'//Reward Selection Flag: 0-> profits; 1-> net earnings\n');
fprintf(fileID,'#GenLearningDataStart\n');
strTemp=sprintf('//%1$8s\t%2$15s\t%3$15s\t%4$15s\t%5$15s\t%6$15s\t%7$15s\t%8$15s\t%9$15s\t%10$15s\t%11$15s\t%12$15s\t%13$15s\n','Name', 'InitPropensity', 'Cooling', 'Recency', 'Experimentation', 'M1', 'M2', 'M3', 'RI_MAX_Lower', 'RI_MAX_Upper', 'RI_MIN_C', 'SlopeStart', 'RewardSelection');
fprintf(fileID,strTemp,'\n');
for i=1:iGenData
    strTemp=sgenData{i,:};
    strTemp=sprintf('%1$10s', strTemp,'\n');
    
    for j=2:13
        strTemp=strcat(strTemp,'\t',sprintf('%1$15.4f', genLearningData(i,j)));
    end
    strTemp = strcat(strTemp,'\n');
    fprintf(fileID,strTemp,'\n');
    
end
fprintf(fileID,'#GenLearningDataEnd\n');
fprintf(fileID,'\n');

fprintf(fileID,'\n');
fprintf(fileID,'\n');

                                                                    
%%

fclose(fileID);
if(SCUC_TYPE)
    display(['Output Test Case file generated for Sto dart' num2str(dart)]);
else
    display(['Output Test Case file generated for Det dart' num2str(dart)]);
end
    
%  System.out.println('Save case data file:'+caseFile.getName());