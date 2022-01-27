% MIT License
% 
% Copyright (c) 2021 NIMH
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
% 
% QP Plot generator
% Development Environment: MATLAB 2020b
% 
% Created on Thu Mar 11 13:14:03 EST 2021
% 
% @author: Kyunghun Lee
% - Created on Thu Mar 11 13:14:03 EST 2021 by KL
% - updated on Thu Jan 27 10:31:15 EST 2022 by KL (median version only)
clear;clc;
Conditions = ["CON","NEU","INC"];
addpath('./QuantProbPlot');

%j = 1;
for j=1:length(Conditions)
    Condition = Conditions(j);
    
    % Load Emperical Dataset.
    P = './EmpericalData_Organized/';
    S = dir(fullfile(P,strcat('*',Condition,'.dat')));
    N = {S.name};

    for i=1:length(N)
        fileName = strcat(P,N{1,i});
        if ~contains(fileName,'23127') % 22721 $ 23127!!!!
            continue
        end  
        
        dataTmp = readmatrix(fileName);
        
        % Swap 1st column and second column.
        tmp = dataTmp(:,1);
        dataTmp(:,1) = dataTmp(:,2);
        dataTmp(:,2) = tmp;
        
        % Assign Condition (Emperical: 1).
        dataTmp(:,3) = 1;
        
        % Get subjectID and assign it.
        subjectID = split(fileName,'/');subjectID = subjectID{end};
        subjectID = split(subjectID,'_');subjectID = subjectID{1};
        subjectID = str2num(subjectID);
        dataTmp(:,4) = subjectID;
        
%         if i==1
        dataEmp = dataTmp;
%         else
%             dataEmp = vertcat(dataEmp,dataTmp);
%         end
    end

    
    % Load Simulated dataset.
%     P = './SimulationData_Organized/';
%     S = dir(fullfile(P,strcat('*',Condition,'.dat')));
%     N = {S.name};
% 
%     for i=1:length(N)
%         fileName = strcat(P,N{1,i});
%         dataTmp = readmatrix(fileName);
%         
%         % Swap 1st column and second column.
%         tmp = dataTmp(:,1);
%         dataTmp(:,1) = dataTmp(:,2);
%         dataTmp(:,2) = tmp;
%         
%         % Assign Condition (Simulation: 2).
%         dataTmp(:,3) = 2;
%         
%         % Get subjectID and assign it.
%         subjectID = split(fileName,'/');subjectID = subjectID{end};
%         subjectID = split(subjectID,'_');subjectID = subjectID{1};
%         subjectID = str2num(subjectID);
%         dataTmp(:,4) = subjectID;
%         
%         if i==1
%             dataSim = dataTmp;
%         else
%             dataSim = vertcat(dataSim,dataTmp);
%         end
%     end   
    
% Concatenate Dataset.
% data = [dataEmp;dataSim];
data = [dataEmp];
 
% Generate QP plot.
i=0;

% Get points.
% [perc1,rtQ1,errx1,erry1] = quantProbPlotOnePoint(dataSim);
[perc2,rtQ2,errx2,erry2] = quantProbPlotOnePoint(dataEmp);
[perc,rtQ,errx,erry] = quantProbPlotOnePoint(data);
close all;

% plot(perc1(1+size(rtQ1,2)/2:1+size(rtQ1,2)/2),rtQ1(:,1+size(rtQ1,2)/2:1+size(rtQ1,2)/2)','bx','MarkerSize',16,'LineWidth',1.5,'MarkerEdgeColor','k'); hold on;
% plot(perc2(1+size(rtQ2,2)/2:end),rtQ2(:,1+size(rtQ2,2)/2:end)','bx','MarkerSize',16,'LineWidth',1.5); hold on;


%%% Right Figure Only%%%

% Emperical
h1 = plot(perc(1+size(rtQ,2)/2:1+size(rtQ,2)/2),rtQ(:,1+size(rtQ,2)/2:1+size(rtQ,2)/2)','bx','MarkerSize',16,'LineWidth',1.5,'MarkerEdgeColor','k'); hold on;
% Simulated
% h2 = plot(perc(end:end),rtQ(:,end:end)','bx','MarkerSize',16,'LineWidth',1.5,'MarkerEdgeColor','r'); hold on;
% Line
%h3 = plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','b-','MarkerSize',16,'LineWidth',1); hold on;
% legend([h1(1) h2(1)],'Emperical','Simulated','Location','bestoutside');
legend(h1(1),'Emperical','Location','bestoutside');
ylabel('Reaction Time (sec)');
xlabel('Response Probability');
ylim([0.35,0.65])
xlim([-0.05,1.05])
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/Right_',Condition,'.fig'));
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/Right_',Condition,'.jpg'));
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/Right_',Condition,'.png'));close all;



%%%%%%%%%%%%%
% Left
% Emperical
h4 = plot(errx2,erry2,'gx','Color','k','MarkerSize',16,'LineWidth',1.5); hold on;
% Simulated
% h5 = plot(errx1,erry1,'gx','Color','r','MarkerSize',16,'LineWidth',1.5); hold on;
% Line
%h6 = plot(errx,erry,'g-','Color', 'b','MarkerSize',16,'LineWidth',1); hold on; %,'Color',[112 128 144]/255
% legend([h4(1) h5(1)],'Emperical','Simulated','Location','bestoutside');
legend(h4(1),'Emperical','Location','bestoutside');
ylabel('Reaction Time (sec)');
xlabel('Response Probability');
ylim([0.35,0.65])
xlim([-0.05,1.05])
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/Left_',Condition,'.fig'));
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/Left_',Condition,'.jpg'));
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/Left_',Condition,'.png'));close all;


%% Both of them
h1 = plot(perc(1+size(rtQ,2)/2:1+size(rtQ,2)/2),rtQ(:,1+size(rtQ,2)/2:1+size(rtQ,2)/2)','bx','MarkerSize',16,'LineWidth',1.5,'MarkerEdgeColor','k'); hold on;
% h2 = plot(perc(end:end),rtQ(:,end:end)','bx','MarkerSize',16,'LineWidth',1.5,'MarkerEdgeColor','r'); hold on;
%h3 = plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','b-','MarkerSize',16,'LineWidth',1); hold on;
h4 = plot(errx2,erry2,'gx','Color','k','MarkerSize',16,'LineWidth',1.5); hold on;
% h5 = plot(errx1,erry1,'gx','Color','r','MarkerSize',16,'LineWidth',1.5); hold on;
%h6 = plot(errx,erry,'g-','Color', 'b','MarkerSize',16,'LineWidth',1); hold on; %,'Color',[112 128 144]/255
% legend([h1(1) h2(1)],'Emperical','Simulated','Location','bestoutside');
legend(h1(1),'Emperical','Location','bestoutside');
ylabel('Reaction Time (sec)');
xlabel('Response Probability');
ylim([0.35,0.65])
xlim([-0.05,1.05])
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/All_',Condition,'.fig'));
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/All_',Condition,'.jpg'));
saveas(gcf,strcat('./figure7_median_emp_only/',Condition,'_/All_',Condition,'.png'));close all;

end

