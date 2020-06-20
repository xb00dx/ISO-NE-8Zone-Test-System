function a=returnfuelnumber(b,fuelDetails)
    a=0;
    nlength=length(fuelDetails(:,2));
    for i=1:nlength
        
        if(strcmp(fuelDetails{i,2},b))
            a=fuelDetails{i,1};
            break;
        end
    end
end