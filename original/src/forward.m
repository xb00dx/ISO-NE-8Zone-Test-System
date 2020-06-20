%The forward selection algorithm of scenario reduction


function [selected_scenarios, p, totalD, select] = forward(scenarios, P, select_num);

%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%
%scenarios: M*N, M is number of scenarios; N is the dimension of a scenario
%P: probabilities for the scenarios, M*1
%select_num: # of scenarios that are to be selected

%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%
%selected_scenarios: select_num*N
%p: select_num*1, the new probability
%totalD: total distance between selected scenarios and the unselected ones
%select: the index of the selected scenarios in the original set



%Find out the original # of scenarios
[scenario_num dimension] = size(scenarios);
 tic;
if select_num < scenario_num
    %For each scenario
    %1st entry: select(1) or not (0); 
    %2nd entry: min distance; 
    %3rd entry: to which selected scenario it has the min distance.
    selectORnot = zeros(scenario_num,3);
    
    %The initial min distance is inf;
    for j = 1:scenario_num
        selectORnot(j,2) = inf;
    end
    
    %Select scenario one by one
    for s = 1:select_num            
        sum = inf;       
        for u = 1:scenario_num            
            
            %Test the u th scenario if it is not selected yet
            if selectORnot(u,1) == 0  
                %Calculate the sum of min distance if u th scenario is selected
                Distance = 0;                
                for j = 1:scenario_num
                    %Only add the min distance if the j th scenario is not selected
                    if selectORnot(j,1) == 0
                        %Calculate the distance between the scenario being tested and the scenario being calculated                        
                        D = ((scenarios(j,:)-scenarios(u,:))*(scenarios(j,:)-scenarios(u,:))')^0.5;
                        if D < selectORnot(j,2)
                            Distance = Distance + P(j)*D;
                        else
                            Distance = Distance + P(j)*selectORnot(j,2);
                        end
                    end
                end
                if Distance < sum
                    sum = Distance;
                    select(s,1) = u;
                end
            end              
        end
        
        %After testing every unselected scenarios, the decision is made
        selectORnot(select(s),1)=1;            
        %update the minimum distance
        for j = 1:scenario_num
            if selectORnot(j,1) == 0
               %Update the minimum distance for each unselected scenario
                D = ((scenarios(j,:)-scenarios(select(s),:))* (scenarios(j,:)-scenarios(select(s),:))')^0.5;
                if D < selectORnot(j,2)
                    selectORnot(j,2) = D;
                    selectORnot(j,3) = s;%This index is the selected index, not the original
                end
            end
        end               
    end
    
    %After all the scenarios are selected
    %Probability redistribution
    for s = 1:select_num
        p(s,1) = P(select(s));
        selected_scenarios(s,:) = scenarios(select(s),:);
    end
    
   totalD = 0;
    for j = 1:scenario_num        
        if selectORnot(j,1) == 0
            totalD = totalD + selectORnot(j,2)*P(j);
            p(selectORnot(j,3))= p(selectORnot(j,3))+P(j);
        end
    end

else
    selected_scenarios = scenarios;
    p = P;
    totalD = 0;
    for s = 1:select_num
        select(s,1)=s;
    end
end

Time = toc
    
  
