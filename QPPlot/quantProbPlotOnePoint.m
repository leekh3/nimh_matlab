function [perc,rtQ,errx,erry] = quantProbPlotOnePoint(data)

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
        rtQCOR(:,i)= nanmedian(rtQCCS,2); %%%%%
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
        rtQINC(:,i)= nanmedian(rtQCINCS,2); %%%%
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

xxLength = size(xx);
if xxLength(2) == 4
    perc = [median(xx{4}) median(xx{3}) median(xx{1}) median(xx{2})]; %perc
    rtQ = [median(rtA{4}) median(rtA{3}) median(rtA{1}) median(rtA{2})]; %rtQ
    errx = [median(xx{4}) median(xx{3})]; %errx
    erry = [median(rtA{4}) median(rtA{3})]; %erry
else
    perc = [median(xx{2}) median(xx{1})]; %perc
    rtQ = [median(rtA{2}) median(rtA{1})]; %rtQ
    errx = [median(xx{2})]; %errx
    erry = [median(rtA{2})]; %erry
end

end