clear
clc

%% load data

eeglab;
%addpath('/net/store/nbp/refbelt/Platform/EEG_data/analysis_A_and_S/s33'); %linux
%EEG = pop_loadset('/net/store/nbp/refbelt/Platform/EEG_data/analysis_A_and_S/s33/s33_s3_1_srate256_cleaned_epochs_interpoletedM1.set'); %linux

addpath('/Users/Serena/Documents/eeglab13_4_4b');
addpath('/Users/Serena/Desktop/EEGanalysis'); %mac
EEG = pop_loadset('/Users/Serena/Desktop/EEGanalysis/s33_s3_1_srate256_cleaned_epochs_interpoletedM1.set'); %mac

eeglab redraw


%% latency triggers converter

Ntrials = 120;
srate = 256;
LatencyTriggers = nan(246,7);

for i = 1:length(LatencyTriggers)

    LatencyTriggers(i,1) = str2num(EEG.event(i).type); %trigger name
    LatencyTriggers(i,2) = EEG.event(i).latency; %latency
    LatencyTriggers(i,3) = EEG.event(i).epoch; %epoch Num

    if LatencyTriggers(i,1) == 64
        LatencyTriggers(i,1:3) = nan;
    end
    
    %% sanity check even number of triggers
    
    if LatencyTriggers(i,3) == 21 
        LatencyTriggers(i,1:3) = nan;
    elseif LatencyTriggers(i,3) == 80
        LatencyTriggers(i,1:3) = nan;
    elseif LatencyTriggers(i,3) == 94;
        LatencyTriggers(i,1:3) = nan;
    else
        
    end
    
    %% put the two triggers on the same row
    
     if LatencyTriggers(i,1) == 128
        LatencyTriggers(i-1,4) = LatencyTriggers(i,1);
        LatencyTriggers(i-1,5) = LatencyTriggers(i,2);
        LatencyTriggers(i,1:3) = nan;
            
     end
    
    %% calculate the latency's differerence between 128 and 32
    
    LatencyTriggers(i,6) = LatencyTriggers(i,5) - LatencyTriggers(i,2);
    
    %% transform latency (difference) in seconds 
    
    LatencyTriggers(i,7) = LatencyTriggers(i,6) / srate;
    
end


%% calculate mean

VarianceAnswers = nan(1,3);
    
VarianceAnswers(1,1) = nanmean(LatencyTriggers(:,7));
VarianceAnswers(1,2) = nanstd(LatencyTriggers(:,7) / sqrt(Ntrials-3));       
VarianceAnswers(1,3) = nanvar(LatencyTriggers(:,7));

























%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% try &&&&&&&&&&&&&

% remove trigger 64 through epoch numbers

EEG.eventType = cell((Ntrials*2),1);

for i = 1:length(EEG.event)
    
   EEG.event{i,:}.type = cell2mat(EEG.event(:,i).type);
%     if EEG.event(:,i).epoch >= 3
%         EEG.event(i,:).type = [ ];
%     end
%           
end


for i = 1:length(EEG.event)
    
    if EEG.event(i).typeNum == '32'
        Type = 1;
    else if EEG.event(i).typeNum == 128
            Type =2;
        else
            Type = 3;
        
    end
   
        
   
    TimeDifference(i,1) = find(EEG.event.type.latency) == '128 ';
    
    
    TimeDifference(i,2) = EEG.event.type.latency;
    
    
    TimeDifference(i,3) = (TimeDifference(i,1) - TimeDifference(i,2));
  
    end
end
