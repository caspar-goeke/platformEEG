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

path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/';


%% load data


EEG = pop_loadset('filename','32_session3_block3_HPfilter.set','filepath',path_data);
eeglab redraw



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
EEG = pop_saveset(EEG, 'filename','32_session3_block3_HPfilter_renameTrg.set','filepath',path_data);
eeglab redraw 






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

for i = 2:(length(EEG.event))
    
    
%     % 16 followed by a 16 (deleting the second)
%     if (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-1).type,'16'));
%         EEG.event(i).type = [ ];
        
        % 32 followed by a 32 (deleting the second)
%     elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i-1).type,'32'));
%         EEG.event(i).type = [ ];
        
        %two 128 triggers in a raw, deleting the second
    if (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-1).type,'128'));
        EEG.event(i).type = [ ];
        
        %         % deleting the following sequence: 16 32 17 128
        %         elseif (strcmp(EEG.event(i).type,'17')) && (strcmp(EEG.event(i+1).type,'128'));
        %             EEG.event(i:i+3).type = [ ];
        %
        %         elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i+2).type,'128'));
        %             EEG.event(i).type = [ ];
        %
        %         elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-3).type,'16'));
        %             EEG.event(i).type = [ ];
        %
        %         elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i-3).type,'128'));
        %             EEG.event(i).type = [ ];
        %
        %         elseif (strcmp(EEG.event(i).type,'17')) && (strcmp(EEG.event(i-4).type,'128'));
        %             EEG.event(i).type = [ ];
        %
        %         % deleting the following sequence: 16 [16] 33 128 (about 15)
        %         elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-4).type,'128'));
        %             EEG.event(i).type = [ ];
        %
        %         elseif (strcmp(EEG.event(i).type,'33')) && (strcmp(EEG.event(i-2).type,'16'));
        %             EEG.event(i).type = [ ];
        %
        %         elseif (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-4).type,'16'));
        %             EEG.event(i-4).type = [ ];
        %
    end
    
    
end


%save
EEG = pop_saveset(EEG, 'filename', '32_session3_block3_HPfilter_renameTrg.set','filepath',path_data);

%load it (next time)
EEG = pop_loadset('filename','32_session3_block3_HPfilter_renameTrg.set','filepath',path_data);

eeglab redraw
