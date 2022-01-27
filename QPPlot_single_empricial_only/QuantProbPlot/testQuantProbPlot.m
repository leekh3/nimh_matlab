%play with prob plot
clear;
a=0.16;
b=-0.16;
z=0;
sz=0;
vv=[0.02 0.05 0.1];
st=0; Ter=0; eta=0; c=0.1;
numTr=1000;
quantData=[]; 

for subj=1:1
for i=1:length(vv)
    v=vv(i);
    data{i}=diffProcessCLEAN(...
        'numTr',numTr,...
        'a',a,...
        'b', b,...
        'z',z,...
        'sz', sz,...
        'v', v,...
        'Ter', Ter,...
        'st', st,...
        'eta', eta,...
        'c',c,...
        'tau',0.0005,...
        'maxWalk',600);
    rt{i}=data{i}(:,1);
    quantData=[quantData; data{i}(:,1) data{i}(:,2) repmat(i,numTr,1) repmat(subj,numTr,1)];
end 
end

quantProbPlot(quantData,'separate',0,'reverse',0,'condLabel',0)
quantProbPlot(quantData,'separate',0,'reverse',0,'condLabel',1)
quantProbPlot(quantData,'separate',2,'reverse',0,'condLabel',0)
quantProbPlot(quantData,'separate',1,'reverse',1,'condLabel',0)
quantProbPlot(quantData,'separate',2,'reverse',0,'condLabel',0)
quantProbPlot(quantData,'separate',2,'reverse',1,'condLabel',0)
quantProbPlot(quantData,'separate',2,'reverse',1,'condLabel',1)
quantProbPlot(quantData,'separate',0,'reverse',1,'condLabel',1)
quantProbPlot(quantData,'separate',0,'reverse',0,'condLabel',0,'scatterPlot',1)
quantProbPlot(quantData,'separate',2,'reverse',0,'condLabel',0,'scatterPlot',1)
quantProbPlot(quantData,'separate',2,'reverse',1,'condLabel',0,'scatterPlot',1)
stop=1