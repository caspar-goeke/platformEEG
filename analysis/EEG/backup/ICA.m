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


%% load preprocessed data
% load epoched dataset 

% bimodal
EEG = pop_loadset('filename','32_session3_block1_epochsAll.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
eeglab redraw 


%% run ICA

%EEG = pop_runica(EEG); % pop up GUI window
EEG = pop_runica(EEG, 'extended',1,'interupt','on','pca',127);
% 'extended' perform 'extended-ICA' with sign estimation N training blocks.
% If N > 0, autimatically estimate the number od sub-Gaussian sources.
% 'pca' decomposes a principal component subspace of the data. Value is the
%number of PCs to retain.

%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block1_epochsAll_ICA.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 

% load dataset ICA
EEG = pop_loadset('filename','32_session3_block1_epochsAll_ICA.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
eeglab redraw

%% Plot components' maps in 2-D

pop_topoplot(EEG,0, [1:30] ,'ICA components',[5 6],'electrodes','off');
% 1:30 components to plot
% 5 6 is the associated dipole fos scalp maps

print('/net/store/nbp/projects/refbelt/PlatformEEG/results/32_session3_block1_ICA_components','-dpng');


%% plot components data scroll

pop_eegplot( EEG, 0, 1, 1);


%% remove components based on ICA (by visual inspection)






%% playing around spectopo

pop_topoplot(EEG,0, [1:20] ,'EEProbe continuous data resampled epochs',[4 5] ,0,'electrodes','off');
pop_eegplot( EEG, 0, 1, 1);
figure; pop_spectopo(EEG, 1, [-3000       996.0938], 'EEG' , 'percent', 15, 'freq', [6 10 50], 'freqrange',[2 70],'electrodes','off');
figure; pop_spectopo(EEG, 1, [-3000       996.0938], 'EEG' , 'percent', 15, 'freq', [6 10 18 28], 'freqrange',[2 60],'electrodes','off');
