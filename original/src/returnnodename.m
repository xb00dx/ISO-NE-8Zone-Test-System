function a=returnnodename(b,busDetails)
    a=0;
    nBus=length(busDetails(:,2));
    for i=1:nBus
        
        if(busDetails{i,1}==b)
            a=busDetails(i,2);
            continue;
        end
    end
end
