clear
clc
 
% 1 = vestibular;
% 2 = tactile;
% 3 = bimodal;

% add all the paths needed 
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/eeglab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/matlab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/eeglab13_4_4b/');
eeglab();
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/');
path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/';
path_plots = '/net/store/nbp/projects/refbelt/PlatformEEG/results/';

%% load behavioral data

dataSetToLoad = 'individual/subject_32_session_3_vestibular.mat';
load(strcat(path_data,dataSetToLoad))

EEG = pop_loadset('filename','32_session3_block3_first_ICA_rename_Trg.set','filepath',strcat(path_data,'ICA_all_block/'));
EEG.behavioralData = data;
%% compute trial difficulty
EEG.trialDifficulty= abs(EEG.behavioralData(:,2)-EEG.behavioralData(:,3))/11.25;
EEG = pop_saveset(EEG, 'filename', '32_session3_block3_epochs_17_Cleaned_ICA.set','filepath',strcat(path_data,'epochs_17/')); 
