function removeBehavioral(removeEpochs)


removeEpochs = [1,3,5,11,20,23,26,28,36,41,42,43,48,52,54,69,70,74,75,77,81,82,84,85,92,93,97,110];

EEG.behavioralData(removeEpochs,:) = [];
EEG.trialDifficulty(removeEpochs) = []; 



EEG = pop_saveset(EEG, 'filename', '32_session3_block1_epochs_16_Cleaned_ICA.set','filepath',strcat(path_data,'epochs_16/')); 


end

