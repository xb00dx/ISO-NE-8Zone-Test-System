function a=returnnodenumber_8bus(b)
       
        if((strcmp(b,'NOR'))>0)
            a=1;
        elseif((strcmp(b,'SWCT'))>0)
            a=1;
        elseif((strcmp(b,'CT'))>0)
            a=1;
        elseif((strcmp(b,'CMAN'))>0)
            a=2;
        elseif((strcmp(b,'WMA'))>0)
            a=2; 
        elseif((strcmp(b,'WCMASS'))>0)
            a=2;
        elseif((strcmp(b,'VT'))>0)
            a=3;
        elseif((strcmp(b,'SEMA'))>0)
            a=4;
        elseif((strcmp(b,'SEMASS'))>0)
            a=4;
        elseif((strcmp(b,'RI'))>0)
            a=5;
        elseif((strcmp(b,'BOST/NEMA')+strcmp(b,'NEMASSBOST')+strcmp(b,'BOST'))>0)
            a=6;
        elseif((strcmp(b,'NH'))>0)
            a=7;
        elseif((strcmp(b,'SME'))>0)
            a=8;
        elseif((strcmp(b,'ME'))>0)
            a=8;
        elseif((strcmp(b,'BHE'))>0)
            a=8;
        elseif((strcmp(b,'HQP2')+strcmp(b,'MARI')+strcmp(b,'XSND')+strcmp(b,'HQHG')+strcmp(b,'NY'))>0)
            a=14;
        else
            a=0;
        end
end
