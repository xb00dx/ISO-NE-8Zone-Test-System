
FixedCost = 0; 

FuelHeatRateKey = unique(unitData(2:539,6));

for i=1:length(FuelHeatRateKey)

    if(strcmp(FuelHeatRateKey(i,1),'BIT'))     % Bituminous Coal
    FuelHeatRateKey(i,2) = num2cell(.8);    
    elseif(strcmp(FuelHeatRateKey(i,1),'BLQ')) % Black Liquor
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'DFO')) % Distillate Fuel Oil
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'JF'))  % Jet Fuel
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'KER')) % Kerosene
    FuelHeatRateKey(i,2) = num2cell(.6);    
    elseif(strcmp(FuelHeatRateKey(i,1),'LFG')) % Landfill Gas
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'MSW')) % Municipal Solid Waste
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGA1')) % Natural Gas
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGA2')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGA3')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);     
    elseif(strcmp(FuelHeatRateKey(i,1),'NGA4')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGIR')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGLN')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGMN')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGPN')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT1')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT2')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT3')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT4')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT5')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT6')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGT7')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NGTN')) % NG
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'NUC'))  % Nuclear Uranium, Plutonium, Thorium
    FuelHeatRateKey(i,2) = num2cell(1);    
    elseif(strcmp(FuelHeatRateKey(i,1),'OBG')) % Other Biomass Gass
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'RFO')) % Residual Fuel Oil
    FuelHeatRateKey(i,2) = num2cell(.7);    
    elseif(strcmp(FuelHeatRateKey(i,1),'SUB')) % Subituminous Coal
    FuelHeatRateKey(i,2) = num2cell(.8);    
    elseif(strcmp(FuelHeatRateKey(i,1),'SUN')) % Solar
    FuelHeatRateKey(i,2) = num2cell(1);    
    elseif(strcmp(FuelHeatRateKey(i,1),'TDF')) % Tire derived fuels
    FuelHeatRateKey(i,2) = num2cell(.6);    
    elseif(strcmp(FuelHeatRateKey(i,1),'WAT')) % Water
    FuelHeatRateKey(i,2) = num2cell(0);    
    elseif(strcmp(FuelHeatRateKey(i,1),'WDS')) % Wood waste solids
    FuelHeatRateKey(i,2) = num2cell(.5);    
    elseif(strcmp(FuelHeatRateKey(i,1),'WND')) % Wind
    FuelHeatRateKey(i,2) = num2cell(1);    
    else
    FuelHeatRateKey(i,2) = num2cell(rand(1));
    end

end

for i=2:539
    
Capa = unitData{i,3};
Capb = unitData{i,3}/4*3;
Capc = unitData{i,3}/2;
Capd = unitData{i,3}/4;
Cape = 0;

fueltypename = unitData{i,6};

idx = find(strcmp(FuelHeatRateKey(:,1),unitData{i,6}));
FuelHeatRate = FuelHeatRateKey{idx,2};

Costa = Capa*unitData{i,9} + FixedCost;
Costb = Capb*unitData{i,9}*FuelHeatRate + FixedCost;
Costc = Capc*unitData{i,9}*FuelHeatRate*FuelHeatRate + FixedCost;
Costd = Capd*unitData{i,9}*FuelHeatRate*FuelHeatRate*FuelHeatRate + FixedCost;
Coste = Cape*unitData{i,9}*0 + FixedCost;

Cap = [Capa Capb Capc Capd Cape];
Cost = [Costa Costb Costc Costd Coste];

p = polyfit(Cap,Cost,2);


    if(FuelHeatRate==0)
    
        fuelDetails(i-1,1)=num2cell(0);
        fuelDetails(i-1,2)=num2cell(0);
    
    else
        
        if(p(1)<1e-10)
            p(1)=0;
        end
        fuelDetails(i-1,1)=num2cell(p(1));
        if(p(2)<0)
%            p(2)=0;
        end
        fuelDetails(i-1,2)=num2cell(p(2));
    end
end







