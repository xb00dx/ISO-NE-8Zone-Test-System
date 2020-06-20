clc;
close
priceFromOffer = zeros(1,13);
capFromOffer = zeros(1,13);
iter = [2 6 11 13 28 41 531]
for count=1:7
    j=iter(count);
    maxBlock = 1;
p=0;
for i=2:13
    
    priceFromOffer(i)=priceFromOffer(i-1)+unitData{j,23+(i-1)*2};
    capFromOffer(i)=capFromOffer(i-1)+unitData{j,24+(i-1)*2};

    if(isnan(priceFromOffer(i))+isnan(capFromOffer(i)))
    else
        maxBlock=maxBlock+1;
    end
                
    if(i==2)
        if((capFromOffer(i)+priceFromOffer(i))==0)
        break;
        end
    end

end

 sBlock=2;
if(maxBlock==1)
    
else
    p = polyfit(capFromOffer(sBlock:maxBlock),priceFromOffer(sBlock:maxBlock),2);
    h=figure();
    v=axis;
    plot(capFromOffer(sBlock:maxBlock),priceFromOffer(sBlock:maxBlock),'r')
    hold all
    plot((capFromOffer(sBlock)):.1:capFromOffer(maxBlock),p(1)*((capFromOffer(sBlock)):.1:capFromOffer(maxBlock)).*((capFromOffer(sBlock)):.1:capFromOffer(maxBlock))+p(2)*((capFromOffer(sBlock)):.1:capFromOffer(maxBlock))+p(3),'b')
    l=legend('Offer Curve Data',[num2str(p(1)) 'P^2 + ' num2str(p(2)) 'P + ' num2str(p(3))]);
    a=get(l,'Position');
    str={['Number of blocks = ' num2str(maxBlock)], ['Fuel Type = ' unitData{j,6}]};
    annotation('textbox',[.6 .15 .1 .1],'String',str)
    set(get(gca,'YLabel'),'string','Cost in $');
    set(get(gca,'XLabel'),'string','Capacity in MW');
    set(get(gca,'Title'), 'string',' Cost Curve');

end

print(h, '-dpng' , ['C:\Local Files\Latex\Arpae-Meeting-20130418\CostCurve' num2str(j)]);

end