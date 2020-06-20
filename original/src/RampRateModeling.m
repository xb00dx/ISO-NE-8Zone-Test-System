

FixedCost = 50; 

RampRateKey = unique(unitData(2:539,6));

% Ramp Rates in this M-File are in percent of capacity

% rrcoal = min(100,(1+5/100)^60);
% rroil = min(100,(1+20/100)^60);
% rrgas = min(100,(1+5/100)^60);
% rrnuc = min(100,(1+0.1/100)^60);
% rrwind = min(100,(1+.1/100)^60);
% rrpv = min(100,(1+.1/100)^60);
% rrhydro = min(100,(1+30/100)^60);

rrcoal = min(100,(1+5/100)^60);
rroil = min(100,(1+15/100)^60);
rrgas = min(100,(1+10/100)^60);
rrnuc = min(100,(1+2/100)^60);
rrwind = min(100,(1+1/100)^60);
rrpv = min(100,(1+5/100)^60);
rrhydro = min(100,(1+30/100)^60);


for i=1:length(RampRateKey)

    if(strcmp(RampRateKey(i,1),'BIT'))     % Bituminous Coal
    RampRateKey(i,2) = num2cell(rrcoal);    
    elseif(strcmp(RampRateKey(i,1),'BLQ')) % Black Liquor
    RampRateKey(i,2) = num2cell(rrcoal);    
    elseif(strcmp(RampRateKey(i,1),'DFO')) % Distillate Fuel Oil
    RampRateKey(i,2) = num2cell(rrcoal);    
    elseif(strcmp(RampRateKey(i,1),'JF'))  % Jet Fuel
    RampRateKey(i,2) = num2cell(rrcoal);    
    elseif(strcmp(RampRateKey(i,1),'KER')) % Kerosene
    RampRateKey(i,2) = num2cell(rroil);    
    elseif(strcmp(RampRateKey(i,1),'LFG')) % Landfill Gas
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'MSW')) % Municipal Solid Waste
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGA1')) % Natural Gas
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGA2')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGA3')) % NG
    RampRateKey(i,2) = num2cell(rrgas);     
    elseif(strcmp(RampRateKey(i,1),'NGA4')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGIR')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGLN')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGMN')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGPN')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT1')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT2')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT3')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT4')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT5')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT6')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGT7')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NGTN')) % NG
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'NUC'))  % Nuclear Uranium, Plutonium, Thorium
    RampRateKey(i,2) = num2cell(rrnuc);    
    elseif(strcmp(RampRateKey(i,1),'OBG')) % Other Biomass Gass
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'RFO')) % Residual Fuel Oil
    RampRateKey(i,2) = num2cell(rroil);    
    elseif(strcmp(RampRateKey(i,1),'SUB')) % Subituminous Coal
    RampRateKey(i,2) = num2cell(rrcoal);    
    elseif(strcmp(RampRateKey(i,1),'SUN')) % Solar
    RampRateKey(i,2) = num2cell(rrpv);    
    elseif(strcmp(RampRateKey(i,1),'TDF')) % Tire derived fuels
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'WAT')) % Water
    RampRateKey(i,2) = num2cell(rrhydro);    
    elseif(strcmp(RampRateKey(i,1),'WDS')) % Wood waste solids
    RampRateKey(i,2) = num2cell(rrgas);    
    elseif(strcmp(RampRateKey(i,1),'WND')) % Wind
    RampRateKey(i,2) = num2cell(rrwind);    
    else
    RampRateKey(i,2) = num2cell(rand(1));
    end

end

sRampRateKey = unique(unitData(2:539,6));

srrcoal = 100;
srroil = 100;
srrgas = 100;
srrnuc = 100;
srrwind = 100;
srrpv = 100;
srrhydro = 100;

for i=1:length(sRampRateKey)

    if(strcmp(sRampRateKey(i,1),'BIT'))     % Bituminous Coal
    sRampRateKey(i,2) = num2cell(srrcoal);    
    elseif(strcmp(sRampRateKey(i,1),'BLQ')) % Black Liquor
    sRampRateKey(i,2) = num2cell(srrcoal);    
    elseif(strcmp(sRampRateKey(i,1),'DFO')) % Distillate Fuel Oil
    sRampRateKey(i,2) = num2cell(srrcoal);    
    elseif(strcmp(sRampRateKey(i,1),'JF'))  % Jet Fuel
    sRampRateKey(i,2) = num2cell(srrcoal);    
    elseif(strcmp(sRampRateKey(i,1),'KER')) % Kerosene
    sRampRateKey(i,2) = num2cell(srroil);    
    elseif(strcmp(sRampRateKey(i,1),'LFG')) % Landfill Gas
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'MSW')) % Municipal Solid Waste
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGA1')) % Natural Gas
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGA2')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGA3')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);     
    elseif(strcmp(sRampRateKey(i,1),'NGA4')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGIR')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGLN')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGMN')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGPN')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT1')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT2')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT3')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT4')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT5')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT6')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGT7')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NGTN')) % NG
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'NUC'))  % Nuclear Uranium, Plutonium, Thorium
    sRampRateKey(i,2) = num2cell(srrnuc);    
    elseif(strcmp(sRampRateKey(i,1),'OBG')) % Other Biomass Gass
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'RFO')) % Residual Fuel Oil
    sRampRateKey(i,2) = num2cell(srroil);    
    elseif(strcmp(sRampRateKey(i,1),'SUB')) % Subituminous Coal
    sRampRateKey(i,2) = num2cell(srrcoal);    
    elseif(strcmp(sRampRateKey(i,1),'SUN')) % Solar
    sRampRateKey(i,2) = num2cell(srrpv);    
    elseif(strcmp(sRampRateKey(i,1),'TDF')) % Tire derived fuels
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'WAT')) % Water
    sRampRateKey(i,2) = num2cell(srrhydro);    
    elseif(strcmp(sRampRateKey(i,1),'WDS')) % Wood waste solids
    sRampRateKey(i,2) = num2cell(srrgas);    
    elseif(strcmp(sRampRateKey(i,1),'WND')) % Wind
    sRampRateKey(i,2) = num2cell(srrwind);    
    else
    sRampRateKey(i,2) = num2cell(55);
    end

end








