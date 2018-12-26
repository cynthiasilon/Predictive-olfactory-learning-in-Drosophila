function [ P,lindex,V,w ] = M2_problindex(poto,stimuli,params)
%============================================================
% Decision probability and learning index for logisitic model
% P is the avoidance probability
% lindex is the learning index
%============================================================
try
if nnz(params<0)>0
    params=abs(params);
end
odor=stimuli(1,:);
stimulus=stimuli(2,:);
[~,snum]=size(stimulus);
V=cell(snum,1);
w=cell(snum,2);
V_odor=cell(snum,2);

catch
    warning('There are errors.');
    disp(params)
end

for i=1:snum
    [v,~]=M2_vinternal(odor,stimulus{i}, params,poto);
    V{i}=v{1}.*odor{1}-v{2}.*odor{2};
    w{i,1}=v{1};
    w{i,2}=v{2};
    V_odor{i,1}=v{1}.*odor{1};
    V_odor{i,2}=v{2}.*odor{2};
end


lindex=tanh((V{1}-V{2})/2);
P=(1+lindex)/2;


if ~all(isfinite(P))
    warning('There are NaNs');
    disp(params);
    disp(P)
end



end