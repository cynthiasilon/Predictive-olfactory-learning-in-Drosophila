function combine_stimuli=experiment_protocol()
%======================================================
% Training protocol for different conditions 
%======================================================
shockap_r=[25,50];
repnum=[0.5,1,2,4];

stimuli_c=expstimulus(2,1.5);  
stimuli_s=expstimulus(1,1.5); 
stimuli_reps=stimulus_repetition(repnum,shockap_r,0,1.5); 

experiments={stimuli_s, stimuli_reps,stimuli_c};

n=3;
stimu_len=zeros(1,n);
stimu_cond=zeros(1,n);
for i=1:n
    [stimu_cond(i),stimu_len(i)]=size(experiments{i}{1,1});
end
totalcond=sum(stimu_cond);
maxlen=max(stimu_len);
s_cond=[0 cumsum(stimu_cond)];
s_len=maxlen-stimu_len;
combine_stimuli=cell(2,2);
for i=1:2
    for j=1:2
        combine_stimuli{i,j}=zeros(totalcond,maxlen);
        for k=1:n
            combine_stimuli{i,j}((s_cond(k)+1):s_cond(k+1),(s_len(k)+1):end)=...
                experiments{k}{i,j};
        end
            
    end
end
end