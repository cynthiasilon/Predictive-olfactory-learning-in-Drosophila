function data=datacount(filename,sheetname,tagname,tagpos,datarange,condname,cond)

sheetnum=length(sheetname);
data=cell(sheetnum*cond,1);
cols=datarange(2)-datarange(1)+1;
condnum=0;
for k=1:sheetnum
    [~,~,dataraw]=xlsread(filename,sheetname{k});
    [r,~]=size(dataraw);
    for i=1:r
        if strcmp(dataraw{i,tagpos},condname)
            condnum=condnum+1;
        end
        if strcmp(dataraw{i,tagpos},tagname)
            numdata=cell2mat(dataraw(i,datarange(1):datarange(2)));
            if sum(isnan(numdata))==cols
                continue
            else
                numdata(isnan(numdata))=0;
                data{condnum}=cat(1,data{condnum},numdata);
            end
        end
    end
end

                
end

        


