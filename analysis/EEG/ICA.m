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


%% load preprocessed data
% load high passed dataset 

EEG = pop_loadset('filename','04_session1_block1_HPfiltered.set','filepath',strcat(path_data,'preprocessed_eeg/'));
eeglab redraw


%% run ICA

%EEG = pop_runica(EEG); % pop up GUI window
EEG = pop_runica(EEG, 'extended',1,'interupt','off','pca',127);
% 'extended' perform 'extended-ICA' with sign estimation N training blocks.
% If N > 0, autimatically estimate the number od sub-Gaussian sources.
% 'pca' decomposes a principal component subspace of the data. Value is the
%number of PCs to retain.

%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block3_first_ICA.set','filepath',strcat(path_data,'ICA_all_block/')); 
eeglab redraw


% load dataset ICA
% EEG = pop_loadset('filename','32_session3_block1_first_ICA.set','filepath',strcat(path_data,'ICA_all_block/')); 
% eeglab redraw



%% Plot components' maps in 2-D

pop_topoplot(EEG,0, [1:30] ,'ICA components',[5 6],'electrodes','on');
% 1:30 components to plot
% 5 6 is the associated dipole fos scalp maps

filename = strcat(path_plots,'topoplots_first_ICA/','32_session3_block3_first_ICA_60','.png');
print(filename,'-dpng')

%% plot components data scroll

pop_eegplot( EEG, 0, 1, 1);

%% plot components to reject

EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:20] );

%% look properties of individual components

CompNr = 5;

EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, CompNr, NaN, {'freqrange' [2 50] });

%% remove components based on ICA (by visual inspection)

%plot components to remove the "noisy" ones

%pop_selectcomps(EEG, [1:30]); % first 30 components

removeComponents([6,7,12,15,22,24,26,32,40,41,43,44,48,49,53,54,55,57,58]);



%% playing around spectopo

pop_topoplot(EEG,0, [1:20] ,'EEProbe continuous data resampled epochs',[4 5] ,0,'electrodes','off');
pop_eegplot( EEG, 0, 1, 1);
figure; pop_spectopo(EEG, 1, [-3000       996.0938], 'EEG' , 'percent', 15, 'freq', [6 10 50], 'freqrange',[2 70],'electrodes','off');
figure; pop_spectopo(EEG, 1, [-3000       996.0938], 'EEG' , 'percent', 15, 'freq', [6 10 18 28], 'freqrange',[2 60],'electrodes','off');
