% Correlation rules
function [ P,lindex,V,w,cRs,codor] = Hebbian_eta(poto,stimuli,params)

if nnz(params<0)>0
    params=abs(params);
end

odor=stimuli(1,:);
stimulus=stimuli(2,:);
[~,snum]=size(stimulus);
[~,onum]=size(odor);
[cond,t]=size(stimulus{1,1});


Rs=cell(1,snum);
cRs=cell(1,snum);
dRs=cell(1,snum);
for i=1:snum
    rs=params(2)*log(stimulus{i}/params(5));
    rs(isinf(rs))=0;    
    Rs{1,i}=rs;
    cRs{i}=zeros(cond,t);
    drs=zeros(size(rs));
    drs(:,2:end)=rs(:,2:end)-rs(:,1:(end-1));
    drs(drs<0)=0;
    dRs{1,i}=drs;
end


codor=cell(1,onum);
for j=1:onum
    codor{j}=zeros(cond,t);
end

w=cell(snum,onum);
for k=1:snum
    for j=1:onum
        w{k,j}=zeros(cond,t);
    end
end
v=w;
V=cell(1,onum);

for j=1:onum
    for i=2:t
        codor{j}(:,i)=(1-1/params(3))*codor{j}(:,i-1)+odor{j}(:,i)/params(3);
    end

end

for k=1:snum
    for i=2:t
        cRs{1,k}(:,i)=(1-1/params(4))*cRs{1,k}(:,i-1)+Rs{1,k}(:,i)/params(4);
    end
end
%==========================================
% STDP linear
%==========================================
if poto==1
    for j=1:onum
        for  k=1:snum
            eta1=zeros(size(Rs{k}));
            eta2=zeros(size(Rs{k}));
            for i=2:t                
                eta1(:,i)=eta1(:,i-1)-eta1(:,i-1)/params(1)+params(9)*dRs{k}(:,i);
                eta2(:,i)=eta2(:,i-1)-eta2(:,i-1)/params(6)+params(10)*dRs{k}(:,i);
                w{k,j}(:,i)=w{k,j}(:,i-1)+eta1(:,i).*tanh(params(7)*Rs{k}(:,i).*codor{j}(:,i))...
                -eta2(:,i).*tanh(params(8)*cRs{k}(:,i).*odor{j}(:,i));
            end
            v{k,j}=w{k,j}.*odor{j};
        end
        V{j}=v{1,j}-v{2,j};
    end
%==========================================
% STDP nonlinear
%==========================================
elseif poto==2
    for j=1:onum
        for k=1:snum
            eta1=zeros(size(Rs{k}));
            eta2=zeros(size(Rs{k}));
            for i=2:t
                eta1(:,i)=eta1(:,i-1)-eta1(:,i-1)/params(1)+params(7)*dRs{k}(:,i);
                eta2(:,i)=eta2(:,i-1)-eta2(:,i-1)/params(6)+params(8)*dRs{k}(:,i);
                w{k,j}(:,i)=w{k,j}(:,i-1)+eta1(:,i).*Rs{k}(:,i).*codor{j}(:,i)...
                    -eta2(:,i).*cRs{k}(:,i).*odor{j}(:,i);
            end
            v{k,j}=w{k,j}.*odor{j};
        end
        V{j}=v{1,j}-v{2,j};
    end
%===================================
% covariance
%===================================
elseif poto==3
    for j=1:onum
        for k=1:snum
            eta1=zeros(size(Rs{k}));
            for i=2:t
                eta1(:,i)=eta1(:,i-1)-eta1(:,i-1)/params(1)+params(6)*dRs{k}(:,i);
                w{k,j}(:,i)=w{k,j}(:,i-1)+eta1(:,i).*(Rs{k}(:,i)-cRs{k}(:,i)).*(odor{j}(:,i)-codor{j}(:,i));
            end
            v{k,j}=w{k,j}.*odor{j};
        end
        V{j}=v{1,j}-v{2,j};
    end
%====================================
% Hebbian
%====================================
elseif poto==0
    for j=1:onum
        for k=1:snum
            eta1=zeros(size(Rs{k}));
            for i=2:t
                eta1(:,i)=eta1(:,i-1)-eta1(:,i-1)/params(1)+params(6)*dRs{k}(:,i);
                w{k,j}(:,i)=w{k,j}(:,i-1)+eta1(:,i).*Rs{k}(:,i).*codor{j}(:,i);
            end
            v{k,j}=w{k,j}.*odor{j};
        end
        V{j}=v{1,j}-v{2,j};
    end
end
                

lindex=tanh((V{1}-V{2})/2);
P=(1+lindex)/2;    
                
    

end
