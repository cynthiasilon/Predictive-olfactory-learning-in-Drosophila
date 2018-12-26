function [x,errorval]=lindexls(lindex,stimuli,lindexexp,params0,paramsrag,poto)
%============================================================
% Objective function for least square error of learning index 
%============================================================
lb=paramsrag(:,1);
ub=paramsrag(:,2);
options=optimset('Algorithm','interior-point');
[x,errorval]=fmincon(@lindexlsobj,params0,[],[],[],[],lb,ub,[],options);
    function f=lindexlsobj(params)
        
        [~,lindexmod]=lindex(poto,stimuli,params);  %learning index   
        
        f=sum((lindexmod(:,end)'-lindexexp).^2);   %least square error
        
    end

end

