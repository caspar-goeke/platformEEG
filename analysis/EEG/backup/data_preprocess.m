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


%% load raw data

% load .cnt dataset with triggers to be transformed in .set 
EEG = pop_loadeep('/net/store/nbp/projects/refbelt/PlatformEEG/data/raw_data/32_s3.cnt', 'triggerfile','on');  % 32=Kevin, 33=Sebastian   

eeglab redraw


%% sampling rate = 256 Hz
% change sampling rate to 256Hz

EEG = pop_resample(EEG,256);
EEG = pop_editset(EEG,'setname','srate256');
%save
EEG = pop_saveset(EEG,'filename',['32_session3_srate256.set'],'filepath',['/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/']); 
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
EEG = pop_saveset(EEG, 'filename', '33_session3_block3_HPfiltered.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/');


%% load existing dataset High Pass filtered 

% vestibular
EEG = pop_loadset('filename','32_session3_block3_HPfilter.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
eeglab redraw

% tactile
%EEG = pop_loadset('filename','32_session3_block2_HPfiltered.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 

% bimodal
%EEG = pop_loadset('filename','32_session2_block2_HPfilter.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
EEG = pop_loadset('filename','32_session3_block1_HPfilter.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
eeglab redraw


%plot channel data scroll
pop_eegplot(EEG,1,1,1);


%% cut out strong artifacts by hand




%% remove bad channel (if needed)

chan_del = {'M1'};
EEG = pop_select(EEG, 'nochannel', chan_del);

%save 
EEG = pop_editset(EEG,'setname','cleaned_channels');
EEG = pop_saveset(EEG, 'filename', ['33_s3_2_cleanedChan.set'],'filepath',['/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/']); %local pc



%% rename triggers
% 1st platform on = 16
% 1st platform off = 32
% 2nd platform on = 17
% 2nd platform off = 33

for i = 2:length(EEG.event)
       
    if  (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-1).type,'32'));
            
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 17});
        
    elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i+1).type,'128'));
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 33});
        
    end
        
    % sanity check (deleting trials if there are not all the triggers)
    
    % ?
end

%save
EEG = pop_saveset(EEG, 'filename', ['32_session3_block3_HPfilter_renameTrg.set'],'filepath',['/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/']); 


%load it (next time)

EEG = pop_loadset('filename','32_session3_block3_HPfilter_renameTrg.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 

eeglab redraw

%% sanity check
% making sure that the order of the triggers is for all the trials the
% following: 16 32 17 33 128.
% Deleting events if this is not the case(e.g. missing triggers, et.)

for i = 1:(length(EEG.event))-1
       
        % deleting trigegrs 64
        if  (strcmp(EEG.event(i).type,'boundary')) == 1;
            EEG.event(i) = [ ];     
            
        end
  
end

for i = 1:(length(EEG.event))-1
       
        % deleting trigegrs 64
        if  (strcmp(EEG.event(i).type,'64'));
            EEG.event(i) = [ ];     
            
        end
  
end

for i = 4:(length(EEG.event))-1
    
    
        % 16 followed by a 16 (deleting the second)
        if (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-1).type,'16'));
            EEG.event(i).type = [ ];
        
        % 32 followed by a 32 (deleting the second)
        elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i-1).type,'32'));
            EEG.event(i).type = [ ];
        
        %two 128 triggers in a raw, deleting the second
        elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-1).type,'128'));
            EEG.event(i).type = [ ];
            
        % deleting the following sequence: 16 32 17 128  
        elseif (strcmp(EEG.event(i).type,'17')) && (strcmp(EEG.event(i+1).type,'128'));
            EEG.event(i).type = [ ];
            
        elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i+2).type,'128'));
            EEG.event(i).type = [ ];
            
        elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-3).type,'16'));
            EEG.event(i).type = [ ];
            
        elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i-3).type,'128'));
            EEG.event(i).type = [ ];
            
        elseif (strcmp(EEG.event(i).type,'17')) && (strcmp(EEG.event(i-4).type,'128'));
            EEG.event(i).type = [ ];
            
        % deleting the following sequence: 16 [16] 33 128 (about 15) 
        elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-4).type,'128'));
            EEG.event(i).type = [ ];
            
        elseif (strcmp(EEG.event(i).type,'33')) && (strcmp(EEG.event(i-2).type,'16'));
            EEG.event(i).type = [ ];
            
        elseif (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-4).type,'16'));
            EEG.event(i-4).type = [ ];
            
        end

        
end

%save
EEG = pop_saveset(EEG, 'filename', ['32_session3_block3_HPfilter_renameTrg.set'],'filepath',['/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/']); 

%load it (next time)
EEG = pop_loadset('filename','32_session3_block3_HPfilter_renameTrg.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 

eeglab redraw


%% latency 2nd platform off triggers
% calculate the time length until the second stop of the platform for each
% trial

latency_platOff_difference = nan(1,577); % 577 is the number of events

for i = 2:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'33'))
        latency_platOff_difference(1,i) = (EEG.event(i).latency - EEG.event(i-3).latency);
    end 

end

mean_latency_platOff = nanmean(latency_platOff_difference);
std_latency_platOff = nanstd(latency_platOff_difference);
min_latency_platOff = min(latency_platOff_difference);
max_latency_platOff = max(latency_platOff_difference);

fig = figure;
histogram(latency_platOff_difference(latency_platOff_difference>0), [0:100:5000]);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Platform Off Latency');
print(fig, '/net/store/nbp/projects/refbelt/PlatformEEG/results/Latency_Trials/32_session3_block3_PlOff_Latency','-dpng')
close all


%% latency answers' triggers 
% calculate the time length of each trial and the average over all the
% trails --> to later cut the epochs accordingly

latency_answer_difference = nan(1,577); % 577 is the number of events

for i = 2:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'128'))
        latency_answer_difference(1,i) = (EEG.event(i).latency - EEG.event(i-4).latency);
    end 

end

mean_latency_answer = nanmean(latency_answer_difference);
std_latency_answer = nanstd(latency_answer_difference);
min_latency_answer = min(latency_answer_difference);
max_latency_answer = max(latency_answer_difference);

fig = figure;
histogram(latency_answer_difference(latency_answer_difference>0), [0:100:6000]);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Answers Latency');
print(fig, '/net/store/nbp/projects/refbelt/PlatformEEG/results/Latency_Trials/32_session3_block3_answer_Latency','-dpng')
close all



% plot the 2 latency histograms toghether
figure
h1 = histogram(latency_platOff_difference(latency_platOff_difference>0), [0:100:6000]);
hold on
h2 = histogram(latency_answer_difference(latency_answer_difference>0), [0:100:6000]);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
legend('Platform Off','Answers');
title('Trials Latency');
print('/net/store/nbp/projects/refbelt/PlatformEEG/results/Latency_Trials/32_session3_block3_Latencies_overlap','-dpng')


%% epoching 
% epochs of the trials with all 5 triggers (from -500ms before the first stimulus onset until +200ms after the response button press)
%baseline: -5000 0 before the first rotati

EEG = pop_epoch(EEG,{'16'},[-0.5  13]); % 3 based on the mean_latency_difference value!
EEG = pop_rmbase(EEG, [-500  0]); 

%save
EEG = pop_saveset(EEG, 'filename', ['32_session3_block3_epochsAll.set'],'filepath',['/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/']); 
eeglab redraw
%plot channel data scroll
pop_eegplot(EEG,1,1,1);

%%%%%%%%%%%%%%%%
% load epoched dataset 
EEG = pop_loadset('filename','32_session3_block1_epochsAll.set','filepath','/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/'); 
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
