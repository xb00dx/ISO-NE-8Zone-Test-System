unitData_int(genName);
typesOfFuel = unique(unitData_string(genName(1:50)+1,6));
plotCapacity = zeros(length(typesOfFuel),1);
for fuel = 1:length(typesOfFuel)
    
    plotCapacity(fuel) = sum(unitData_int(genName(find(strcmp(unitData_string(genName+1,6),typesOfFuel(fuel))))));
    
end
%genName

plotCapacity(4) = sum(plotCapacity(4:11));
plotCapacity(5:11) = [];
typesOfFuel{4} = 'NG';
typesOfFuel(5:11) = [];

save('capacityOfFuelType','plotCapacity','typesOfFuel')

pie(plotCapacity)
legend(typesOfFuel)
title('Distribution of capacity based on fuel type')