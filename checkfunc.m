EEG=pop_loadset('32_session3_block1_first_ICA_rename_Trg.set','/net/store/nbp/projects/refbelt/PlatformEEG/data/ICA_all_block');
%EEG=pop_loadset('s1_1.set','/net/store/nbp/projects/asymmetry/Ashima/SFC_STUFF/eegData/new');
fieldscheck=sanityCheck(EEG,['16' '32' '17' '33' '128']);