function [perc,rtQ,errx,erry] = quantProbPlotJimmy(data)

separate=2;reverse=0;col1 = 'r';col2 = 'g';
rt=1; corr=2; con=3; subj=4;conditions=unique(data(:,con))';
scatPlot=1;avrgQuantSub=1;rt=1; corr=2; con=3; subj=4;lab=0;

conditions=unique(data(:,con))';

if (avrgQuantSub==1 && size(data,2)>=4)
    subjects=unique(data(:,subj))';
end
qq=0.1:0.2:0.9;


if (avrgQuantSub==1 && size(data,2)<4)
  warning('You indicate to average across subject, but you didn''t put the subject column!');
end
  
  
for i=1:length(conditions)
    dataCon{i}=data(find(data(:,con)==conditions(i)) ,:);
    
    %take data for this condition, for correct, for every subject and make
    %the average
    %quantile-RT calculation
    %-----------------CORRECT
    if (avrgQuantSub==1 && size(data,2)>=4)
        for ss=1:length(subjects)
            dataCCS=dataCon{i}(find(dataCon{i}(:,corr)==1 & dataCon{i}(:,subj)==subjects(ss)),:);
            rtQCCS(:,ss)=quantile(dataCCS(:,rt),qq);
        end
        rtQCOR(:,i)= nanmean(rtQCCS,2);
    end
    
    perCorr(:,i)=length(find(dataCon{i}(:,corr)==1))/length(dataCon{i}(:,corr));
    label{i}=['Cond: ' num2str(conditions(i))];
    perIncorr(:,i)=1-perCorr(:,i);
    
    
    rtAC{i}=dataCon{i}(find(dataCon{i}(:,corr)==1),rt);
    
    if (avrgQuantSub==0 || size(data,2)<4)
        rtQCOR(:,i)=quantile(rtAC{i},qq);
    end
    xxC{i}=repmat(perCorr(i),length(rtAC{i}),1);
    xxC{i}=xxC{i}+normrnd(0,0.005,length(xxC{i}),1);
    
    %----------------ERRORS
    if (avrgQuantSub==1 && size(data,2)>=4)
        for ss=1:length(subjects)
            dataCINCS=dataCon{i}(find(dataCon{i}(:,corr)==0 & dataCon{i}(:,subj)==subjects(ss)),:);
            rtQCINCS(:,ss)=quantile(dataCINCS(:,rt),qq);
        end
        rtQINC(:,i)= nanmean(rtQCINCS,2);
    end
    
    rtAINC{i}=dataCon{i}(find(dataCon{i}(:,corr)==0),rt);
    if (avrgQuantSub==0 || size(data,2)<4)
        rtQINC(:,i)=quantile(rtAINC{i},qq);
    end
    
    xxINC{i}=repmat(perIncorr(i),length(rtAINC{i}),1);
    xxINC{i}=xxINC{i}+normrnd(0,0.005,length(xxINC{i}),1);
end
stop=1;
label=[label(length(label):-1:1) label];


[perCorr,ind]=sort(perCorr);
[perIncorr, indInc]=sort(perIncorr);
%order according to correctness

rtQCORR=rtQCOR(:,ind);
rtQINC=rtQINC(:,indInc);


perc=[perIncorr perCorr];
rtQ=[rtQINC rtQCORR];

%opposite order, to make legend easy
rtA=[rtAC, rtAINC];
xx=[xxC xxINC];

sh=[];


c=get(0,'defaultAxesColorOrder'); marker='x';
if scatPlot==1
    if (separate==2 || reverse==1) col=[0.3010,0.7450,0.9330]; else col=[0.3010,0.7450,0.9330]; end;
    for i=1:size(xx,2)
        if i>(size(xx,2)/2)
            col=[0.85,0.325,0.098]; %red
            col=col1;
            marker='.';
        else
%             col=[0,0.50,0]; %red
              col=col2;
        end
        
        sh=[sh scatter(xx{i}, rtA{i}, '.','MarkerEdgeColor',col)]; hold on;% alpha(sh,.5);
    end
end

%inverse errors responses
xlim([0 1]);
errx=perc(1:size(rtQ,2)/2); erry=rtQ(:,1:size(rtQ,2)/2)'


% Blue
h1=plot(perc(1+size(rtQ,2)/2:1+size(rtQ,2)/2),rtQ(:,1+size(rtQ,2)/2:1+size(rtQ,2)/2)','bx','MarkerSize',16,'LineWidth',1.5); hold on;

h1=plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','bx','MarkerSize',16,'LineWidth',1.5); hold on;
h11 = plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','b-','MarkerSize',16,'LineWidth',1); hold on;

% Black
h2=plot(errx,erry,'gx','Color',[0 0 0],'MarkerSize',16,'LineWidth',1.5); hold on;
h22 = plot(errx,erry,'g-','Color', [0 0 0],'MarkerSize',16,'LineWidth',1); hold on; %,'Color',[112 128 144]/255
%     legend([h1(1) h2(1)],'Correct','Errors','Location','BestOutside');
grid on;

stop=1;

end