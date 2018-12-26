function alldata=experiment_data()

%===============================================
% read out the raw data
%===============================================
data_c25=datacount('../data/Constant voltage120s-25V.xls',{'F1'},'total',3,[4,7],'gender',7);

data_c50=datacount('../data/Constant voltage120s-50V.xls',{'F1'},'total',3,[4,7],'gender',7);

data_se=datacount('../data/Shockend2.xls',{'Sheet1','Sheet2','Sheet3','Sheet4'},'total',3,[4,7],'gender',1);

data_sb=datacount('../data/Shockbeg.xls',{'Sheet1','Sheet2','Sheet3','Sheet4'},'total',3,[4,7],'gender',1);

data_r25=datacount('../data/repeat25V2.xls',{'0.5','1','2','4'},'total',3,[4,7],'gender',1);

data_r50=datacount('../data/repeat50V2.xls',{'0.5','1','2','4'},'total',3,[4,7],'gender',1);

%=================================================
ordor25=[6,5,1,2,3,4];
ordor50=[6,5,4,1,3,2];
data_c25o={};
data_c50o={};
notemp=0;
i=1;
while i<=7
      if ~ isempty(data_c25{i})
          notemp=notemp+1;
          data_c25o=cat(1,data_c25o,data_c25{i});
      end
      i=i+1;
end
data_c25o=data_c25o(ordor25);
notemp=0;
i=1;
while i<=7
      if ~ isempty(data_c50{i})
          notemp=notemp+1;
          data_c50o=cat(1,data_c50o,data_c50{i});
      end
      i=i+1;
end
data_c50o=data_c50o(ordor50);

%===========================================================
% alldata include 28 experimental conditions
%============================================================
data={data_se,data_sb,data_r25,data_r50,data_c25o,data_c50o};
alldata={};
for i=1:length(data)
    alldata=cat(1,alldata,data{i});
end

end