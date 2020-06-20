
%% reduction
%folderAnalogTimes = '~LocalFiles\ARPA-E Stochastic SCUC\WIND\Wind-3TIER\sandia_arpa-e_analog_forecasts\';
%fileAnalogWeight = 'ISONE-00UTC-analog-weight.csv';
%P = csvread (fullfile(folderAnalogTimes,fileAnalogWeight),1,2,'C2..AZ2');

P = repmat(1/90,90,1);

%scenarios = [windScaled(:,:,4);windScaled(:,:,5);windScaled(:,:,3);windScaled(:,:,1);windScaled(:,:,2);windScaled(:,:,6);windScaled(:,:,7);windScaled(:,:,8);load(:,:,1);load(:,:,2);load(:,:,3);load(:,:,4);load(:,:,5);load(:,:,6);load(:,:,7);load(:,:,8)]';
scenarios = [windScaled(:,:,1);windScaled(:,:,2);windScaled(:,:,3);windScaled(:,:,4);windScaled(:,:,5);windScaled(:,:,6);windScaled(:,:,7);windScaled(:,:,8);load(:,:,1);load(:,:,2);load(:,:,3);load(:,:,4);load(:,:,5);load(:,:,6);load(:,:,7);load(:,:,8)]';
%scenarios = [load(:,:,1);load(:,:,2);load(:,:,3);load(:,:,4);load(:,:,5);load(:,:,6);load(:,:,7);load(:,:,8)]';
%scenarios = [windScaled(:,:,1);windScaled(:,:,2);windScaled(:,:,3);windScaled(:,:,4);windScaled(:,:,5);windScaled(:,:,6);windScaled(:,:,7);windScaled(:,:,8)]';

P = P';
[selected_scenarios, p, totalD, select] = forward(scenarios, P, select_num);

HOURS=24*(MAX_DAY-1);
% 
% for j=1:6
%     figure();
%     for i=1:select_num
%         plot(selected_scenarios(i,1+HOURS*(j-1):HOURS*j),'LineWidth',2);
%         hold all
%     end
%     legend(strcat('s1 = ',num2str(p(1))),strcat('s2 = ',num2str(p(2))),strcat('s3 = ',num2str(p(3))),strcat('s4 = ',num2str(p(4))),strcat('s5 = ',num2str(p(5))));
%     hold off
% end
  
