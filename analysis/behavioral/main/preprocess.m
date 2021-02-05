
function preprocess ()
    clear all
    clc

    % 1 = vestbibular only
    % 2 = tactile only
    % 3 = bimodal

    % left = 1
    % right = 2

    % numer of angle conditions 11

    path = 'Z:\nbp\projects\refbelt\PlatformEEG\'; %Windows
    %path = '/net/store/nbp/refbelt/Platform/'; %Linux

    files =dir(strcat(path,'data\responses\'));
    %sessionNr = 0;
    count = 0;

    condition = strcat(path,'stimuli\conditions_balancing.mat');
    angles = strcat(path,'stimuli\Platform_Angles.mat');

    load(condition);
    load(angles);

    N = 4; 

    for subject = 1:N%3:N+3:length(files) 

       % subjectNr = subjectNr+1;

         vestibular = zeros(360,3);
         tactile = zeros(360,3);
         bimodal = zeros(360,3);

        for session = 1:3
            %sessionNr = sessionNr+1;             

            for block = 1:3
                count  = count +1;
                subjectNr = str2double(files(count+2,1).name(8:9));
                loadi = strcat(path,'data\responses\',files(count+2,1).name); 
                load(loadi)
                current_condition = all_conditions(subjectNr,(3*(session-1))+block);  
               % sanity = (3*(session-1))+block;
                platform_angles = squeeze(Platform_Angles(subjectNr,session,block,:,:));    
                resp = zeros(120,1);
                
                for i = 1:length(Output)

                    if (~isempty(strfind(Output(i).decision,'left')));
                        resp(i,1) = 1;
                    elseif (~isempty(strfind(Output(i).decision,'right')));
                        resp(i,1) = 2;
                    end                
                end


                data = [resp,platform_angles'];

                if (current_condition == 1) % if vestibular
                    if subjectNr < 10 
                    savename = strcat(path,'data\individual\','subject_0',num2str(subjectNr),'_session_',num2str(session),'_vestibular','.mat');
                    else
                    savename = strcat(path,'data\individual\','subject_',num2str(subjectNr),'_session_',num2str(session),'_vestibular','.mat');
                    end
                    save(savename,'data');

                    if (session == 1)
                    vestibular(1:length(Output),1) = resp;
                    vestibular(1:length(Output),2:3) = platform_angles';
                    elseif (session == 2)
                    vestibular(length(Output)+1:2*length(Output),1) = resp;
                    vestibular(length(Output)+1:2*length(Output),2:3) = platform_angles';
                    elseif (session == 3)
                    vestibular(2*length(Output)+1:3*length(Output),1) = resp;
                    vestibular(2*length(Output)+1:3*length(Output),2:3) = platform_angles';
                    end

                elseif (current_condition == 2) % if tactile
                    if subjectNr < 10 
                    savename = strcat(path,'data\individual\','subject_0',num2str(subjectNr),'_session_',num2str(session),'_tactile','.mat');
                    else
                    savename = strcat(path,'data\individual\','subject_',num2str(subjectNr),'_session_',num2str(session),'_tactile','.mat');
                    end
                    save(savename,'data');

                     if (session == 1)
                    tactile(1:length(Output),1) = resp;
                    tactile(1:length(Output),2:3) = platform_angles';
                    elseif (session == 2)
                    tactile(length(Output)+1:2*length(Output),1) = resp;
                    tactile(length(Output)+1:2*length(Output),2:3) = platform_angles';
                    elseif (session == 3)
                    tactile(2*length(Output)+1:3*length(Output),1) = resp;
                    tactile(2*length(Output)+1:3*length(Output),2:3) = platform_angles';
                    end
                elseif (current_condition == 3) % if bimodal
                    if subjectNr < 10 
                    savename = strcat(path,'data\individual\','subject_0',num2str(subjectNr),'_session_',num2str(session),'_bimodal','.mat');
                    else
                    savename = strcat(path,'data\individual\','subject_',num2str(subjectNr),'_session_',num2str(session),'_bimodal','.mat');
                    end
                    save(savename,'data');

                    if (session == 1)
                    bimodal(1:length(Output),1) = resp;
                    bimodal(1:length(Output),2:3) = platform_angles';
                    elseif (session == 2)
                    bimodal(length(Output)+1:2*length(Output),1) = resp;
                    bimodal(length(Output)+1:2*length(Output),2:3) = platform_angles';
                    elseif (session == 3)
                    bimodal(2*length(Output)+1:3*length(Output),1) = resp;
                    bimodal(2*length(Output)+1:3*length(Output),2:3) = platform_angles';
                    end
                end
                clear Output
                clear resp
                clear platform_angles
            end        
        end

        if subjectNr < 10 
             vest = strcat(path,'data\combined\','subject_0',num2str(subjectNr),'_vestibular','.mat');
             tac = strcat(path,'data\combined\','subject_0',num2str(subjectNr),'_tactile','.mat');
             bim = strcat(path,'data\combined\','subject_0',num2str(subjectNr),'_bimodal','.mat');

        else
             vest = strcat(path,'data\combined\','subject_',num2str(subjectNr),'_vestibular','.mat');
             tac = strcat(path,'data\combined\','subject_',num2str(subjectNr),'_tactile','.mat');
             bim = strcat(path,'data\combined\','subject_',num2str(subjectNr),'_bimodal','.mat');

        end

         clear data   
         data = vestibular;
         save(vest,'data'); 
         clear data
         data = tactile; 
         save(tac,'data');
         clear data
         data = bimodal; 
         save(bim,'data'); 
         clear data

    end


end
