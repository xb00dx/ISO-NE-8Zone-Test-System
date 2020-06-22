clear; clc; close all;
%% Create the Matpower File for the ISO-NE 8-zone system;
define_constants;
root_folder = '../';
% nl = ;
% ng = ;

mpc.baseMVA = 100; % to be modified 
%% Bus Settings
mpc.bus_names = {'CT','ME','NEMASSBOST','NH','RI','SEMASS','VT','WCMASS'};
nb = length(mpc.bus_names);
mpc.bus = zeros(nb, VMIN);
mpc.bus(:,BUS_I) = 1:nb;
mpc.bus(:,BUS_TYPE) = [PV; PV; PV; REF; PV; PV; PV; PV]; % NH is the slack bus, (where the largest gen locates)
mpc.bus(:,PD) = [971; 2319; 1346; 1690; 700; 2908; 529; 989];
% mpc.bus(:,QD) = 0;
% mpc.bus(:,GS) = 0;
% mpc.bus(:,BS) = 0;
mpc.bus(:,BUS_AREA) = 1:nb;
mpc.bus(:,VM) = 1;
mpc.bus(:,VA) = 0;
mpc.bus(:,BASE_KV) = 345;
mpc.bus(:,ZONE) = 1:nb;
mpc.bus(:,VMAX) = 1.05;
mpc.bus(:,VMIN) = 0.95;

%% Generator Settings
% read gen data
[~,~,raw] = xlsread([root_folder,'/original/data/genData/generator_data.csv']);
raw(1,:) = []; % remove header
gen_data = readmatrix([root_folder,'/original/data/genData/generator_data.csv']);

ng = size(gen_data,1);
mpc.gen = zeros(ng,APF);
for i = 1:ng
ind = find( strcmp(raw{i,2}, mpc.bus_names));
mpc.gen(i,GEN_BUS) = mpc.bus(ind,BUS_I);
end
mpc.gen(:,PG) = 0;
mpc.gen(:,QG) = 0;
mpc.gen(:,QMAX) = 0;
mpc.gen(:,QMIN) = 0;
mpc.gen(:,VG) = 1;
mpc.gen(:,MBASE) = mpc.baseMVA;
mpc.gen(:,GEN_STATUS) = 1;
mpc.gen(:,PMAX) = gen_data(:,3);
% mpc.gen(:,PMIN) = 0;
% mpc.gen(:,PC1) = ;
% mpc.gen(:,PC2) = ;
% mpc.gen(:,QC1MIN) = ;
% mpc.gen(:,QC1MAX) = ;
% mpc.gen(:,QC2MIN) = ;
% mpc.gen(:,QC2MAX) = ;
ramp_rate = gen_data(:,7);
mpc.gen(:,RAMP_AGC) = ramp_rate/60;
mpc.gen(:,RAMP_10) = ramp_rate/6;
mpc.gen(:,RAMP_30) = ramp_rate/2;
% mpc.gen(:,RAMP_Q) = ;
% mpc.gen(:,APF) = ;

% gencost
mpc.gencost = zeros(ng,7);
mpc.gencost(:,MODEL) = POLYNOMIAL;
mpc.gencost(:,STARTUP) = gen_data(:,8);
mpc.gencost(:,SHUTDOWN) = mpc.gencost(:,STARTUP)/10;
mpc.gencost(:,NCOST) = 3; % quadratic cost
mpc.gencost(:,COST) = gen_data(:,11); % c2
mpc.gencost(:,COST+1) = gen_data(:,10); % c1
mpc.gencost(:,COST+2) = gen_data(:,9); % c0, no load cost

mpc.genfuel = raw(:,4);

%% Line Settings
[~,~,raw] = xlsread([root_folder,'/original/data/TransmissionLineData/gridDetails.csv']);
raw(1,:) = []; % remove header
line_data = readmatrix([root_folder,'/original/data/TransmissionLineData/gridDetails.csv']);
nl = size(line_data,1);
mpc.branch = zeros(nl,ANGMAX);
for i = 1:nl
    f_ind = find(strcmp(raw{i,2}, mpc.bus_names));
    t_ind = find(strcmp(raw{i,3}, mpc.bus_names));
    mpc.branch(i,F_BUS) = mpc.bus(f_ind,BUS_I);
    mpc.branch(i,T_BUS) = mpc.bus(t_ind,BUS_I);
end
mpc.branch(:,BR_R) = 0; % original data is not zero
mpc.branch(:,BR_X) = line_data(:,7);
mpc.branch(:,BR_B) = 0;
mpc.branch(:,RATE_A) = [600;
    250;
    250;
    600;
    750;
    750;
    750;
    2500;
    300;
    1250;
    800;
    2500];
mpc.branch(:,RATE_B) = mpc.branch(:,RATE_A)*1.1;
mpc.branch(:,RATE_C) = mpc.branch(:,RATE_A)*1.2;
mpc.branch(:,TAP) = 0;
mpc.branch(:,BR_STATUS) = 1;


%% time varying load profile
CT_load = readmatrix([root_folder,'/original/data/loadData/CSV/CT.csv']);
ME_load = readmatrix([root_folder,'/original/data/loadData/CSV/ME.csv']);
NEMASSBOST_load = readmatrix([root_folder,'/original/data/loadData/CSV/NEMASSBOST.csv']);
NH_load = readmatrix([root_folder,'/original/data/loadData/CSV/NH.csv']);
RI_load = readmatrix([root_folder,'/original/data/loadData/CSV/RI.csv']);
SEMASS_load = readmatrix([root_folder,'/original/data/loadData/CSV/SEMASS.csv']);
VT_load = readmatrix([root_folder,'/original/data/loadData/CSV/VT.csv']);
WCMASS_load = readmatrix([root_folder,'/original/data/loadData/CSV/WCMASS.csv']);

save_folder = ['../mfiles/'];
nrow = size(CT_load,1);
% mptopt = mpoption('out.all',0);
for i =1:nrow
    disp(i);
    mpc_i = mpc;
    mpc_i.bus(:,PD) = [CT_load(i,3); ME_load(i,3); NEMASSBOST_load(i,3);...
        NH_load(i,3); RI_load(i,3); SEMASS_load(i,3); VT_load(i,3); WCMASS_load(i,3)];
    result_i = rundcopf(mpc_i,mpoption('out.all',0));
    assert(result_i.success);
    
    fname = ['case8_isone_',num2str(CT_load(i,1)),'_',num2str(CT_load(i,2))];
    comment = {'8-zone synthetic grid based on ISO-NE data',...
        ['  This case represents hour ',num2str(CT_load(i,1)),'/96 (4 days)',' and scenario ',num2str(CT_load(i,2)),'/90.'],...
        '  Original system was created by Dheepak Krishnamurthy, Wanning Li',...
        '  and Leigh Tesfatsion from Iowa State University.',...
        '  Please cite [1] when publishing results based on this system.',...
        '',...
        '  [1] Krishnamurthy, Dheepak, Wanning Li, and Leigh Tesfatsion.',...
        '  "An 8-zone test system based on ISO New England data: Development',...
        '  and application." IEEE Transactions on Power Systems (2015).',...
        '',...
        '  Line capacities (RATE_A, RATE_B, RATE_C) are added based on line flow computation.',...
        '',...
        '  This Matpower case was created by X. Geng (06/21/2020).',...
        '  Complete details (original data, scripts, revised cases) can be found at:',...
        '  https://github.com/xb00dx/ISO-NE-8Zone-Test-System'};
  
    savecase([save_folder,fname], comment, result_i);
end