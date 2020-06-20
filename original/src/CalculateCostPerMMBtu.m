




FixedCost = 50; 

costMMbtuKey = (unitData(2:539,6));

% Ramp Rates in this M-File are in percent of capacity

% rrcoal = min(100,(1+5/100)^60);
% rroil = min(100,(1+20/100)^60);
% rrgas = min(100,(1+5/100)^60);
% rrnuc = min(100,(1+0.1/100)^60);
% rrwind = min(100,(1+.1/100)^60);
% rrpv = min(100,(1+.1/100)^60);
% rrhydro = min(100,(1+30/100)^60);
%http://pscal.ece.gatech.edu/testsys/generators.html

costMMBtucoal75 = 2.44;
costMMBtucoal155 = 2.44;
costMMBtucoal350 = 2.44;
costMMBtuoil12 = 17.28;
costMMBtuoil20 = 17.28;
costMMBtuoil100 = 17.28;
costMMBtuoil200 = 17.28;
costMMBtugas = 4.74;
costMMBtunuc = .85;
costMMBtuwind = 00.001;
costMMBtupv = .001;
costMMBtuhydro = .001;


for i=1:length(costMMbtuKey)

    if(strcmp(costMMbtuKey(i,1),'BIT')+strcmp(costMMbtuKey(i,1),'BLQ') ...
        +strcmp(costMMbtuKey(i,1),'SUB')) % Bituminous Coal Black Liquor
        if(unitData{i,3}<75)
            costPerMMBtu(i,1) = costMMBtucoal75;
        elseif(unitData{i,3}<155)
            costPerMMBtu(i,1) = costMMBtucoal155;
        elseif(unitData{i,3}<350)
            costPerMMBtu(i,1) = costMMBtucoal350;
        else
            costPerMMBtu(i,1) = nlcostcoat350+costMMBtucoal75;
        end
    elseif(strcmp(costMMbtuKey(i,1),'DFO')+...
        strcmp(costMMbtuKey(i,1),'JF')+strcmp(costMMbtuKey(i,1),'RFO')...
        +strcmp(costMMbtuKey(i,1),'KER')) % Distillate Fuel Oil
         if(unitData{i,3}<12)
            costPerMMBtu(i,1) = costMMBtuoil12;
        elseif(unitData{i,3}<20)
            costPerMMBtu(i,1) = costMMBtuoil20;
        elseif(unitData{i,3}<100)
            costPerMMBtu(i,1) = costMMBtuoil100;
        elseif(unitData{i,3}<200)
            costPerMMBtu(i,1) = costMMBtuoil200;
        else
            costPerMMBtu(i,1) = costMMBtuoil200+costMMBtuoil20;
        end
    elseif(strcmp(costMMbtuKey(i,1),'LFG')+strcmp(costMMbtuKey(i,1),'MSW') ...
        +strcmp(costMMbtuKey(i,1),'NGA1')+strcmp(costMMbtuKey(i,1),'NGA2') ...
        +strcmp(costMMbtuKey(i,1),'NGA3')+strcmp(costMMbtuKey(i,1),'NGA4')+ ...
        strcmp(costMMbtuKey(i,1),'NGIR')+strcmp(costMMbtuKey(i,1),'NGLN')+ ...
        strcmp(costMMbtuKey(i,1),'NGMN')+strcmp(costMMbtuKey(i,1),'NGPN') ...
        +strcmp(costMMbtuKey(i,1),'NGT1')+strcmp(costMMbtuKey(i,1),'NGT3')+ ...
        strcmp(costMMbtuKey(i,1),'NGT2')+strcmp(costMMbtuKey(i,1),'NGT4')+ ...
        strcmp(costMMbtuKey(i,1),'NGT5')+strcmp(costMMbtuKey(i,1),'NGT6')+ ...
        strcmp(costMMbtuKey(i,1),'NGT7')+strcmp(costMMbtuKey(i,1),'OBG') + ...
        strcmp(costMMbtuKey(i,1),'NGTN')+strcmp(costMMbtuKey(i,1),'TDF')+ ...
        strcmp(costMMbtuKey(i,1),'WDS'))
    costPerMMBtu(i,1) = (costMMBtugas);    
    elseif(strcmp(costMMbtuKey(i,1),'NUC'))  % Nuclear Uranium, Plutonium, Thorium
    costPerMMBtu(i,1) = (costMMBtunuc);    
    elseif(strcmp(costMMbtuKey(i,1),'SUN')) % Solar
    costPerMMBtu(i,1) = (costMMBtupv);    
   
    elseif(strcmp(costMMbtuKey(i,1),'WAT')) % Water
    costPerMMBtu(i,1) = (costMMBtuhydro);    

    elseif(strcmp(costMMbtuKey(i,1),'WND')) % Wind
    costPerMMBtu(i,1) = (costMMBtuwind);    
    else
    costPerMMBtu(i,1) = (rand(1));
    end

end

