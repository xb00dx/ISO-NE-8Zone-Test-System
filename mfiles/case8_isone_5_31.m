function mpc = case8_isone_5_31
%CASE8_ISONE_5_31  8-zone synthetic grid based on ISO-NE data
%  This case represents hour 5/96 (4 days) and scenario 31/90.
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
	1	2	1012	0	0	0	1	1	10.0274123	345	1	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	2	2	2157	0	0	0	2	1	0.696143721	345	2	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	3	2	1274	0	0	0	3	1	-6.24959587	345	3	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	4	3	1569	0	0	0	4	1	0	345	4	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	5	2	672	0	0	0	5	1	1.04890774	345	5	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	6	2	2785	0	0	0	6	1	-8.61726035	345	6	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	7	2	522	0	0	0	7	1	2.32222504	345	7	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
	8	2	979	0	0	0	8	1	2.42969528	345	8	1.05	0.95	30.5662	0.0000	0.0000	0.0000;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	mu_Pmax	mu_Pmin	mu_Qmax	mu_Qmin
mpc.gen = [
	4	1244	0	0	0	1	100	1	1244	0	0	0	0	0	0	0	2	20	60	0	0	20.0686	0.0000	0.0000	0.0000;
	1	1235	0	0	0	1	100	1	1235	0	0	0	0	0	0	0	2	20	60	0	0	19.9981	0.0000	0.0000	0.0000;
	1	881	0	0	0	1	100	1	881	0	0	0	0	0	0	0	2	20	60	0	0	25.3019	0.0000	0.0000	0.0000;
	6	684.7	0	0	0	1	100	1	684.7	0	0	0	0	0	0	0	2	20	60	0	0	23.2786	0.0000	0.0000	0.0000;
	7	620.2	0	0	0	1	100	1	620.2	0	0	0	0	0	0	0	2	20	60	0	0	19.2933	0.0000	0.0000	0.0000;
	5	612	0	0	0	1	100	1	612	0	0	0	0	0	0	0	2	20	60	0	0	12.1393	0.0000	0.0000	0.0000;
	1	372.2	0	0	0	1	100	1	372.2	0	0	0	0	0	0	0	2	20	60	0	0	9.3430	0.0000	0.0000	0.0000;
	1	372.2	0	0	0	1	100	1	372.2	0	0	0	0	0	0	0	2	20	60	0	0	9.3430	0.0000	0.0000	0.0000;
	5	244	0	0	0	1	100	1	244	0	0	0	0	0	0	0	2	20	60	0	0	12.4076	0.0000	0.0000	0.0000;
	5	243.5	0	0	0	1	100	1	243.5	0	0	0	0	0	0	0	2	20	60	0	0	12.3077	0.0000	0.0000	0.0000;
	2	149.8	0	0	0	1	100	1	149.8	0	0	0	0	0	0	0	2	20	60	0	0	12.1302	0.0000	0.0000	0.0000;
	8	144.4	0	0	0	1	100	1	144.4	0	0	0	0	0	0	0	2	20	60	0	0	12.2315	0.0000	0.0000	0.0000;
	2	82	0	0	0	1	100	1	82	0	0	0	0	0	0	0	2	20	60	0	0	12.1465	0.0000	0.0000	0.0000;
	2	80	0	0	0	1	100	1	80	0	0	0	0	0	0	0	2	20	60	0	0	12.2470	0.0000	0.0000	0.0000;
	4	47.9	0	0	0	1	100	1	47.9	0	0	0	0	0	0	0	2	20	60	0	0	10.4262	0.0000	0.0000	0.0000;
	4	47.5	0	0	0	1	100	1	47.5	0	0	0	0	0	0	0	2	20	60	0	0	10.4275	0.0000	0.0000	0.0000;
	2	8.73092495e-12	0	0	0	1	100	1	600.4	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	129.9838	0.0000	0.0000;
	6	9.25682869e-12	0	0	0	1	100	1	558.7	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	122.5938	0.0000	0.0000;
	6	7.03122691e-12	0	0	0	1	100	1	553	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	161.4938	0.0000	0.0000;
	1	8.76681368e-12	0	0	0	1	100	1	447.9	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	129.4338	0.0000	0.0000;
	5	7.03323336e-12	0	0	0	1	100	1	435	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	161.4338	0.0000	0.0000;
	2	5.61050986e-12	0	0	0	1	100	1	431	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	202.4338	0.0000	0.0000;
	1	5.59918525e-12	0	0	0	1	100	1	407.4	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	202.8538	0.0000	0.0000;
	4	4.75969733e-11	0	0	0	1	100	1	400.2	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	24.0038	0.0000	0.0000;
	1	6.69563123e-12	0	0	0	1	100	1	400	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	169.5738	0.0000	0.0000;
	1	7.02946157e-12	0	0	0	1	100	1	236	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	161.4938	0.0000	0.0000;
	1	9.40694547e-12	0	0	0	1	100	1	168	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	120.5938	0.0000	0.0000;
	1	9.32819571e-12	0	0	0	1	100	1	130.5	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	121.5938	0.0000	0.0000;
	1	7.02826178e-12	0	0	0	1	100	1	117	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	161.4938	0.0000	0.0000;
	2	9.17636057e-12	0	0	0	1	100	1	115.5	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	123.5938	0.0000	0.0000;
	1	4.85195192e-11	0	0	0	1	100	1	81	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	23.4338	0.0000	0.0000;
	2	693.8	0	0	0	1	100	1	693.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	3.3566	0.0000	0.0000	0.0000;
	2	685.3	0	0	0	1	100	1	685.3	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	1.4240	0.0000	0.0000	0.0000;
	6	4.33188043e-11	0	0	0	1	100	1	675.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4338	0.0000	0.0000;
	2	1.90653555e-11	0	0	0	1	100	1	554.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	59.4338	0.0000	0.0000;
	5	487.3567	0	0	0	1	100	1	515.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	4	508	0	0	0	1	100	1	508	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	4.4694	0.0000	0.0000	0.0000;
	2	490.4	0	0	0	1	100	1	490.4	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	4.7022	0.0000	0.0000	0.0000;
	1	5.92228666e-11	0	0	0	1	100	1	447.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	19.4338	0.0000	0.0000;
	5	62.1432998	0	0	0	1	100	1	270.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	5	4.32364437e-11	0	0	0	1	100	1	264.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4338	0.0000	0.0000;
	5	248.7	0	0	0	1	100	1	248.7	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	8.3262	0.0000	0.0000	0.0000;
	5	247.8	0	0	0	1	100	1	247.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	8.2763	0.0000	0.0000	0.0000;
	5	247.8	0	0	0	1	100	1	247.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	8.3763	0.0000	0.0000	0.0000;
	2	5.30980695e-11	0	0	0	1	100	1	244.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	21.4338	0.0000	0.0000;
	6	4.16298959e-11	0	0	0	1	100	1	244.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	27.4338	0.0000	0.0000;
	5	4.23982067e-11	0	0	0	1	100	1	238.6	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.9338	0.0000	0.0000;
	8	238.3	0	0	0	1	100	1	238.3	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	3.7789	0.0000	0.0000	0.0000;
	5	4.40644935e-11	0	0	0	1	100	1	236.4	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	25.9338	0.0000	0.0000;
	2	1.90302782e-11	0	0	0	1	100	1	153.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	59.4338	0.0000	0.0000;
	5	4.40147141e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	25.9338	0.0000	0.0000;
	5	4.35793475e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.1838	0.0000	0.0000;
	5	4.3160746e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4338	0.0000	0.0000;
	5	4.27451049e-11	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.6838	0.0000	0.0000;
	6	4.27602465e-11	0	0	0	1	100	1	141.1	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.6838	0.0000	0.0000;
	8	1.75894546e-11	0	0	0	1	100	1	141	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	64.4338	0.0000	0.0000;
	6	4.23764239e-11	0	0	0	1	100	1	104.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.9338	0.0000	0.0000;
	8	1.63239796e-11	0	0	0	1	100	1	104	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	69.4338	0.0000	0.0000;
	1	4.0383952e-11	0	0	0	1	100	1	43.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4638	0.0000	0.0000;
	1	4.03347595e-11	0	0	0	1	100	1	43.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4638	0.0000	0.0000;
	1	4.03347595e-11	0	0	0	1	100	1	43.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4638	0.0000	0.0000;
	1	4.02234517e-11	0	0	0	1	100	1	42.6	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	26.4638	0.0000	0.0000;
	8	3.30027239e-12	0	0	0	1	100	1	275	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	344.4338	0.0000	0.0000;
	5	3.07725979e-12	0	0	0	1	100	1	300	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	369.4338	0.0000	0.0000;
	5	3.55829592e-12	0	0	0	1	100	1	325	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	319.4338	0.0000	0.0000;
	1	3.85965169e-12	0	0	0	1	100	1	225	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	294.4338	0.0000	0.0000;
	8	3.29996443e-12	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	344.4338	0.0000	0.0000;
	8	3.55795784e-12	0	0	0	1	100	1	175	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	319.4338	0.0000	0.0000;
	2	4.2170245e-12	0	0	0	1	100	1	175	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	269.4338	0.0000	0.0000;
	2	4.3788887e-12	0	0	0	1	100	1	85	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	259.4338	0.0000	0.0000;
	2	4.06558491e-12	0	0	0	1	100	1	55	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	279.4338	0.0000	0.0000;
	2	3.85940754e-12	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	294.4338	0.0000	0.0000;
	2	3.55797855e-12	0	0	0	1	100	1	200	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	319.4338	0.0000	0.0000;
	2	3.67261147e-12	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	309.4338	0.0000	0.0000;
	2	3.29970387e-12	0	0	0	1	100	1	100	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	344.4338	0.0000	0.0000;
	2	4.06612531e-12	0	0	0	1	100	1	125	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	279.4338	0.0000	0.0000;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax	Pf	Qf	Pt	Qt	mu_Sf	mu_St	mu_angmin	mu_angmax
mpc.branch = [
	2	4	0	0.05	0	600	660	720	0	0	1	0	0	24.3000	0.0000	-24.3000	0.0000	0.0000	0.0000	0.0000	0.0000;
	7	4	0	0.04	0	250	275	300	0	0	1	0	0	101.3262	0.0000	-101.3262	0.0000	0.0000	0.0000	0.0000	0.0000;
	7	8	0	0.06	0	250	275	300	0	0	1	0	0	-3.1262	0.0000	3.1262	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	4	0	0.03	0	600	660	720	0	0	1	0	0	141.3539	0.0000	-141.3539	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	8	0	0.03	0	750	825	900	0	0	1	0	0	-504.9407	0.0000	504.9407	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	4	0	0.02	0	750	825	900	0	0	1	0	0	-545.3801	0.0000	545.3801	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	6	0	0.01	0	750	825	900	0	0	1	0	0	413.2354	0.0000	-413.2354	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	1	0	0.01	0	2500	2750	3000	0	0	1	0	0	-1326.0518	0.0000	1326.0518	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	5	0	0.03	0	300	330	360	0	0	1	0	0	80.3310	0.0000	-80.3310	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	5	0	0.02	0	1250	1375	1500	0	0	1	0	0	-636.9146	0.0000	636.9146	0.0000	0.0000	0.0000	0.0000	0.0000;
	1	5	0	0.03	0	800	880	960	0	0	1	0	0	522.3482	0.0000	-522.3482	0.0000	0.0000	0.0000	0.0000	0.0000;
	6	5	0	0.01	0	2500	2750	3000	0	0	1	0	0	-1687.0646	0.0000	1687.0646	0.0000	0.0000	0.0000	0.0000	0.0000;
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
