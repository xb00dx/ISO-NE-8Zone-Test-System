clear; clc; close all;
define_constants;

case_folder = '../mfiles/';

nt = 96; ns = 90;
nl = 12; ng = 76; nb = 8;
% gen_sol = zeros(nt,ns);
% flow_sol = zeros(nt,ns);

for i = 1:ns
    disp(i);
    sol(i).load = zeros(nb,nt);
    sol(i).gen = zeros(ng,nt);
    sol(i).flow = zeros(nl,nt);
for t = 1:nt
    mpc_ti = loadcase([case_folder,'case8_isone_',num2str(t),'_',num2str(i)]);
    result_ti = rundcopf(mpc_ti,mpoption('out.all',0));
    assert(result_ti.success);
    sol(i).gen(:,t) = result_ti.gen(:,PG);
    sol(i).flow(:,t) = result_ti.branch(:,PF);
end
end

result_path = ['./results/'];
f_sol = figure;
for i = 1:ns
subplot(2,1,1)
plot(1:nt, sol(i).gen)
xlabel('time (96 snapshots)'), ylabel('generation (MW)')
title(['scenario ',num2str(i)])
subplot(2,1,2)
plot(1:nt, sol(i).flow)
xlabel('time (96 snapshots)'), ylabel('line flow (MW)')
title(['scenario ',num2str(i)])
print(f_sol,'-dpng',['case8_isone_dispatch_results_scenario_',num2str(i),'.png'])
end

save([result_path,'case8_isone_results.mat'],'sol');