function plotICAsortedbyRT(EEG,componentNr)



% add all the paths needed
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/eeglab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/matlab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/eeglab13_4_4b/');
eeglab;
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/');

path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/';

%% load data
% load data cleaned with ICA and with triggers renamed

EEG = pop_loadset('filename','32_session3_block3_epochs_17_Cleaned_ICA.set','filepath',strcat(path_data,'epochs_17/'));
eeglab redraw



%% calculates the component activation for a given component sorted by trial difficulty
componentNr =5;
nrOfTrials = EEG.trials;
dataPointsPerTrial = EEG.pnts;
compWeight = EEG.icaweights(componentNr,:);
totalTime = dataPointsPerTrial/ EEG.srate;

[b,idx] = sort(EEG.trialDifficulty);
Output = nan(dataPointsPerTrial,nrOfTrials); 


for trial = 1:nrOfTrials
    index = idx(trial);
    for point = 1:dataPointsPerTrial
        Output(point,trial) = compWeight*EEG.data(:,point,index);
    end
end

figure
imagesc(Output')
colormap jet
set(gca,'XTick',[1:127:768],'XTickLabel',[-0.5:0.5:2.5])
xlabel('Time (sec)');
ylabel('trial easy:hard');


end

