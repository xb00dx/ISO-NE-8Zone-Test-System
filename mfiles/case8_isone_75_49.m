function mpc = case8_isone_75_49
%CASE8_ISONE_75_49  8-zone synthetic grid based on ISO-NE data
%  This case represents hour 75/96 (4 days) and scenario 49/90.
%  Original system was created by Dheepak Krishnamurthy, Wanning Li
%  and Leigh Tesfatsion from Iowa State University.
%  Please cite [1] when publishing results based on this system.
%
%  [1] Krishnamurthy, Dheepak, Wanning Li, and Leigh Tesfatsion.
%  "An 8-zone test system based on ISO New England data: Development
%  and application." IEEE Transactions on Power Systems (2015).
%
%  Line capacities (RATE_A, RATE_B, RATE_C) are added based on line flow computation.
%
%  This Matpower case was created by X. Geng (06/21/2020).
%  Complete details (original data, scripts, revised cases) can be found at:
%  https://github.com/xb00dx/ISO-NE-8Zone-Test-System

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin	lam_P	lam_Q	mu_Vmax	mu_Vmin
mpc.bus = [
	1	2	972	0	0	0	1	1	10.2503383	345	1	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	2	2	1966	0	0	0	2	1	-4.44615249	345	2	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	3	2	1149	0	0	0	3	1	-5.77830973	345	3	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	4	3	1468	0	0	0	4	1	0	345	4	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	5	2	628	0	0	0	5	1	0.222827918	345	5	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	6	2	2485	0	0	0	6	1	-7.9352205	345	6	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	7	2	503	0	0	0	7	1	2.72085836	345	7	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
	8	2	879	0	0	0	8	1	2.77310669	345	8	1.05	0.95	27.0936	0.0000	0.0000	0.0000;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	mu_Pmax	mu_Pmin	mu_Qmax	mu_Qmin
mpc.gen = [
	4	1244	0	0	0	1	100	1	1244	0	0	0	0	0	0	0	2	20	60	0	0	16.5960	0.0000	0.0000	0.0000;
	1	1235	0	0	0	1	100	1	1235	0	0	0	0	0	0	0	2	20	60	0	0	16.5255	0.0000	0.0000	0.0000;
	1	881	0	0	0	1	100	1	881	0	0	0	0	0	0	0	2	20	60	0	0	21.8293	0.0000	0.0000	0.0000;
	6	684.7	0	0	0	1	100	1	684.7	0	0	0	0	0	0	0	2	20	60	0	0	19.8060	0.0000	0.0000	0.0000;
	7	620.2	0	0	0	1	100	1	620.2	0	0	0	0	0	0	0	2	20	60	0	0	15.8207	0.0000	0.0000	0.0000;
	5	612	0	0	0	1	100	1	612	0	0	0	0	0	0	0	2	20	60	0	0	8.6667	0.0000	0.0000	0.0000;
	1	372.2	0	0	0	1	100	1	372.2	0	0	0	0	0	0	0	2	20	60	0	0	5.8704	0.0000	0.0000	0.0000;
	1	372.2	0	0	0	1	100	1	372.2	0	0	0	0	0	0	0	2	20	60	0	0	5.8704	0.0000	0.0000	0.0000;
	5	244	0	0	0	1	100	1	244	0	0	0	0	0	0	0	2	20	60	0	0	8.9350	0.0000	0.0000	0.0000;
	5	243.5	0	0	0	1	100	1	243.5	0	0	0	0	0	0	0	2	20	60	0	0	8.8352	0.0000	0.0000	0.0000;
	2	149.8	0	0	0	1	100	1	149.8	0	0	0	0	0	0	0	2	20	60	0	0	8.6576	0.0000	0.0000	0.0000;
	8	144.4	0	0	0	1	100	1	144.4	0	0	0	0	0	0	0	2	20	60	0	0	8.7589	0.0000	0.0000	0.0000;
	2	82	0	0	0	1	100	1	82	0	0	0	0	0	0	0	2	20	60	0	0	8.6739	0.0000	0.0000	0.0000;
	2	80	0	0	0	1	100	1	80	0	0	0	0	0	0	0	2	20	60	0	0	8.7744	0.0000	0.0000	0.0000;
	4	47.9	0	0	0	1	100	1	47.9	0	0	0	0	0	0	0	2	20	60	0	0	6.9536	0.0000	0.0000	0.0000;
	4	47.5	0	0	0	1	100	1	47.5	0	0	0	0	0	0	0	2	20	60	0	0	6.9549	0.0000	0.0000	0.0000;
	2	4.95736944e-12	0	0	0	1	100	1	600.4	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	133.4564	0.0000	0.0000;
	6	5.24200618e-12	0	0	0	1	100	1	558.7	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	126.0664	0.0000	0.0000;
	6	4.01265378e-12	0	0	0	1	100	1	553	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	164.9664	0.0000	0.0000;
	1	4.97021667e-12	0	0	0	1	100	1	447.9	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	132.9064	0.0000	0.0000;
	5	4.01279399e-12	0	0	0	1	100	1	435	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	164.9064	0.0000	0.0000;
	2	3.21871006e-12	0	0	0	1	100	1	431	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	205.9064	0.0000	0.0000;
	1	3.21023561e-12	0	0	0	1	100	1	407.4	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	206.3264	0.0000	0.0000;
	4	2.34646556e-11	0	0	0	1	100	1	400.2	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	27.4764	0.0000	0.0000;
	1	3.82399438e-12	0	0	0	1	100	1	400	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	173.0464	0.0000	0.0000;
	1	4.00964254e-12	0	0	0	1	100	1	236	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	164.9664	0.0000	0.0000;
	1	5.31945503e-12	0	0	0	1	100	1	168	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	124.0664	0.0000	0.0000;
	1	5.27574804e-12	0	0	0	1	100	1	130.5	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	125.0664	0.0000	0.0000;
	1	4.00879562e-12	0	0	0	1	100	1	117	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	164.9664	0.0000	0.0000;
	2	5.20091243e-12	0	0	0	1	100	1	115.5	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	127.0664	0.0000	0.0000;
	1	2.34469738e-11	0	0	0	1	100	1	81	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	26.9064	0.0000	0.0000;
	2	674.080546	0	0	0	1	100	1	693.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	2	334.519454	0	0	0	1	100	1	685.3	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	6	2.16537057e-11	0	0	0	1	100	1	675.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9064	0.0000	0.0000;
	2	1.04444647e-11	0	0	0	1	100	1	554.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	62.9064	0.0000	0.0000;
	5	7.47556865e-10	0	0	0	1	100	1	515.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.6264	0.0000	0.0000;
	4	508	0	0	0	1	100	1	508	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.9969	0.0000	0.0000	0.0000;
	2	490.4	0	0	0	1	100	1	490.4	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	1.2297	0.0000	0.0000	0.0000;
	1	2.78764128e-11	0	0	0	1	100	1	447.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	22.9064	0.0000	0.0000;
	5	8.49078473e-10	0	0	0	1	100	1	270.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.6264	0.0000	0.0000;
	5	2.165606e-11	0	0	0	1	100	1	264.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9064	0.0000	0.0000;
	5	248.7	0	0	0	1	100	1	248.7	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	4.8536	0.0000	0.0000	0.0000;
	5	247.8	0	0	0	1	100	1	247.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	4.8037	0.0000	0.0000	0.0000;
	5	247.8	0	0	0	1	100	1	247.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	4.9037	0.0000	0.0000	0.0000;
	2	2.5729023e-11	0	0	0	1	100	1	244.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	24.9064	0.0000	0.0000;
	6	2.09810847e-11	0	0	0	1	100	1	244.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	30.9064	0.0000	0.0000;
	5	2.13099159e-11	0	0	0	1	100	1	238.6	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	30.4064	0.0000	0.0000;
	8	238.3	0	0	0	1	100	1	238.3	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.3063	0.0000	0.0000	0.0000;
	5	2.20144187e-11	0	0	0	1	100	1	236.4	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.4064	0.0000	0.0000;
	2	1.04419339e-11	0	0	0	1	100	1	153.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	62.9064	0.0000	0.0000;
	5	2.19243975e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.4064	0.0000	0.0000;
	5	2.16868949e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.6564	0.0000	0.0000;
	5	2.14571279e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9064	0.0000	0.0000;
	5	2.12364433e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	30.1564	0.0000	0.0000;
	6	2.14134022e-11	0	0	0	1	100	1	141.1	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	30.1564	0.0000	0.0000;
	8	9.66005008e-12	0	0	0	1	100	1	141	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	67.9064	0.0000	0.0000;
	6	2.12745823e-11	0	0	0	1	100	1	104.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	30.4064	0.0000	0.0000;
	8	9.00148436e-12	0	0	0	1	100	1	104	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	72.9064	0.0000	0.0000;
	1	2.10052806e-11	0	0	0	1	100	1	43.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9364	0.0000	0.0000;
	1	2.10008931e-11	0	0	0	1	100	1	43.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9364	0.0000	0.0000;
	1	2.10008931e-11	0	0	0	1	100	1	43.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9364	0.0000	0.0000;
	1	2.09910796e-11	0	0	0	1	100	1	42.6	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	29.9364	0.0000	0.0000;
	8	1.90777936e-12	0	0	0	1	100	1	275	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	347.9064	0.0000	0.0000;
	5	1.7803366e-12	0	0	0	1	100	1	300	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	372.9064	0.0000	0.0000;
	5	2.05513609e-12	0	0	0	1	100	1	325	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	322.9064	0.0000	0.0000;
	1	2.22675223e-12	0	0	0	1	100	1	225	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	297.9064	0.0000	0.0000;
	8	1.90770949e-12	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	347.9064	0.0000	0.0000;
	8	2.05494247e-12	0	0	0	1	100	1	175	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	322.9064	0.0000	0.0000;
	2	2.43022104e-12	0	0	0	1	100	1	175	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	272.9064	0.0000	0.0000;
	2	2.52224856e-12	0	0	0	1	100	1	85	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	262.9064	0.0000	0.0000;
	2	2.34435823e-12	0	0	0	1	100	1	55	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	282.9064	0.0000	0.0000;
	2	2.22695808e-12	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	297.9064	0.0000	0.0000;
	2	2.05509508e-12	0	0	0	1	100	1	200	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	322.9064	0.0000	0.0000;
	2	2.12054201e-12	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	312.9064	0.0000	0.0000;
	2	1.90778922e-12	0	0	0	1	100	1	100	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	347.9064	0.0000	0.0000;
	2	2.34463263e-12	0	0	0	1	100	1	125	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	282.9064	0.0000	0.0000;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax	Pf	Qf	Pt	Qt	mu_Sf	mu_St	mu_angmin	mu_angmax
mpc.branch = [
	2	4	0	0.05	0	600	660	720	0	0	1	0	0	-155.2000	0.0000	155.2000	0.0000	0.0000	0.0000	0.0000	0.0000;
	7	4	0	0.04	0	250	275	300	0	0	1	0	0	118.7198	0.0000	-118.7198	0.0000	0.0000	0.0000	0.0000	0.0000;
	7	8	0	0.06	0	250	275	300	0	0	1	0	0	-1.5198	0.0000	1.5198	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	4	0	0.03	0	600	660	720	0	0	1	0	0	161.3328	0.0000	-161.3328	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	8	0	0.03	0	750	825	900	0	0	1	0	0	-497.5012	0.0000	497.5012	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	4	0	0.02	0	750	825	900	0	0	1	0	0	-504.2527	0.0000	504.2527	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	6	0	0.01	0	750	825	900	0	0	1	0	0	376.4519	0.0000	-376.4519	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	1	0	0.01	0	2500	2750	3000	0	0	1	0	0	-1305.0231	0.0000	1305.0231	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	5	0	0.03	0	300	330	360	0	0	1	0	0	148.3692	0.0000	-148.3692	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	5	0	0.02	0	1250	1375	1500	0	0	1	0	0	-523.6981	0.0000	523.6981	0.0000	0.0000	0.0000	0.0000	0.0000;
	1	5	0	0.03	0	800	880	960	0	0	1	0	0	583.3769	0.0000	-583.3769	0.0000	0.0000	0.0000	0.0000	0.0000;
	6	5	0	0.01	0	2500	2750	3000	0	0	1	0	0	-1423.8481	0.0000	1423.8481	0.0000	0.0000	0.0000	0.0000	0.0000;
];

%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	950000	95000	3	0.0002	10	1000;
	2	850000	85000	3	0.00023	10	1250;
	2	900000	90000	3	0.00015	5	1500;
	2	875000	87500	3	0.00021	7	1250;
	2	925000	92500	3	0.00022	11	1500;
	2	20915.15	2091.515	3	0.00012	18.28	3042.4;
	2	17336.83	1733.683	3	0.00167	19.98	1540;
	2	17500	1750	3	0.00167	19.98	1535;
	2	16860.36	1686.036	3	0.00012	18.1	1212.98;
	2	13947.52	1394.752	3	0.00012	18.2	1210.5;
	2	13872.67	1387.267	3	0.00012	18.4	744.69;
	2	13727.67	1372.767	3	0.00012	18.3	717.85;
	2	3486.01	348.601	3	0.00012	18.4	407.64;
	2	2441.71	244.171	3	0.00012	18.3	397.7;
	2	5774.179	577.4179	3	0.00167	19.98	238.12;
	2	5774.179	577.4179	3	0.00167	19.98	236.13;
	2	115287	11528.7	3	0.02367	160.55	10379;
	2	272400.8	27240.08	3	0.0346	153.16	10707;
	2	191144.1	19114.41	3	0.03463	192.06	12828;
	2	100000	10000	3	0.0236	160	7000;
	2	120000	12000	3	0.0345	192	10000;
	2	85000	8500	3	0.0312	233	8260;
	2	86332.49	8633.249	3	0.00598	233.42	7367;
	2	32566.38	3256.638	3	0.0014	54.57	3175;
	2	62461.34	6246.134	3	0.02184	200.14	11358;
	2	120000	12000	3	0.03463	192.06	5000;
	2	45000	4500	3	0.0347	151.16	4000;
	2	45000	4500	3	0.0345	152.16	3500;
	2	80000	8000	3	0.03463	192.06	2800;
	2	45000	4500	3	0.0346	154.16	3000;
	2	12000	1200	3	0.002	54	2100;
	2	66889.42	6688.942	3	0.00294	23.13	3858.73;
	2	66889.42	6688.942	3	0.00292	25.14	3858.73;
	2	76560.21	7656.021	3	0.00292	57	610.84;
	2	25000	2500	3	0.00292	90	612.84;
	2	325.75	32.575	3	0.00292	27.72	0;
	2	1000	100	3	0.00292	23.13	0;
	2	1000	100	3	0.00292	23	0;
	2	2500	250	3	0.00292	50	0;
	2	2352	235.2	3	0.0229	27.72	0;
	2	12000	1200	3	0.003	57	500;
	2	11112.19	1111.219	3	2e-05	22.23	699.7;
	2	11112.19	1111.219	3	2e-05	22.28	699.7;
	2	11112.19	1111.219	3	2e-05	22.18	699.7;
	2	62500	6250	3	0.003	52	0;
	2	12000	1200	3	0.004	58	475;
	2	12000	1200	3	0.0035	57.5	485;
	2	7500	750	3	0.00375	25	250;
	2	12000	1200	3	0.00372	56.5	495;
	2	5000	500	3	0.0041	90	250;
	2	7250	725	3	0.008	56.5	250;
	2	4000	400	3	0.013	56.75	350;
	2	3500	350	3	0.0175	57	325;
	2	4000	400	3	0.022	57.25	375;
	2	5000	500	3	0.015	57.25	320;
	2	7250	725	3	0.0035	95	200;
	2	2500	250	3	0.005	57.5	300;
	2	7750	775	3	0.0075	100	250;
	2	325.75	32.575	3	0.02133	57.03	612.84;
	2	325.75	32.575	3	0.02133	57.03	612.84;
	2	325.75	32.575	3	0.02133	57.03	612.84;
	2	325.75	32.575	3	0.02133	57.03	612.84;
	2	0	0	3	0.0042	375	0;
	2	0	0	3	0.0035	400	0;
	2	0	0	3	0.0036	350	0;
	2	0	0	3	0.0342	325	0;
	2	0	0	3	0.008	375	0;
	2	0	0	3	0.009	350	0;
	2	0	0	3	0.009	300	0;
	2	0	0	3	0.009	290	0;
	2	0	0	3	0.009	310	0;
	2	0	0	3	0.009	325	0;
	2	0	0	3	0.008	350	0;
	2	0	0	3	0.0075	340	0;
	2	0	0	3	0.0085	375	0;
	2	0	0	3	0.0095	310	0;
];

%% generator fuel type (see GENFUELS)
mpc.genfuel = {
	'NUC ';
	' NUC ';
	' NUC ';
	' NUC ';
	' NUC ';
	' BIT ';
	' SUB ';
	' SUB ';
	' BIT ';
	' BIT ';
	' BIT ';
	' BIT ';
	' BIT ';
	' BIT ';
	' BIT ';
	' BIT ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' RFO ';
	' NGLN ';
	' NGLN ';
	' NGA4 ';
	' NGA1 ';
	' NGTN ';
	' NGMN ';
	' NGMN ';
	' NGIR ';
	' NGTN ';
	' NGA4 ';
	' NGA4 ';
	' NGA4 ';
	' NGA4 ';
	' NGPN ';
	' NGA4 ';
	' NGA4 ';
	' NGT2 ';
	' NGA4 ';
	' NGA1 ';
	' NGT4 ';
	' NGA4 ';
	' NGA4 ';
	' NGA4 ';
	' NGA4 ';
	' NGT1 ';
	' NGA4 ';
	' NGT2 ';
	' NGA4 ';
	' NGA4 ';
	' NGA4 ';
	' NGA4 ';
	' NGTN ';
	' NGTN ';
	' NGTN ';
	' RFO ';
	' NGT2 ';
	' NGT2 ';
	' NGPN ';
	' NGPN ';
	' NGPN ';
	' NGTN ';
	' NGTN ';
	' NGTN ';
	' NGTN ';
	' NGTN ';
};