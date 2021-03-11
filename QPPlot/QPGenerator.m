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

clear;clc;
Conditions = ["CON","NEU","INC"];
addpath('./QuantProbPlot');

for j=1:length(Conditions)
    Condition = Conditions(j);
    
    % Load Emperical Dataset.
    P = './EmpericalData_Organized/';
    S = dir(fullfile(P,strcat('*',Condition,'.dat')));
    N = {S.name};

    for i=1:length(N)
        fileName = strcat(P,N{1,i});
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
        
        if i==1
            dataEmp = dataTmp;
        else
            dataEmp = vertcat(dataEmp,dataTmp);
        end
    end

    
    % Load Simulated dataset.
    P = './SimulationData_Organized/';
    S = dir(fullfile(P,strcat('*',Condition,'.dat')));
    N = {S.name};

    for i=1:length(N)
        fileName = strcat(P,N{1,i});
        dataTmp = readmatrix(fileName);
        
        % Swap 1st column and second column.
        tmp = dataTmp(:,1);
        dataTmp(:,1) = dataTmp(:,2);
        dataTmp(:,2) = tmp;
        
        % Assign Condition (Simulation: 2).
        dataTmp(:,3) = 2;
        
        % Get subjectID and assign it.
        subjectID = split(fileName,'/');subjectID = subjectID{end};
        subjectID = split(subjectID,'_');subjectID = subjectID{1};
        subjectID = str2num(subjectID);
        dataTmp(:,4) = subjectID;
        
        if i==1
            dataSim = dataTmp;
        else
            dataSim = vertcat(dataSim,dataTmp);
        end
    end   
    
    % Concatenate Dataset.
    data = [dataEmp;dataSim];
 
    % Generate QP plot.
    figureGenerator(data,Condition)
    
    close all;
    
end

    




