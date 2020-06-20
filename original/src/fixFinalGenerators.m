
unitData;
k=0;

[fuelnames,idx]=sort(unitData(2:539,6));

missingUnitData = unitData;
finalUnitData = unitData;

for i=1:538
   if(unitData{540-i,9}==-99)
       unitData{540-i,9} = 2;
       if(strcmp(unitData(540-i,6),'NUC'))
            unitData{540-i,10} = 10000;
            unitData{540-i,11} = 10000;
            unitData{540-i,12} = 10000;
       end
%       missingUnitData(540-i,:)=[];
       finalUnitData(540-i,:)=[];
   elseif(isnan(unitData{540-i,9}))
       finalUnitData(540-i,:)=[]; 
   else
%           missingUnitData(540-i,:)=[];
   end
end

 [fuelnames,idx]=sort(finalUnitData(2:171,6));
 
 k=0;
 temp = 'random';
 fuelData = cell(1,2);
for i=1:170
    if(strcmp(temp,fuelnames{i}))
        fuelData{k,2}= fuelData{k,2}+1;
    else
        k=k+1;
        fuelData{k,1}= fuelnames{i};
        fuelData{k,2}= 1;
        temp = fuelnames{i}; 
    end
end

start=1;

for fueltype=1:length(fuelData(:,1))
    fuelData{fueltype,3} = mean([finalUnitData{1+idx(start:start-1+fuelData{fueltype,2}),9}]);
    fuelData{fueltype,4} = mean([finalUnitData{1+idx(start:start-1+fuelData{fueltype,2}),10}]);
    fuelData{fueltype,5} = mean([finalUnitData{1+idx(start:start-1+fuelData{fueltype,2}),11}]);
    fuelData{fueltype,6} = mean([finalUnitData{1+idx(start:start-1+fuelData{fueltype,2}),12}]);
    fuelData{fueltype,7} = mean([finalUnitData{1+idx(start:start-1+fuelData{fueltype,2}),13}]);
    fuelData{fueltype,8} = mean([finalUnitData{1+idx(start:start-1+fuelData{fueltype,2}),14}]);
    start=start + fuelData{fueltype,2};
end



for i=2:539
    if(unitData{i,9}==-99)
        unitData{i,9}= 4;
    end
    if(isnan(unitData{i,9}))
        
        try
        unitData{i,9} = fuelData{strcmp(fuelData(:,1),unitData(i,6)),3};
        unitData{i,10} = fuelData{strcmp(fuelData(:,1),unitData(i,6)),4};
        unitData{i,11} = fuelData{strcmp(fuelData(:,1),unitData(i,6)),5};
        unitData{i,12} = fuelData{strcmp(fuelData(:,1),unitData(i,6)),6};
        unitData{i,13} = round(fuelData{strcmp(fuelData(:,1),unitData(i,6)),7});
        unitData{i,14} = round(fuelData{strcmp(fuelData(:,1),unitData(i,6)),8});
        catch
            unitData{i,9} = 4;
            unitData{i,10} = 50;
            unitData{i,11} = 50;
            unitData{i,12} = 50;
            unitData{i,13} = 1;
            unitData{i,14} = 1;
        end
    end
    
end

