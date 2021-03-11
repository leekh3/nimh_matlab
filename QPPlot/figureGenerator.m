function figureGenerator(data,Condition)
i=0;

close all;
quantProbPlot(data)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',0,'reverse',0,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',1,'reverse',1,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',0)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',1,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',0,'reverse',1,'condLabel',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',0,'reverse',0,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
quantProbPlot(data,'separate',2,'reverse',0,'condLabel',0,'scatterPlot',1)
saveas(gcf,strcat('figure/',Condition,'/',string(i),'.png'));i=i+1;close all;
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