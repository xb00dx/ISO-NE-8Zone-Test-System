%%
%

clc
clear

% str = input('Main directory path: ','s');         
% if(exist(str,'dir'))
%          mainDir = str;
% else
%     display('Path does not exist')
%     break
% end

cd(pwd)

tableData = {1	'ME'	'NH'	115	19.09	54.05	0.0454
2	'VT'	'NH'	100	16.6	47	0.0395
3	'VT'	'WCMA'	150	24.9	70.5	0.0592
4	'WCMA'	'NH'	86	14.28	40.42	0.034
5	'NEMA/BOST'	'WCMA'	80	13.28	37.6	0.0316
6	'NEMA/BOST'	'NH'	63	10.46	29.61	0.0249
7	'NEMA/BOST'	'SEMA'	30	4.98	14.1	0.0118
8	'WCMA'	'CT'	30	4.98	14.1	0.0118
9	'WCMA'	'RI'	65	10.79	30.55	0.0257
10	'NEMA/BOST'	'RI'	40	6.64	18.8	0.0158
11	'CT'	'RI'	64	10.62	30.08	0.0253
12	'SEMA'	'RI'	20	3.32	9.4	0.0079};

titleData = {' Line no ', ' From Zone ', ' To Zone ', ' Distance ', ... 
    ' Resistance (ohms) ' , ' Reactance (ohms) ' , ' Reactance (per unit) '};
outfile = 'temp';
formatString = {'%d','%s','%s', '%4.2f' , '%4.2f', '%4.2f', '%4.2f' };

Table2TeX(outfile,tableData,titleData,formatString)

