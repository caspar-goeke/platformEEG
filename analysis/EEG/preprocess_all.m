clear
clc
 
%% load data 

% 1 = vestibular;
% 2 = tactile;
% 3 = bimodal;
session =3;
block =3;
subject = 3;

eeglab;
addpath('/net/store/nbp/refbelt/Platform/libeep-3.3.171/mex/eeglab');
addpath('/net/store/nbp/refbelt/Platform/libeep-3.3.171/mex/matlab');
addpath('/net/store/nbp/refbelt/Platform/eeglab13_4_4b/');
addpath('/net/store/nbp/refbelt/Platform/EEG/analysis_A_and_S/');
addpath('/home/student/s/splanera/Desktop/EEGanalysis');


for subject = 33 %32:34
   for session = 3%1:3
       for block = 1 %1:3
           
           
          %% load data
    
           EEG = pop_loadeep(['/net/store/nbp/refbelt/Platform/EEG/analysis_A_and_S/raw_data/'  num2str(subject) '_s' num2str(session) '_' num2str(block) '.cnt'], 'triggerfile','on');
           EEG.preprocess = [];
    
          %% lower sampling rate
    
           EEG = pop_resample(EEG,256);
           EEG.preprocess = [EEG.preprocess 'srate256'];
           EEG = pop_editset(EEG,'setname','srate256');
           %save
           EEG = pop_saveset(EEG,'filename',[num2str(subject) '_s' num2str(session) '_' num2str(block) '_srate256.set'],'filepath',['/home/student/s/splanera/Desktop/EEGanalysis/preprocessed_data']); %local pc

          %% deblanking (triggers)
          
            x=size(EEG.event);

            for t=1:max(x)
                EEG.event(t).type = deblank(EEG.event(t).type);
            end
           
            EEG.preprocess = [EEG.preprocess 'deblanking'];
            EEG.preprocess
            
           %% filtering
           
            EEG = pop_eegfiltnew(EEG,1); %high pass
            EEG.preprocess = [EEG.preprocess 'filtered'];
            EEG.preprocess
            %save
            EEG = pop_editset(EEG,'setname','filtered');
            EEG = pop_saveset(EEG, 'filename', [num2str(subject) '_s' num2str(session) '_' num2str(block) '_filtered.set'],'filepath',['/home/student/s/splanera/Desktop/EEGanalysis/preprocessed_data']); %local pc
            
            
           %% epoching
           
            EEG = pop_epoch(EEG,{128},[-3 1]);
            EEG = pop_rmbase(EEG, [-3000 1000]); % all epoch as baseline

            EEG.preprocess = [EEG.preprocess 'epochs_baselineRemoved'];
            EEG.preprocess
            
            %save
            EEG = pop_editset(EEG,'setname','epochs');
            EEG = pop_saveset(EEG, 'filename', [num2str(subject) '_s' num2str(session) '_' num2str(block) '_epochs.set'],'filepath',['/home/student/s/splanera/Desktop/EEGanalysis/preprocessed_data']); %local pc

   
       end
   end
end

eeglab redraw

    
   
   