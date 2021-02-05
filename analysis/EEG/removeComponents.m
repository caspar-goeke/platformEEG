function removeComponents(ComponentsToRemove)
% 
% close all
% clear
% clc
%  
% % 1 = vestibular;
% % 2 = tactile;
% % 3 = bimodal;
% 
% % add all the paths needed 
% addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/eeglab');
% addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/matlab');
% addpath('/net/store/nbp/projects/refbelt/PlatformEEG/eeglab13_4_4b/');
% eeglab();
% addpath('/net/store/nbp/projects/refbelt/PlatformEEG/');
% 
% path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/';
% path_plots = '/net/store/nbp/projects/refbelt/PlatformEEG/results/';

%ComponentsToRemove =
%[6,7,12,15,22,24,26,32,40,41,43,44,48,49,53,54,55,57,58,62,64,68,69,70,73,75,76,79,82,83,88,90,93,94,97,100,102,106,109,114,117,119];%first
%ICA

ComponentsToRemove = [1,2,4,8,9,10,12,14,15,16,18,21,24,25,27,31,32,34,38,39,40,42,43,44,45,48,49,52,53,57,59,61,63,66,67,68,72,73,74,75,77,78,80,81,85,86,88,92,93,94,95,96,97,98,101,103,104,106,107,109,110,111,112,113,117,121,123,124,126,127];
%EEG = pop_loadset('filename','32_session3_block3_first_ICA.set','filepath',strcat(path_data,'ICA_all_block/'));
EEG = eeg_checkset(EEG);
EEG = pop_subcomp( EEG, ComponentsToRemove, 0);
eeglab redraw
%% save here

end

