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

%% load ICAed data

% bimodal
EEG = pop_loadset('filename','32_session3_block1_epochsAll_ICA.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
eeglab redraw 



%% Time-frequency transformation for each component


for i = 1:30 % number of components
    
    figure;
    %pop_newtimef( EEG, 0, i, [-2000   496], [0] , 'topovec', EEG.icawinv(:,i), 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', ['IC ', num2str(i)], 'baseline',[0 100], 'freqs', [4 50], 'plotphase', 'off', 'ntimesout', 400, 'padratio', 4);
    %saveas(gcf, ['32_s3_bl3_tfrIC' num2str(i)], 'png')
    pop_newtimef( EEG, 0, i, [-500   12996], [0] , 'topovec', EEG.icawinv(:,i), 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', ['tfrIC ', num2str(i)], 'baseline',[0], 'freqs', [4 50], 'plotphase', 'off', 'ntimesout', 400, 'padratio', 4);
    %saveas(gcf, ['32_session3_block1_tfrIC' num2str(i)], 'png')

end


%%