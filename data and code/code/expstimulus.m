function stimuli=expstimulus(poto,dt)
%==========================================
% shock at beginning and end experiment
%==========================================
t=600;
dshock=1.5;
ot=[90,150,180,240,600];
n=ot/dt;
st=[7.5,15,22.5,30,37.5,45,52.5,60];
nst_b=(st-dshock)/dt;
nst_e=st/dt;
lsn=length(st);
shockap_s=[100,50,25,12.5];
shocknum=[8,4,2,1];
condnum=length(shocknum);
shockbeg=zeros(condnum,n(end));
shockend=zeros(condnum,n(end));
odorx_s=zeros(2*condnum,n(end));
odory_s=zeros(2*condnum,n(end));
odorx_s(:,n(1)+1:n(2))=1;
odory_s(:,n(3)+1:n(4))=1;
odorx_s(:,end)=1;
odory_s(:,end)=1;

for i=1:condnum
    sn=lsn/shocknum(i);
    endnst_b=nst_b(lsn:-shocknum(i):1);
    endnst_e=nst_e(lsn:-shocknum(i):1);
    begnst_b=nst_b(1:shocknum(i):lsn);
    begnst_e=nst_e(1:shocknum(i):lsn);
    for j=1:sn
        shockend(i,(n(1)+endnst_b(j)+1):(n(1)+endnst_e(j)))=shockap_s(i);        
        shockbeg(i,(n(1)+begnst_b(j)+1):(n(1)+begnst_e(j)))=shockap_s(i);
    end
end

shockcond_s=cat(1,shockend,shockbeg);


%=================================================
%continuous shock experiment
%=================================================
st_c=[120,90,45,30,15,10];
sna_c=round((st_c+90)/dt);
snb_c=round((2*st_c+120)/dt);
shockap_c=[25,50];
lst=length(st_c);
lsap=length(shockap_c);
odorx_c=zeros(lst*lsap,t/dt);
odory_c=zeros(lst*lsap,t/dt);
odorx_c(:,end)=1;
odory_c(:,end)=1;

shockcond_c=zeros(lst*lsap,t/dt);
for i=1:lsap
    for j=1:lst
        odorx_c(lst*(i-1)+j,1+90/dt:sna_c(j))=1;
        odory_c(lst*(i-1)+j,1+30/dt+sna_c(j):snb_c(j))=1;
        shockcond_c(lst*(i-1)+j,1+90/dt:sna_c(j))=shockap_c(i);
    end
end


%protocols

if poto==1 % our experiment
    shockcond=shockcond_s;
    odorx=odorx_s;
    odory=odory_s;
elseif poto==2 %continuous shock experiment
    odorx=odorx_c;
    odory=odory_c;
    shockcond=shockcond_c;
elseif poto==3 % s+c
    odorx=cat(1,odorx_s,odorx_c);
    odory=cat(1,odory_s,odory_c);
    shockcond=cat(1,shockcond_s,shockcond_c);

end
[allcond,alltlength]=size(shockcond);
apcond=zeros(allcond,alltlength);

stimuli={odorx,odory;shockcond,apcond};


end