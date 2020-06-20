

FixedCost = 50; 

costNoLoadKey = (unitData(2:539,6));

% Ramp Rates in this M-File are in percent of capacity

% rrcoal = min(100,(1+5/100)^60);
% rroil = min(100,(1+20/100)^60);
% rrgas = min(100,(1+5/100)^60);
% rrnuc = min(100,(1+0.1/100)^60);
% rrwind = min(100,(1+.1/100)^60);
% rrpv = min(100,(1+.1/100)^60);
% rrhydro = min(100,(1+30/100)^60);
%http://pscal.ece.gatech.edu/testsys/generators.html

nlcostcoal75 = 212.3076;
nlcostcoal155 = 382.2391;
nlcostcoal350 = 665.1094;
nlcostoil12 = 86.3852;
nlcostoil20 = 400.6849;
nlcostoil100 = 781.521;
nlcostoil200 = 832.7575;
nlcostgas = 400;
nlcostnuc = 385.3749;
nlcostwind = 00.001;
nlcostpv = .001;
nlcosthydro = .001;

% nlcostcoal75 = 0;%212.3076;
% nlcostcoal155 = 0;%382.2391;
% nlcostcoal350 = 0;%665.1094;
% nlcostoil12 = 0;%86.3852;
% nlcostoil20 = 0;%400.6849;
% nlcostoil100 = 0;%781.521;
% nlcostoil200 = 0;%832.7575;
% nlcostgas = 0;%400;
% nlcostnuc = 0;%385.3749;
% nlcostwind = 0;%00.001;
% nlcostpv = 0;%.001;
% nlcosthydro = 0;%.001;

for i=1:length(costNoLoadKey)

    if(strcmp(costNoLoadKey(i,1),'BIT')+strcmp(costNoLoadKey(i,1),'BLQ') ...
        +strcmp(costNoLoadKey(i,1),'SUB')) % Bituminous Coal Black Liquor
        if(unitData{i,3}<75)
            costNoLoad(i,1) = nlcostcoal75;
        elseif(unitData{i,3}<155)
            costNoLoad(i,1) = nlcostcoal155;
        elseif(unitData{i,3}<350)
            costNoLoad(i,1) = nlcostcoal350;
        else
            costNoLoad(i,1) = nlcostcoat350+nlcostcoal75;
        end
    elseif(strcmp(costNoLoadKey(i,1),'DFO')+...
        strcmp(costNoLoadKey(i,1),'JF')+strcmp(costNoLoadKey(i,1),'RFO')...
        +strcmp(costNoLoadKey(i,1),'KER')) % Distillate Fuel Oil
         if(unitData{i,3}<12)
            costNoLoad(i,1) = nlcostoil12;
        elseif(unitData{i,3}<20)
            costNoLoad(i,1) = nlcostoil20;
        elseif(unitData{i,3}<100)
            costNoLoad(i,1) = nlcostoil100;
        elseif(unitData{i,3}<200)
            costNoLoad(i,1) = nlcostoil200;
        else
            costNoLoad(i,1) = nlcostoil200+nlcostoil20;
        end
    elseif(strcmp(costNoLoadKey(i,1),'LFG')+strcmp(costNoLoadKey(i,1),'MSW') ...
        +strcmp(costNoLoadKey(i,1),'NGA1')+strcmp(costNoLoadKey(i,1),'NGA2') ...
        +strcmp(costNoLoadKey(i,1),'NGA3')+strcmp(costNoLoadKey(i,1),'NGA4')+ ...
        strcmp(costNoLoadKey(i,1),'NGIR')+strcmp(costNoLoadKey(i,1),'NGLN')+ ...
        strcmp(costNoLoadKey(i,1),'NGMN')+strcmp(costNoLoadKey(i,1),'NGPN') ...
        +strcmp(costNoLoadKey(i,1),'NGT1')+strcmp(costNoLoadKey(i,1),'NGT3')+ ...
        strcmp(costNoLoadKey(i,1),'NGT2')+strcmp(costNoLoadKey(i,1),'NGT4')+ ...
        strcmp(costNoLoadKey(i,1),'NGT5')+strcmp(costNoLoadKey(i,1),'NGT6')+ ...
        strcmp(costNoLoadKey(i,1),'NGT7')+strcmp(costNoLoadKey(i,1),'OBG') + ...
        strcmp(costNoLoadKey(i,1),'NGTN')+strcmp(costNoLoadKey(i,1),'TDF')+ ...
        strcmp(costNoLoadKey(i,1),'WDS'))
    costNoLoad(i,1) = (nlcostgas);    
    elseif(strcmp(costNoLoadKey(i,1),'NUC'))  % Nuclear Uranium, Plutonium, Thorium
    costNoLoad(i,1) = (nlcostnuc);    
    elseif(strcmp(costNoLoadKey(i,1),'SUN')) % Solar
    costNoLoad(i,1) = (nlcostpv);    
   
    elseif(strcmp(costNoLoadKey(i,1),'WAT')) % Water
    costNoLoad(i,1) = (nlcosthydro);    

    elseif(strcmp(costNoLoadKey(i,1),'WND')) % Wind
    costNoLoad(i,1) = (nlcostwind);    
    else
    costNoLoad(i,1) = (rand(1));
    end

end

