%% Dheepak Krishnamurthy
% Arpae/DOE Project
% Date 2014-05-03

% save treatment factors
save([mainDir '/Output/probability_testcase.mat'],'probability');
save([mainDir '/Output/probability_testcase_realized.mat'],'probability_realized');

save([mainDir '/Output/WIND_PEN.mat'],'WIND_PEN');
save([mainDir '/Output/ReserveRequirements.mat'],'ReserveRequirements');
save([mainDir '/Output/numMonthIdx.mat'],'numMonthIdx');
save([mainDir '/Output/setOfMonths.mat'],'setOfMonths');

save([mainDir '/Output/treatmentFactors_WindPen.mat'],'tf_WindPen');
save([mainDir '/Output/treatmentFactors_noGen.mat'],'tf_REQGEN');
save([mainDir '/Output/treatmentFactors_ReserveRequirements.mat'],'tf_ReserveRequirements');
save([mainDir '/Output/treatmentFactors_CAPMARGIN.mat'],'tf_CAP_MARGIN');
save([mainDir '/Output/treatmentFactors_NOLOADCOST.mat'],'tf_NOLOADCOST');
save([mainDir '/Output/treatmentFactors_SSCOST.mat'],'tf_SSCOST');
save([mainDir '/Output/treatmentFactors_MonthNum.mat'],'tf_MonthNum');
save([mainDir '/Output/treatmentFactors_MonthString.mat'],'tf_MonthString');
