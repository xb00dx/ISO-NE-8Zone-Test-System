function mpc = case8_isone_72_3
%CASE8_ISONE_72_3  8-zone synthetic grid based on ISO-NE data
%  This case represents hour 72/96 (4 days) and scenario 3/90.
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
	1	2	1140	0	0	0	1	1	15.2092905	345	1	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	2	2	2659	0	0	0	2	1	-6.66922874	345	2	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	3	2	1571	0	0	0	3	1	-5.28560857	345	3	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	4	3	1949	0	0	0	4	1	0	345	4	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	5	2	845	0	0	0	5	1	5.00829544	345	5	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	6	2	3572	0	0	0	6	1	-7.54672708	345	6	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	7	2	608	0	0	0	7	1	2.22055362	345	7	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
	8	2	1145	0	0	0	8	1	5.13197896	345	8	1.05	0.95	58.1284	0.0000	0.0000	0.0000;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	mu_Pmax	mu_Pmin	mu_Qmax	mu_Qmin
mpc.gen = [
	4	1244	0	0	0	1	100	1	1244	0	0	0	0	0	0	0	2	20	60	0	0	47.6308	0.0000	0.0000	0.0000;
	1	1235	0	0	0	1	100	1	1235	0	0	0	0	0	0	0	2	20	60	0	0	47.5603	0.0000	0.0000	0.0000;
	1	881	0	0	0	1	100	1	881	0	0	0	0	0	0	0	2	20	60	0	0	52.8641	0.0000	0.0000	0.0000;
	6	684.7	0	0	0	1	100	1	684.7	0	0	0	0	0	0	0	2	20	60	0	0	50.8408	0.0000	0.0000	0.0000;
	7	620.2	0	0	0	1	100	1	620.2	0	0	0	0	0	0	0	2	20	60	0	0	46.8555	0.0000	0.0000	0.0000;
	5	612	0	0	0	1	100	1	612	0	0	0	0	0	0	0	2	20	60	0	0	39.7015	0.0000	0.0000	0.0000;
	1	372.2	0	0	0	1	100	1	372.2	0	0	0	0	0	0	0	2	20	60	0	0	36.9053	0.0000	0.0000	0.0000;
	1	372.2	0	0	0	1	100	1	372.2	0	0	0	0	0	0	0	2	20	60	0	0	36.9053	0.0000	0.0000	0.0000;
	5	244	0	0	0	1	100	1	244	0	0	0	0	0	0	0	2	20	60	0	0	39.9699	0.0000	0.0000	0.0000;
	5	243.5	0	0	0	1	100	1	243.5	0	0	0	0	0	0	0	2	20	60	0	0	39.8700	0.0000	0.0000	0.0000;
	2	149.8	0	0	0	1	100	1	149.8	0	0	0	0	0	0	0	2	20	60	0	0	39.6925	0.0000	0.0000	0.0000;
	8	144.4	0	0	0	1	100	1	144.4	0	0	0	0	0	0	0	2	20	60	0	0	39.7938	0.0000	0.0000	0.0000;
	2	82	0	0	0	1	100	1	82	0	0	0	0	0	0	0	2	20	60	0	0	39.7087	0.0000	0.0000	0.0000;
	2	80	0	0	0	1	100	1	80	0	0	0	0	0	0	0	2	20	60	0	0	39.8092	0.0000	0.0000	0.0000;
	4	47.9	0	0	0	1	100	1	47.9	0	0	0	0	0	0	0	2	20	60	0	0	37.9884	0.0000	0.0000	0.0000;
	4	47.5	0	0	0	1	100	1	47.5	0	0	0	0	0	0	0	2	20	60	0	0	37.9898	0.0000	0.0000	0.0000;
	2	3.83129434e-14	0	0	0	1	100	1	600.4	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	102.4216	0.0000	0.0000;
	6	4.0810569e-14	0	0	0	1	100	1	558.7	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	95.0316	0.0000	0.0000;
	6	2.88226604e-14	0	0	0	1	100	1	553	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	133.9316	0.0000	0.0000;
	1	3.7763148e-14	0	0	0	1	100	1	447.9	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	101.8716	0.0000	0.0000;
	5	2.86314868e-14	0	0	0	1	100	1	435	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	133.8716	0.0000	0.0000;
	2	2.18370508e-14	0	0	0	1	100	1	431	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	174.8716	0.0000	0.0000;
	1	2.14334565e-14	0	0	0	1	100	1	407.4	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	175.2916	0.0000	0.0000;
	4	400.2	0	0	0	1	100	1	400.2	0	0	0	0	0	0	0	2	20	60	0	0	2.4379	0.0000	0.0000	0.0000;
	1	2.68721174e-14	0	0	0	1	100	1	400	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	142.0116	0.0000	0.0000;
	1	2.83709505e-14	0	0	0	1	100	1	236	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	133.9316	0.0000	0.0000;
	1	4.0494605e-14	0	0	0	1	100	1	168	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	93.0316	0.0000	0.0000;
	1	3.98481796e-14	0	0	0	1	100	1	130.5	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	94.0316	0.0000	0.0000;
	1	2.80689829e-14	0	0	0	1	100	1	117	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	133.9316	0.0000	0.0000;
	2	3.93463256e-14	0	0	0	1	100	1	115.5	0	0	0	0	0	0	0	2	20	60	0	0	0.0000	96.0316	0.0000	0.0000;
	1	81	0	0	0	1	100	1	81	0	0	0	0	0	0	0	2	20	60	0	0	3.8044	0.0000	0.0000	0.0000;
	2	693.8	0	0	0	1	100	1	693.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	30.9189	0.0000	0.0000	0.0000;
	2	685.3	0	0	0	1	100	1	685.3	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	28.9863	0.0000	0.0000	0.0000;
	6	193.221724	0	0	0	1	100	1	675.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	2	1.41276953e-13	0	0	0	1	100	1	554.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	31.8716	0.0000	0.0000;
	5	515.5	0	0	0	1	100	1	515.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	27.3979	0.0000	0.0000	0.0000;
	4	508	0	0	0	1	100	1	508	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	32.0317	0.0000	0.0000	0.0000;
	2	490.4	0	0	0	1	100	1	490.4	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	32.2645	0.0000	0.0000	0.0000;
	1	447.9	0	0	0	1	100	1	447.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	5.5127	0.0000	0.0000	0.0000;
	5	270.9	0	0	0	1	100	1	270.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	18.0012	0.0000	0.0000	0.0000;
	5	188.069145	0	0	0	1	100	1	264.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	5	248.7	0	0	0	1	100	1	248.7	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	35.8885	0.0000	0.0000	0.0000;
	5	247.8	0	0	0	1	100	1	247.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	35.8385	0.0000	0.0000	0.0000;
	5	247.8	0	0	0	1	100	1	247.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	35.9385	0.0000	0.0000	0.0000;
	2	244.9	0	0	0	1	100	1	244.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	4.6590	0.0000	0.0000	0.0000;
	6	16.0518586	0	0	0	1	100	1	244.8	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	5	89.7735526	0	0	0	1	100	1	238.6	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	8	238.3	0	0	0	1	100	1	238.3	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	31.3412	0.0000	0.0000	0.0000;
	5	218.872966	0	0	0	1	100	1	236.4	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	2	1.17710578e-13	0	0	0	1	100	1	153.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	31.8716	0.0000	0.0000;
	5	101.775929	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	5	53.0159565	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	5	32.2404248	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	5	19.9639743	0	0	0	1	100	1	149	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	6	29.2804956	0	0	0	1	100	1	141.1	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	8	1.00260214e-13	0	0	0	1	100	1	141	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	36.8716	0.0000	0.0000;
	6	62.8414869	0	0	0	1	100	1	104.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	8	8.73932864e-14	0	0	0	1	100	1	104	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	41.8716	0.0000	0.0000;
	1	25.7481216	0	0	0	1	100	1	43.9	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	1	25.7481216	0	0	0	1	100	1	43.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	1	25.7481216	0	0	0	1	100	1	43.5	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	1	25.7481216	0	0	0	1	100	1	42.6	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	0.0000	0.0000	0.0000;
	8	1.19098489e-14	0	0	0	1	100	1	275	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	316.8716	0.0000	0.0000;
	5	1.10364644e-14	0	0	0	1	100	1	300	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	341.8716	0.0000	0.0000;
	5	1.2923089e-14	0	0	0	1	100	1	325	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	291.8716	0.0000	0.0000;
	1	1.41872613e-14	0	0	0	1	100	1	225	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	266.8716	0.0000	0.0000;
	8	1.19020305e-14	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	316.8716	0.0000	0.0000;
	8	1.29187957e-14	0	0	0	1	100	1	175	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	291.8716	0.0000	0.0000;
	2	1.55849454e-14	0	0	0	1	100	1	175	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	241.8716	0.0000	0.0000;
	2	1.61957733e-14	0	0	0	1	100	1	85	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	231.8716	0.0000	0.0000;
	2	1.48881742e-14	0	0	0	1	100	1	55	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	251.8716	0.0000	0.0000;
	2	1.41371307e-14	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	266.8716	0.0000	0.0000;
	2	1.29415808e-14	0	0	0	1	100	1	200	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	291.8716	0.0000	0.0000;
	2	1.33909572e-14	0	0	0	1	100	1	150	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	281.8716	0.0000	0.0000;
	2	1.19105684e-14	0	0	0	1	100	1	100	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	316.8716	0.0000	0.0000;
	2	1.49612565e-14	0	0	0	1	100	1	125	0	0	0	0	0	0	0	6.66666667	66.6666667	200	0	0	0.0000	251.8716	0.0000	0.0000;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax	Pf	Qf	Pt	Qt	mu_Sf	mu_St	mu_angmin	mu_angmax
mpc.branch = [
	2	4	0	0.05	0	600	660	720	0	0	1	0	0	-232.8000	0.0000	232.8000	0.0000	0.0000	0.0000	0.0000	0.0000;
	7	4	0	0.04	0	250	275	300	0	0	1	0	0	96.8899	0.0000	-96.8899	0.0000	0.0000	0.0000	0.0000	0.0000;
	7	8	0	0.06	0	250	275	300	0	0	1	0	0	-84.6899	0.0000	84.6899	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	4	0	0.03	0	600	660	720	0	0	1	0	0	298.5664	0.0000	-298.5664	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	8	0	0.03	0	750	825	900	0	0	1	0	0	-606.0707	0.0000	606.0707	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	4	0	0.02	0	750	825	900	0	0	1	0	0	-461.2564	0.0000	461.2564	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	6	0	0.01	0	750	825	900	0	0	1	0	0	394.6396	0.0000	-394.6396	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	1	0	0.01	0	2500	2750	3000	0	0	1	0	0	-1758.8227	0.0000	1758.8227	0.0000	0.0000	0.0000	0.0000	0.0000;
	8	5	0	0.03	0	300	330	360	0	0	1	0	0	7.1956	0.0000	-7.1956	0.0000	0.0000	0.0000	0.0000	0.0000;
	3	5	0	0.02	0	1250	1375	1500	0	0	1	0	0	-898.3126	0.0000	898.3126	0.0000	0.0000	0.0000	0.0000	0.0000;
	1	5	0	0.03	0	800	880	960	0	0	1	0	0	593.4698	0.0000	-593.4698	0.0000	0.0000	0.0000	0.0000	0.0000;
	6	5	0	0.01	0	2500	2750	3000	0	0	1	0	0	-2191.2648	0.0000	2191.2648	0.0000	0.0000	0.0000	0.0000	0.0000;
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
