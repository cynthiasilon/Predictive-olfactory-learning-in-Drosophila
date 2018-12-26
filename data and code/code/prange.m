function paramsrag=prange(poto)

if poto=='p'
    paramsrag=[0,0;0,100;0,100;0,12.5;0,100;0,10];
elseif poto=='n'
    paramsrag=[1,200;0,10;1,200;1,200;0,12.5;1,200;0,10;0,10;0,10;0,10];
elseif poto=='l'
    paramsrag=[1,200;0,10;1,200;1,200;0,12.5;0,200;0,10;0,10];
elseif poto=='c'
    paramsrag=[1,200;0,10;1,200;1,1000;0,12.5;0,10];
elseif poto=='h'
    paramsrag=[1,200;0,10;1,200;1,200;0,12.5;0,10];
end

end
