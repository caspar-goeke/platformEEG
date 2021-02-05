% EEGLAB history file generated on the 16-Jun-2015
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:30] );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
pop_saveh( ALLCOM, 'eeglabhist.m', '/net/store/nbp/projects/refbelt/PlatformEEG/analysis_EEG/');
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [6  7  8], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/net/store/nbp/projects/refbelt/PlatformEEG/data/ICA_all_block/componentsRemoved.set','gui','off'); 
eeglab redraw;
