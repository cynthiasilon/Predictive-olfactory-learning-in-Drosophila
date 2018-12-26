% This is the main function 

%========================================================
% Experiment data for 28 training conditions
%========================================================
data=experiment_data();
datamean=LIstatistic(data);
    
%%
%========================================================
% Experiment protocols for 28 training conditions
% stimuli{1}{1} is the odor stimuli of odorX
% stimuli{1}{2} is the odor stimuli of odorY
% stimuli{2}{1} is the shock stimuli paired with odorX
% stimuli{2}{2} is the shock stimuli paired with odorY
%========================================================
stimuli=experiment_protocol();


%%
% Fit the model to the data with optimized parameters
% LI is the learning index
% minparams are the optimized parameters
% minerror are minimum square errors 
%=======================================
% fitting - predictive learning rule
%=======================================
ittnum=100;
paramsrag_pred=prange('p');

[minparams_pred,minerror_pred,~,~]=...
    minerrorfit(@M2_problindex,stimuli,datamean,1,paramsrag_pred,ittnum);

[ P_pred,LI_pred] = M2_problindex(1,stimuli,minparams);

%%
%=======================================
% fitting - nonlinear STDP rule 
%=======================================
paramsrag_nstdp=prange('n');

[minparams_nstdp,minerror_nstdp,~,~]=...
    minerrorfit(@Hebbian_eta,stimuli,datamean,1,paramsrag_nstdp,ittnum);

[ ~,LI_nstdp] = Hebbian_eta(1,stimuli,minparams_nstdp);

%%
%======================================
% fittling - linear STDP rule
%======================================
paramsrag_lstdp=prange('l');

[minparams_lstdp,minerror_lstdp,~,~]=...
    minerrorfit(@Hebbian_eta,stimuli,datamean,2,paramsrag_lstdp,ittnum);

[ ~,LI_lstdp] = Hebbian_eta(2,stimuli,minparams_lstdp);

%%
%======================================
% fittling - covariance rule
%======================================
paramsrag_cov=prange('c');

[minparams_cov,minerror_cov,~,~]=...
    minerrorfit(@Hebbian_eta,stimuli,datamean,3,paramsrag_cov,ittnum);

[ ~,LI_cov] = Hebbian_eta(3,stimuli,minparams_cov);

%%
%======================================
% fittling - additive Hebbian rule
%======================================
paramsrag_hebb=prange('h');

[minparams_hebb,minerror_hea,~,~]=...
    minerrorfit(@Hebbian_eta,stimuli,datamean,0,paramsrag_hebb,ittnum);

[ ~,LI_hebb] = Hebbian_eta(0,stimuli,minparams_hebb);

