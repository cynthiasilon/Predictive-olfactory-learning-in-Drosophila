function [tmean,tstd,wmean,wstd,wsem]=LIstatistic(data)

cdata=length(data);
wmean=zeros(2,cdata);
wstd=zeros(2,cdata);
wsem=zeros(2,cdata);
tmean=zeros(1,cdata);
tstd=zeros(1,cdata);
for i=1:cdata
    data_s=data{i}(1:2:end,1:2);
    data_r=data{i}(2:2:end,3:4);
    num_s=data_s(:,1)+data_s(:,2);
    total_s=sum(num_s);
    num_r=data_r(:,1)+data_r(:,2);
    total_r=sum(num_r);
    wdata_s=(data_s(:,2)-data_s(:,1))./num_s;
    wdata_r=(data_r(:,1)-data_r(:,2))./num_r;
    wmean(1,i)=sum((num_s./total_s).*wdata_s);
    wstd(1,i)=sqrt(sum((num_s./total_s).*((wdata_s-wmean(1,i)).^2)));
    wsem(1,i)=wstd(1,i)/size(data{i},1);
    wmean(2,i)=sum((num_r./total_r).*wdata_r);
    wstd(2,i)=sqrt(sum((num_r./total_r).*((wdata_r-wmean(2,i)).^2)));
    wsem(2,i)=wstd(2,i)/sqrt(size(data{i},1));
    tmean(1,i)=1/2*(mean(wdata_s)+mean(wdata_r));
    tstd(1,i)=std([wdata_s;wdata_r]);    
end