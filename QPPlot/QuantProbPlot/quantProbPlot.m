%QUANTILE PROBABILITY PLOTS (as explained in Ratcliff, 2001) or in my
%website, https://biscionevalerio.wordpress.com/author/biscionevalerio/
%
%The best explanation I could find is contained in Simen et al.(2009):
%
%QPP provide a compact form of representation for RT and accuracy data
%across multiple conditions. In a QPP quantiles of a distribution of RTs of
%a particular type (e.g., crrect responses) are plotted as a function of
%proportion of responses of that type: thus, a vertical column of N markers
%would be centered above the position 0.8 if N quantiles were computed from
%the correct RTs in a task condition in which accuracy was 80%). The ith
%quantile of each distribution is then connected by a line to the ith quantiles of othe
%distribution. 

%Simen P., Contreras D., Buck C., Hu P., Holmes P., Cohen J. 2009. 
%Reward Rate Optimization in Two-Alternative Decision Making: Empirical
%Tests of Theoretical Predictions. Journal of Experimental Psychology:
%Human Perception and Performance. Vo.. 35, No. 6, 1865-1897. 


%The data have to be organized as follow:
%column1=data (ex. Reaction time), col2=corr (1 or 0), col3=condition (an be
%any float number and does not have to be in order)
%Most of the time (but not always) you may want to have multiple subjects. In that
%case you may want to average the quantile across subjects. In this case you have
%to specify another column (4th column) for the subject number (any
%integer). This is the default behaviour, specified by avrgQuantSub. If you
%don't want to have this behaviour, set the avrgQuantSub to 0. The fourth
%column will just be ignored. 

%There are a lot of different parameters. For a complete explanation with
%example please visit my website,
%https://biscionevalerio.wordpress.com/author/biscionevalerio/)
function quantProbPlot(data,varargin)
p=inputParser;
addParamValue(p, 'scatterPlot', 0); %indicates if you want to plot the scatter plot or not
addParamValue(p, 'condLabel',0);
%if you have multiple subject and want to average the quantiles across
%subject, put this to 1 (the dataset need another column (4th) with
%the subject number)
%if this is 1 and you don't have a forth column, this will be ignored.
addParamValue(p, 'avrgQuantSub',1);
%1=if you want to separate errors from correct in two subplots
%2=if you want everything in the same plot, but with different line
%(one for correct, one for errors)
addParamValue(p, 'separate',0);
%if reverse ==0 use the normal QP, otherwise reverse the error so that they
%are aligned with the corret response. (separate has to be 1 or 2 for this
%to work)
addParamValue(p, 'reverse',0);
parse(p,varargin{:});
avrgQuantSub=p.Results.avrgQuantSub;
%datProc=load('datProc.mat'); data=datProc.datProc(:,4:6);
%dataProc=load('dataTOT.mat'); data=dataProc.dataTOT;
scatPlot=p.Results.scatterPlot;
lab=p.Results.condLabel;
separate=p.Results.separate;
reverse=p.Results.reverse;
rt=1; corr=2; con=3; subj=4;
figure();
conditions=unique(data(:,con))';

if (avrgQuantSub==1 && size(data,2)>=4)
    subjects=unique(data(:,subj))';
end
qq=0.1:0.2:0.9;

if reverse==1 && separate==0
    warning(['You set "reverse" to 1, but reverse only makes sense if "separate" is >0. Change separate to use reverse']);
    reverse=0;
end 

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
    %  rtQINC(:,i)=quantile(rtAINC{i},qq);
    if reverse==0
        xxINC{i}=repmat(perIncorr(i),length(rtAINC{i}),1);
    else
        xxINC{i}=repmat(perCorr(i),length(rtAINC{i}),1);
    end
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

if separate==1
    subplot(1,2,2);
end

c=get(0,'defaultAxesColorOrder'); marker='x';
if scatPlot==1
    if (separate==2 || reverse==1) col=c(6,:); else col='b'; end;
    for i=1:size(xx,2)
        if i>(size(xx,2)/2)
            col=[1 0 0]; %red
            marker='o';
            if separate==1
                subplot(1,2,1);
            end
        end
        
        sh=[sh scatter(xx{i}, rtA{i}, marker,'MarkerEdgeColor',col)]; hold on;% alpha(sh,.5);
    end
end

if separate==1
    pp=get(gcf,'Position');
    set(gcf,'Position', [pp(1)  pp(2) pp(3)+350 pp(4)]);
end

%inverse errors responses
if reverse==1
    errx=perc(1+size(rtQ,2)/2:end); erry=fliplr(rtQ(:,1:size(rtQ,2)/2))';
else
     xlim([0 1]);
    errx=perc(1:size(rtQ,2)/2); erry=rtQ(:,1:size(rtQ,2)/2)'
end

if separate==0
    plot(perc,rtQ','kx','MarkerSize',16,'LineWidth',1.5); hold on;
    plot(perc,rtQ','k-','MarkerSize',16,'LineWidth',1); hold on;
    xlim([0 1]);
     grid on;
elseif separate==1
    sb1=subplot(1,2,2); 
    plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','kx','MarkerSize',16,'LineWidth',1.5); hold on;
    plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','k-','MarkerSize',16,'LineWidth',1); hold on;
    if lab==1, axh=gca;  axh.XTick=perc; axh.XTickLabel=label; axh.XTickLabelRotation=45; end
    grid on;
    sb2=subplot(1,2,1); 
    plot(errx,erry,'kx','MarkerSize',16,'LineWidth',1.5); hold on;
    plot(errx,erry,'k-','MarkerSize',16,'LineWidth',1); hold on;
    maxY=maxC([get(sb1,'YLim') get(sb2,'YLim')]); subplot(1,2,1); y1=get(sb1,'YLim');ylim([y1(1) maxY]);
    grid on;
    if lab==1, axh=gca;  axh.XTick=perc; axh.XTickLabel=label; axh.XTickLabelRotation=45; end;
     subplot(1,2,2); y2=get(sb2,'YLim'); ylim([y2(1) maxY]);
elseif separate==2
    h1=plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','bx','MarkerSize',16,'LineWidth',1.5); hold on;
    plot(perc(1+size(rtQ,2)/2:end),rtQ(:,1+size(rtQ,2)/2:end)','b-','MarkerSize',16,'LineWidth',1); hold on;
    h2=plot(errx,erry,'gx','Color',[0 0 0],'MarkerSize',16,'LineWidth',1.5); hold on;
    plot(errx,erry,'g-','Color', [0 0 0],'MarkerSize',16,'LineWidth',1); hold on; %,'Color',[112 128 144]/255
    legend([h1(1) h2(1)],'Correct','Errors','Location','BestOutside');
   grid on;
end

if lab==1 && (separate==0 || separate==2)
    axh=gca;  axh.XTick=perc; axh.XTickLabel=label; axh.XTickLabelRotation=45;
end 
%{
if ~iscell(leg) && leg==1
    legend(sh,cellfun(@num2str, num2cell(1:length(perCorr)),'un',0),'Location', 'Best'); grid on;
elseif iscell(leg)
    legend(sh,leg,'Location', 'Best'); grid on;
end
%}

stop=1;
%}