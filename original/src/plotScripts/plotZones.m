clc;
clear;
close all;
figure(1);
%  ax = usamap({'CT','ME'});
 LatLim = [40 47.5];
 LonLim = [-73.9 -66.8];
 ax = usamap(LatLim, LonLim);
set(ax, 'Visible', 'off')
latlim = getm(ax, 'MapLatLimit');
lonlim = getm(ax, 'MapLonLimit');
states = shaperead('usastatehi',...
        'UseGeoCoords', true, 'BoundingBox', [lonlim', latlim']);
set(0, 'DefaultFigureColor', 'white');
geoshow(ax, states, 'FaceColor', [0.9 0.9 0.9])



lat = [states.LabelLat];
lon = [states.LabelLon];
tf = ingeoquad(lat, lon, lat, lon);

for i=1:length(tf)
    if(tf(i))
        x=0;
        y=0;
        if(strcmp(states(i).Name,'Connecticut')|strcmp(states(i).Name,'CT'))
            x=0.02;y=0.15; name = 'CT';
        end
        if(strcmp(states(i).Name,'Rhode Island')|strcmp(states(i).Name,'RI'))
%              x=0.5;y=-.5; name = 'RI';
 x=0.5;y=-1; name = 'RI';
        end
        if(strcmp(states(i).Name,'Massachusetts')|strcmp(states(i).Name,'MA'))
            x=-1.75;y=.375; name = 'MA'; states(i).Name={'WC','Mass'};
        end
        if(strcmp(states(i).Name,'New Hampshire')|strcmp(states(i).Name,'NH'))
            x=0;y=-0.7; name = 'NH'; states(i).Name={'New','Hampshire'};
        end
        if(strcmp(states(i).Name,'Vermont')|strcmp(states(i).Name,'VT'))
            x=-0.15;y=0; name = 'VT';
        end
        if(strcmp(states(i).Name,'Maine')|strcmp(states(i).Name,'ME'))
            x=-0;y=0; name = 'ME';
        end
        textm(lat(i)+y, lon(i)+x, states(i).Name,'HorizontalAlignment', 'center','FontSize',9);
        %textm(lat(i)+y, lon(i)+x,{'New','Hampshire'} ,'HorizontalAlignment', 'center','FontSize',9);
%         x=0;y=0;
%         textm(lat(i)+y, lon(i)+x, name,'HorizontalAlignment', 'center','FontSize',9);
    end
end

textm(lat(3)+.375, lon(2)-.5, 'NE Mass & Boston','HorizontalAlignment', 'center','FontSize',9);
textm(lat(3)-.375, lon(2), 'SE Mass','HorizontalAlignment', 'center','FontSize',9);

x1 =   1.0e+05 *[
   -1.2785
   -1.2044
   -1.1748
   -1.1304] ;


y1 =   1.0e+06 *[
    5.1356
    5.1468
    5.1546
    5.2153] ;

plot(x1,y1,'Color',[0 0 0]);
% 
% x2 = 1.0e+05 *[   -1.1933;   -0.5545];
x2 = 1.0e+05 *[   -1.1933;   -0.3045];
y2 = 1.0e+06 *[    5.1500;    5.1500];

plot(x2,y2,'Color',[0 0 0]);

%%

