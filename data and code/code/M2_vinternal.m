function [V,R_s,codor,R_c,eta]=M2_vinternal(odor, stimulus, params,poto)
%===================================================================
% Update the internal value of the aversive or appetitive stimulus.
% R_s is the internal representation of the shock
% R_c is the odor stimuli
% V is the synaptic weight
% codor is the odor trace
% eta is the learning rate
%===================================================================
[~,onum]=size(odor);
for i=1:onum
    if size(odor{i})~=size(stimulus) 
        error('The sizes of the two stimuli do not match.')
    end
end

[cond,t]=size(stimulus);
V=cell(1,onum);
for j=1:onum
    V{j}=zeros(cond,t);
end

Rs=params(6)*log(stimulus/params(4));
Rs(isinf(Rs))=0;

 
dRs=zeros(size(Rs));
eta=params(1)*ones(size(Rs));
dRs(:,2:end)=Rs(:,2:end)-Rs(:,1:(end-1));
dRs(dRs<0)=0;

ts=1:t;

if poto==1

    R_s=Rs;
    odor_s=cell(1,onum);
    for i=1:onum
        odort=convn(exp(-(ts-1)/params(5)),odor{i});
        odor_s{i}=(1/params(5))*odort(:,1:t);
    end
    R_c=odor;
    codor=odor_s;

end



for j=1:onum
    for i=1:t-1        
        
        eta(:,i+1)=eta(:,i)+(params(1)-eta(:,i))/params(2)+params(3)*dRs(:,i+1)/params(2);

        V{j}(:,i+1)=V{j}(:,i)+eta(:,i+1).*(R_s(:,i)-V{j}(:,i).*R_c{j}(:,i)).*codor{j}(:,i);

    end
end

end