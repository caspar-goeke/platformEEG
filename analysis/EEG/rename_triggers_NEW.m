%% rename triggers

% 1st platform on = 16
% 1st belt om = 26

% 1st platform off = 32
% 1st platform off = 74

% 2nd platform on = 17
% 2nd belt on =27

% 2nd platform off = 33
% 2nd belt off = 75

% answer = 128



%% remove first 64 in each block

EEG.event(1) = [];


%% vestibular

for i = 2:length(EEG.event)
    
    if  (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-1).type,'32'));
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 17});
        
    elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i+1).type,'128'));
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 33});
        
    end
    
    % sanity check (deleting trials if there are not all the triggers)
    
    % ?
end



% sanity check
for i = 6:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-5).type,'128'));
        display('okay')
    elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-4).type,'128')); 
        display('error: check triggers!')
    end

end




%save
EEG = pop_saveset(EEG, 'filename','32_session3_block3_HPfilter_renameTrg.set','filepath',path_data);
eeglab redraw 


%% tactile

%latency_diff_prova = (EEG.event(15).latency - EEG.event(14).latency) / 256 * 1000; 

EEG.event(1).type = '26';

% rename first on and second off
for i = 2:length(EEG.event)
    
    if  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i+1).type,'128')); % second off
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 75});
        
    elseif (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i-1).type,'128')); % first on
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 26});
        
    end
    
end

% put trigger 27 = second on
%k = 0;
for i = 2:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'64'))
        if (strcmp(EEG.event(i-1).type,'64'))
            %k = k+1;
            if ((EEG.event(i).latency - EEG.event(i-1).latency)/256*1000) > 500
                EEG = pop_editeventvals(EEG,'changefield',{i 'type' 27});    
            %latency_diff(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency)/256 * 1000; % in ms
            end
        end 
    end

end

% put trigger 74 = first off
for i = 1:length(EEG.event)
    
    if  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i+1).type,'27')); 
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 74});
    end
    
end

%delete all 64
for i = 1:length(EEG.event)

    if  (strcmp(EEG.event(i).type,'64')); 
        EEG.event(i) = [];
    end

end


% sanity check
for i = 6:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-5).type,'128'));
        display('okay')
    elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-4).type,'128')); 
        display('error: check triggers!')
    end

end



%% bimodal

for i = 1:length(EEG.event)

    if  (strcmp(EEG.event(i).type,'80')); 
        EEG.event(i) = [];
    end

end
    

% triggers platform
for i = 2:length(EEG.event)
    
    if  (strcmp(EEG.event(i).type,'16')) && (strcmp(EEG.event(i-2).type,'32'));
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 17});
        
    elseif (strcmp(EEG.event(i).type,'32')) && (strcmp(EEG.event(i+2).type,'128'));
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 33});
        
    end
    
    % sanity check (deleting trials if there are not all the triggers)
    
    % ?
end

% triggers belt
for i = 1:length(EEG.event)
    
    if  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i-1).type,'16')); % first onset belt 
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 26});
        
    elseif  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i-1).type,'32')); % first offset belt 
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 74});
        
    elseif  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i-1).type,'17')); % second onset belt 
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 27});
        
    elseif (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i-1).type,'33')); % second offset belt
        
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' 75});
        
%     elseif  (strcmp(EEG.event(i).type,'64')); % remove all the other 64 
%         
%         EEG = pop_editeventvals(EEG,'changefield',{i 'type' 27});    
        
    end
    
    % sanity check (deleting trials if there are not all the triggers)
    
    % ?
end


% remove all 64
for i = 1:length(EEG.event)

    if  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i+1).type,'64')); 
        EEG.event(i) = [];
    end

end
  
for i = 1:length(EEG.event)

    if  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i+1).type,'32')); 
        EEG.event(i) = [];
        
    elseif  (strcmp(EEG.event(i).type,'64')) && (strcmp(EEG.event(i+1).type,'33')); 
        EEG.event(i) = [];
        
    end

end


% sanity check
for i = 10:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-9).type,'128'));
        display('okay')
    elseif (strcmp(EEG.event(i).type,'128')) && (strcmp(EEG.event(i-8).type,'128')); 
        display('error: check triggers!')
    end

end



