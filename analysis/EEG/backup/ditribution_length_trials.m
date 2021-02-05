clear
clc
 
% 1 = vestibular;
% 2 = tactile;
% 3 = bimodal;

% add all the paths needed 
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/eeglab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/matlab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/eeglab13_4_4b/');
eeglab;
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/');


%% load dataset (with triggers renamed already)

EEG = pop_loadset('filename','32_session3_block1_HPfilter_renameTrg.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 

eeglab redraw

% load epoched dataset 
EEG = pop_loadset('filename','32_session3_block1_epochsAll.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
eeglab redraw 

%% calculate length of trials 


first_on_rotation = nan(1,577);
first_off_rotation = nan(1,577); % 577 is the number of events
second_on_rotation = nan(1,577);
second_off_rotation = nan(1,577);
answers = nan(1,577);

for i = 1:length(EEG.event)
        
        if (strcmp(EEG.event(i).type,'16'))
            first_on_rotation(1,i) = (EEG.event(i).latency - EEG.event(i).latency);
        
        elseif (strcmp(EEG.event(i).type,'32'))
            first_off_rotation(1,i) = (EEG.event(i).latency - EEG.event(i-1).latency);
        
        elseif (strcmp(EEG.event(i).type,'17'))
            second_on_rotation (1,i) = (EEG.event(i).latency - EEG.event(i-2).latency);
            
        elseif (strcmp(EEG.event(i).type,'33'))
            second_off_rotation (1,i) = (EEG.event(i).latency - EEG.event(i-3).latency);
        
        %response time
        elseif (strcmp(EEG.event(i).type,'128'))
            answers(1,i) = (EEG.event(i).latency - EEG.event(i-4).latency);
            
        end
        
end


%plot
figure
h1 = histogram(first_on_rotation(first_on_rotation>0), [0:100:6000]);
hold on
h2 = histogram(first_off_rotation(first_off_rotation>0), [0:100:6000]);
hold on
h3 = histogram(second_on_rotation(second_on_rotation>0), [0:100:6000]);
hold on
h4 = histogram(second_off_rotation(second_off_rotation>0), [0:100:6000]);
hold on
h5 = histogram(answers(answers>0), [0:100:6000]);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
legend('First On','First Off','Second On','Second Off','Answers');
title('Trials Latency');
print('/net/store/nbp/projects/refbelt/PlatformEEG/results/Latency_Trials/32_session3_block1_Latencies_trials','-dpng')



%% calculate length of trials in sec

%%%%%%%%%%%% transform latency events in sec %%%%%%%%%%%%%%%%%

latency_sec = nan(1,577);

for i = 1:length(EEG.event)
    
    EEG.event(i).latency = eeg_point2lat(cell2mat({EEG.event(i).latency}),cell2mat({EEG.event(i).epoch}),EEG.srate,[EEG.xmin EEG.xmax]);
 
end





first_on_rotation = nan(1,577);
first_off_rotation = nan(1,577); % 577 is the number of events
second_on_rotation = nan(1,577);
second_off_rotation = nan(1,577);
answers = nan(1,577);

for i = 1:length(EEG.event)
        
        if (strcmp(EEG.event(i).type,'16'))
            first_on_rotation(1,i) = (EEG.event(i).latency - EEG.event(i).latency);
        
        elseif (strcmp(EEG.event(i).type,'32'))
            first_off_rotation(1,i) = (EEG.event(i).latency - EEG.event(i-1).latency);
        
        elseif (strcmp(EEG.event(i).type,'17'))
            second_on_rotation (1,i) = (EEG.event(i).latency - EEG.event(i-2).latency);
            
        elseif (strcmp(EEG.event(i).type,'33'))
            second_off_rotation (1,i) = (EEG.event(i).latency - EEG.event(i-3).latency);
        
        %response time
        elseif (strcmp(EEG.event(i).type,'128'))
            answers(1,i) = (EEG.event(i).latency - EEG.event(i-4).latency);
            
        end
        
end


figure
h1 = histogram(first_on_rotation(first_on_rotation>0), [0:18]);
hold on
h2 = histogram(first_off_rotation(first_off_rotation>0), [0:18]);
hold on
h3 = histogram(second_on_rotation(second_on_rotation>0), [0:18]);
hold on
h4 = histogram(second_off_rotation(second_off_rotation>0), [0:18]);
hold on
h5 = histogram(answers(answers>0), [0:18]);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [sec]','FontSize',14);
legend('First On','First Off','Second On','Second Off','Answers');
title('Trials Latency');
print('/net/store/nbp/projects/refbelt/PlatformEEG/results/Latency_Trials/32_session3_block1_Latencies_trials_sec','-dpng')

%% categorize trials

first_rotation = nan(1,577);
pause = nan(1,577);
second_rotation = nan(1,577);
response_time = nan(1,577);


for i = 1:length(EEG.event)
        
        
        if (strcmp(EEG.event(i).type,'32'))
            first_rotation(1,i) = (EEG.event(i).latency - EEG.event(i-1).latency);
        
        elseif (strcmp(EEG.event(i).type,'17'))
            pause(1,i) = (EEG.event(i).latency - EEG.event(i-1).latency);
            
        elseif (strcmp(EEG.event(i).type,'33'))
            second_rotation (1,i) = (EEG.event(i).latency - EEG.event(i-1).latency);
        
        %response time
        elseif (strcmp(EEG.event(i).type,'128'))
            response_time(1,i) = (EEG.event(i).latency - EEG.event(i-1).latency);
            
        end
        
end


mean_first_rotation = nanmean(first_rotation);
mean_pause = nanmean(pause);
mean_second_rotation = nanmean(second_rotation);
mean_response_time = nanmean(response_time);
std_response_time = nanstd(response_time);



figure
h1 = histogram(first_rotation(first_rotation>0), [0:18]);
hold on
h2 = histogram(pause(pause>0), [0:18]);
hold on
h3 = histogram(second_on_rotation(second_on_rotation>0), [0:18]);
hold on
h4 = histogram(second_off_rotation(second_off_rotation>0), [0:18]);
hold on
h5 = histogram(answers(answers>0), [0:18]);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [sec]','FontSize',14);
legend('First On','First Off','Second On','Second Off','Answers');
title('Trials Latency');


