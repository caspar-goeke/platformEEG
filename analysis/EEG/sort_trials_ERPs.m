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

%% load data

EEG = pop_loadset('filename','32_session3_block3_HPfilter.set','filepath',path_data);
eeglab redraw



%% order trials based on difficulty level
% 0 by chance
% 1 hardest
% 5 easiest


EEG = eeg_checkset( EEG );
figure; 
pop_erpimage(EEG,0, [6],[[]],'Comp. 6',10,1,{},[],'','yerplabel','','erp','on','cbar','on','topo', { mean(EEG.icawinv(:,[6]),2) EEG.chanlocs EEG.chaninfo } );


