function stimuli_ss=stimulus_repetition(repnum,shockap,mode,dt)
%======================================
% Repetition training 
%======================================
odort=[90,150,180,240];
odort=odort/dt;
ds=1.5;
shockt=[105,120,135,150]-ds;
shockt=shockt/dt;
dshock=ds/dt;
shcond=length(shockap);

odorx_s=zeros(1,shcond,odort(end));
odory_s=zeros(1,shcond,odort(end));
shock_s=zeros(1,shcond,odort(end));

odorx_s(1,:,odort(1)+1:odort(2))=1;
odory_s(1,:,odort(3)+1:odort(4))=1;
for i=1:shcond
    for j=1:length(shockt)
        shock_s(1,i,(shockt(j)+1):(shockt(j)+dshock))=shockap(i);
    end
end

maxrep=max(repnum);
repcond=length(repnum);
odorx_sr=zeros(repcond,shcond,maxrep*odort(end));
odory_sr=odorx_sr;
shock_sr=odorx_sr;
for i=1:repcond
    if repnum(1)==0.5
        repnum(1)=1;
        shock_s1=shock_s;
        shock_s1(1,:,1:(shockt(2)+dshock))=0;
    else
        shock_s1=shock_s;
    end
    t_stimu=(maxrep-repnum(i))*odort(end)+1;
    odorx_sr(i,:,t_stimu:end)=repmat(odorx_s,[1,1,repnum(i)]);
    odory_sr(i,:,t_stimu:end)=repmat(odory_s,[1,1,repnum(i)]);
    shock_sr(i,:,t_stimu:end)=repmat(shock_s1,[1,1,repnum(i)]);
end
odorx_sr=reshape(odorx_sr,repcond*shcond,maxrep*odort(end));
odory_sr=reshape(odory_sr,repcond*shcond,maxrep*odort(end));
shock_sr=reshape(shock_sr,repcond*shcond,maxrep*odort(end));

odor_test=zeros(repcond*shcond,360/dt);
shock_test=odor_test;
odor_test(:,end)=1;
odorx_sr=cat(2,odorx_sr,odor_test);
odory_sr=cat(2,odory_sr,odor_test);
shock_sr=cat(2,shock_sr,shock_test);
size_sr=size(shock_sr);
ap_sr=zeros(size_sr);


%repeat s experiments
if mode==0
    stimuli_ss={odorx_sr,odory_sr;shock_sr,ap_sr};

    

end
