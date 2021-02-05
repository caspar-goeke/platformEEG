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

path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/';

%% load data
% load data cleaned with ICA and with triggers renamed

EEG = pop_loadset('filename','32_session3_block3_first_ICA_rename_Trg_CleanedComp.set','filepath',strcat(path_data,'ICA_all_block/'));
% EEG = pop_loadset('filename','32_session3_block3_first_ICA_cleaned.set','filepath',path_data);
eeglab redraw



%% epoch first ON platform
% epochs trigger #16 
% latency (min) of the first off paltform = 2.752

EEG = pop_epoch(EEG,{'16'},[-0.5  2]); % 2.6 based on the min_latency_first_off value!
EEG = pop_rmbase(EEG, [-500  0]); % baseline = 500 ms vefore stimulus onset
eeglab redraw

%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block1_epochs_16.set','filepath',strcat(path_data,'epochs_16/'));
eeglab redraw
%plot channel data scroll
pop_eegplot(EEG,1,1,1);


%% epoch second ON platform
% epochs trigger #17 
% latency (min) of the second off paltform = 2.592

EEG = pop_epoch(EEG,{'17'},[-0.5  2]); % 2.5 based on the min_latency_second_off value!
EEG = pop_rmbase(EEG, [-500  0]); % baseline = 500 ms vefore stimulus onset?!
eeglab redraw

%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block1_epochs_17.set','filepath',strcat(path_data,'epochs_17/'));
eeglab redraw
%plot channel data scroll
pop_eegplot(EEG,1,1,1);


%% epoch second OFF platform
% epochs trigger #33 

EEG = pop_epoch(EEG,{'33'},[-0.5  1]); % 0.3 based on the min_latency_answers value!
EEG = pop_rmbase(EEG, [-500  0]); % baseline = 500 ms vefore stimulus offset?!

%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block1_epochs_33_firstAnswers.set','filepath',strcat(path_data,'epochs_33/'));
eeglab redraw
%plot channel data scroll
pop_eegplot(EEG,1,1,1);


%% epoch answers
% epochs trigger #128 

EEG = pop_epoch(EEG,{'128'},[-0.5  2]); % ?????
EEG = pop_rmbase(EEG, [-500  0]); % baseline = 500 ms vefore stimulus offset?!

%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block3_epochs_128.set','filepath',strcat(path_data,'epochs_128/'));
eeglab redraw
%plot channel data scroll
pop_eegplot(EEG,1,1,1);







%% epoching the whole trials (?!)
% epochs of the trials with all 5 triggers (from -500ms before the first stimulus onset until +200ms after the response button press)
%baseline: -5000 0 before the first rotati

% EEG = pop_epoch(EEG,{'16'},[-0.5  13]); % 3 based on the mean_latency_difference value!
% EEG = pop_rmbase(EEG, [-500  0]);
% 
% %save
% EEG = pop_saveset(EEG, 'filename', ['32_session3_block3_epochsAll.set'],'filepath',['/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/']);
% eeglab redraw
% %plot channel data scroll
% pop_eegplot(EEG,1,1,1);
% 
% %%%%%%%%%%%%%%%%
% % load epoched dataset
% EEG = pop_loadset('filename','32_session3_block1_epochsAll.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/');
% eeglab redraw