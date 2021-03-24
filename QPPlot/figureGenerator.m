function figureGenerator(data,Condition)
i=0;

close all;
%0
quantProbPlot(data)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%1
quantProbPlot(data,'separate',0,'reverse',0,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%2
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%3
quantProbPlot(data,'separate',1,'reverse',1,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%4
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%5
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%6
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',1) %Original
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%7
quantProbPlot(data,'separate',0,'reverse',1,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%8
quantProbPlot(data,'separate',0,'reverse',0,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%9
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0,'scatterPlot',1)

quantProbPlot(dataEmp,'separate',2,'reverse',0,'condLabel',0,'scatterPlot',1)

saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
%10
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;

i = 0;
quantProbPlot(data)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',0,'reverse',0,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',1,'reverse',1,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',0,'reverse',1,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',0,'reverse',0,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.fig'));i=i+1;close all;



end