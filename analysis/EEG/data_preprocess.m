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

path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/';



%% load raw data

% load .cnt dataset with triggers to be transformed in .set
%EEG = pop_loadeep('/net/store/nbp/projects/refbelt/PlatformEEG/data/raw_data/32_s3.cnt', 'triggerfile','on');  % 32=Kevin, 33=Sebastian
EEG = pop_loadeep('/net/store/nbp/projects/refbelt/PlatformEEG/data/data_Aug15/raw_data/20150818_s08_lock2.cnt', 'triggerfile','on'); 

eeglab redraw


%% sampling rate = 256 Hz
% change sampling rate to 256Hz

EEG = pop_resample(EEG,256);
EEG = pop_editset(EEG,'setname','srate256');
%save
EEG = pop_saveset(EEG,'filename','03_session1_block1_srate256.set','filepath',strcat(path_data,'preprocessed_eeg/'));
%EEG = pop_saveset(EEG); %pop up window

eeglab redraw


%% load existing dataset (.cnt transformed already in .set files ONLY!)

% load .set file (not preprocessed, only srate changed at 256Hz)

EEG = pop_loadset('filename','32_session3_block3_srate256.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/');

eeglab redraw


%% deblanking (triggers)

x=size(EEG.event);

for t=1:max(x)
    EEG.event(t).type = deblank(EEG.event(t).type);
end

eeglab redraw


%% filtering

EEG = pop_eegfiltnew(EEG,1); %high pass
%pop_eegplot(EEG)

%save
%EEG = pop_editset(EEG,'setname','filtered');
%EEG = pop_saveset(EEG, 'filename', '33_session3_block3_HPfiltered.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/');
%EEG = pop_loadset(EEG, 'filename', '33_s3_2_filtered.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_OLD/');
EEG = pop_saveset(EEG,'filename','subject08_block02_bimodal_preprocessed.set','filepath',strcat(path_data,'data_Aug15/preprocessed/'));
eeglab redraw

%% load existing dataset High Pass filtered

% vestibular
EEG = pop_loadset('filename','32_session3_block3_HPfilter.set','filepath',path_data);
eeglab redraw

% tactile
%EEG = pop_loadset('filename','32_session3_block2_HPfiltered.set','filepath',path_data);

% bimodal
%EEG = pop_loadset('filename','32_session2_block2_HPfilter.set','filepath',path_data);
EEG = pop_loadset('filename','32_session3_block1_HPfilter.set','filepath',path_data);
eeglab redraw


%plot channel data scroll
pop_eegplot(EEG,1,1,1);


%% cut out strong artifacts by hand




%% remove bad channel (if needed)

chan_del = {'M1'};
EEG = pop_select(EEG, 'nochannel', chan_del);

%save
EEG = pop_editset(EEG,'setname','cleaned_channels');
EEG = pop_saveset(EEG, 'filename', '33_s3_2_cleanedChan.set','filepath',path_data); %local pc


%%%%%%%%%%%%%%%%  unused channels  %%%%%%%%%%%%%%%%%%%%%%%%

chan_del = {'Cz'};
EEG = pop_select(EEG, 'nochannel', chan_del);

chan_del = {'Ref'};
EEG = pop_select(EEG, 'nochannel', chan_del);

chan_del = {'HEOG'};
EEG = pop_select(EEG, 'nochannel', chan_del);

chan_del = {'CzOtheram'};
EEG = pop_select(EEG, 'nochannel', chan_del);

%save
EEG = pop_saveset(EEG,'filename','subject10_block02_bimodal_preprocessed.set','filepath',strcat(path_data,'data_Aug15/preprocessed/'));
eeglab redraw






%% channel location
% load channel location for a standard file
EEG=pop_chanedit(EEG, 'lookup','/net/store/nbp/projects/refbelt/PlatformEEG/eeglab13_4_4b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');


%% spectoplot

%EEG = pop_spectopo(EEG)

% plot the mean log spectrum of a set of data epochs at all channels (each
% channel is a color line). At specified frequencies (e.g. 6,10, anbd 19)
% plot the relative topographic distribution of power.

figure;
pop_spectopo(EEG, 1, [-500      12996.0938], 'EEG' , 'percent', 15, 'freq', [6 10 19], 'freqrange',[2 30],'electrodes','off');

% "percent" is the percent of the data to sample for computinf the spectra.
% "freqrange" is the frequency range to plot.
