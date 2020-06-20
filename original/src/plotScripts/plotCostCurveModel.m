
CostCurveModeling

i = 387; % WND
 i = 10; % KER
 i = 43; % BIT
 i = 64; % NUC
 i = 77; % WAT

fueltypename = unitData{i,6};

Capa = unitData{i,3};
Capb = unitData{i,3}/4*3;
Capc = unitData{i,3}/2;
Capd = unitData{i,3}/4;
Cape = 0;
idx = find(strcmp(FuelHeatRateKey(:,1),fueltypename));
FuelHeatRate = FuelHeatRateKey{idx,2};
Costa = Capa*unitData{i,9} + FixedCost;
Costb = Capb*unitData{i,9}*FuelHeatRate + FixedCost;
Costc = Capc*unitData{i,9}*FuelHeatRate*FuelHeatRate + FixedCost;
Costd = Capd*unitData{i,9}*FuelHeatRate*FuelHeatRate*FuelHeatRate + FixedCost;
Coste = Cape*unitData{i,9}*0 + FixedCost;


Cost = [Costa Costb Costc Costd Coste]';
Cap =  [Capa Capb Capc Capd Cape]';
X = [ones(size(Cap)) Cap Cap.^2];
a = X\Cost;
T = (0:1:100)';
Y = [ones(size(T)) T T.^2]*a;
T;
Y;
h = figure();
plot(Cap,Cost);
axis([0 Capa*1.1 0 Costa*1.25])
set(get(gca,'YLabel'),'string','Cost in $');
set(get(gca,'XLabel'),'string','Capacity in MW');
set(get(gca,'Title'), 'string',' Cost Curve');
text(.8*Capa,Costa*1.1,['Fuel type = ' unitData{i,6}])
text(.1*Capa,Costa*1.1,[num2str(fuelDetails{i-1,1}) 'P^2 + ' num2str(fuelDetails{i-1,2}) 'P + ' num2str(FixedCost)])
print(h, '-dpdf' , ['PDFCostCurveModel - ' unitData{i,6}]);