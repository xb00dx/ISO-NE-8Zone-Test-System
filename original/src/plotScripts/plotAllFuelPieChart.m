%unitData_int(genName);
typesOfFuel = unique(unitData_string(:,6));
plotCapacity = zeros(length(typesOfFuel),1);
for fuel = 1:length(typesOfFuel)
    
    plotCapacity(fuel) = sum(unitData_int(find(strcmp(unitData_string(:,6),typesOfFuel(fuel)))));
    
end
%genName
a=[];
for fuel=1:length(typesOfFuel)
    a = [a; typesOfFuel(fuel,:) length(find(strcmp(unitData_string(2:539,6),typesOfFuel(fuel))))];
end

genName = 1:538;
unitData_int(genName);
typesOfFuel = unique(unitData_string(genName+1,6));
plotCapacity = zeros(length(typesOfFuel),1);
for fuel = 1:length(typesOfFuel)
    
    plotCapacity(fuel) = sum(unitData_int(genName(find(strcmp(unitData_string(genName+1,6),typesOfFuel(fuel))))));
    
end
%genName

% plotCapacity(9) = sum(plotCapacity(9:24));
% plotCapacity(10:24) = [];
% typesOfFuel{9} = 'NG';
% typesOfFuel(10:24) = [];
% % 
% save('capacityOfFuelType','plotCapacity','typesOfFuel')

pie(plotCapacity)
legend(typesOfFuel)
title('Distribution of capacity based on fuel type')