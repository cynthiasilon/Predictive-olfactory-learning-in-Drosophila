function [minparams,minerror,itparams,iterror]=minerrorfit(funcname,stimuli,lindexexp,poto,paramsrag,iternum)
%======================================================
% Optimize the model parameters for least squrae error
%======================================================
[paramnum,~]=size(paramsrag);
params0=zeros(iternum,paramnum);
minerror=1.0e+10;
minparams=zeros(1,paramnum);
itparams=zeros(iternum,paramnum);
iterror=zeros(iternum,1);
for j=1:paramnum
    params0(:,j)=paramsrag(j,1)+(paramsrag(j,2)-paramsrag(j,1))*rand(iternum,1);
end


for i=1:iternum
    disp([i,params0(i,:)]);
    [params,lserror]=lindexls(funcname,stimuli,lindexexp,params0(i,:),paramsrag,poto);
    
    if lserror<minerror
        minerror=lserror;
        minparams=params;
    end
    itparams(i,:)=params;
    iterror(i)=lserror;
    
    disp([lserror,params]);
    disp([minerror,minparams]);
end
end
