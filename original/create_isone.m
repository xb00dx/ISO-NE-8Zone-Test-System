clear; clc; close all;
%% Create the Matpower File for the ISO-NE 8-zone system;
define_constants;
nb = 8;
% nl = ;
% ng = ;

%% Bus Settings
mpc.busnames = {'CT','ME','NEMASSBOST','NH','RI','SEMASS','VT','WCMASS'};
mpc.bus = zeros(nb, 13);
mpc.bus(:,BUS_I) = 1:nb;
mpc.bus(:,BUS_TYPE) = ;
mpc.bus(:,PD) = [971; 2319; 1346; 1690; 700; 2908; 529; 989];
mpc.bus(:,QD) = 0;
mpc.bus(:,GS) = ;
mpc.bus(:,BS) = ;
mpc.bus(:,BUS_AREA) = 0;
mpc.bus(:,VM) = ;
mpc.bus(:,VA) = ;
mpc.bus(:,BASE_KV) = ;
mpc.bus(:,ZONE) = 1:nb;
mpc.bus(:,VMAX) = ;
mpc.bus(:,VMIN) = ;

%% Generator Settings


%% Line Settings