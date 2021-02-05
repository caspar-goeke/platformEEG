function analyzeStrategy()

    clear all 
    clc

    load 'Z:\nbp\refbelt\Platform\results\matData\QData.mat'; %Windows 

    N = 30;

    %% read subjective stuff
    Strategy = {3,3,N};
    % 1= tactile
    % 2= vestibular
    % 3 = bimodal
    
    for sub = 1:N

       Strategy{1,1,sub} = Data.subject{1,sub}.tactile.session1.strategy;
       Strategy{1,2,sub} = Data.subject{1,sub}.tactile.session2.strategy;
       Strategy{1,3,sub} = Data.subject{1,sub}.tactile.session3.strategy;
        
       Strategy{2,1,sub} = Data.subject{1,sub}.vestibular.session1.strategy;
       Strategy{2,2,sub} = Data.subject{1,sub}.vestibular.session2.strategy;
       Strategy{2,3,sub} = Data.subject{1,sub}.vestibular.session3.strategy;
       
       Strategy{3,1,sub} = Data.subject{1,sub}.bimodal.session1.strategy;
       Strategy{3,2,sub} = Data.subject{1,sub}.bimodal.session2.strategy;
       Strategy{3,3,sub} = Data.subject{1,sub}.bimodal.session3.strategy;
    end
    
    % 1 = belt
    % 2 = platform
    % 3 = combination
    % 4 = counting
    % 5 = visualization
    % 6 = guessing
    % 7 = others
  Strategy2 = nan(3,3,N);
    for cond = 1:3
        for session=1:3
            for subj = 1:N
                if isempty(Strategy{cond,session,subj}{1,1})
                       Strategy2(cond,session,subj) = 7;  
                else
                    string =  Strategy{cond,session,subj}{1,1}(1:9);
                    if ~isempty(strfind(string,'only belt'))
                        Strategy2(cond,session,subj) = 1; 
                    elseif ~isempty(strfind(string,'combinati'))
                        Strategy2(cond,session,subj) = 2;   
                    elseif ~isempty(strfind(string,'only plat'))
                        Strategy2(cond,session,subj) = 3;   
                    elseif ~isempty(strfind(string,'counting'))
                        Strategy2(cond,session,subj) = 4;   
                    elseif ~isempty(strfind(string,'trying to'))
                        Strategy2(cond,session,subj) = 5;   
                    elseif ~isempty(strfind(string,'guess'))
                        Strategy2(cond,session,subj) = 6;   
                    else 
                        Strategy2(cond,session,subj) = 7;   
                    end
                end

            end

        end
    end
    
    kickDueToRecordings = [2,26]; 
    kickDueToHighErrors = [15,16,17,18,28]; 
    kick = [kickDueToRecordings,kickDueToHighErrors];
    N = N-length(kick);
    Strategy2(:,:,kick) = [];
    
   
    
   Strategy3 = nan(3,3,7); 
     for cond = 1:3
        for session=1:3
            for strategy = 1:7
              Strategy3(cond,session,strategy) =  length(find(Strategy2(cond,session,:) == strategy))/N*100;
            end
        end
     end
    
    sess1 = squeeze(Strategy3(:,1,:));
    sess2 = squeeze(Strategy3(:,2,:));
    sess3 = squeeze(Strategy3(:,3,:));   
    meanOverSessions = squeeze(mean(Strategy3,2));
   
    meanmeanOaverSessions = find(mean(meanOverSessions)==0);
    Strats = {'Tactile Only', 'Combination', 'Vestibular Only', 'Counting', 'Visualization', 'Guessing','Other'};
    
    if length(meanmeanOaverSessions) > 0
        meanOverSessions(:,meanmeanOaverSessions) = [];
        Strats(meanmeanOaverSessions) = [];
    end
    

    figure
    bar(meanOverSessions, 'stacked');    
    ylim([0 170])
    set(gca,'YTick',[25,50,75,100],'YTickLabel', {'6(25%)','12(50%)','18(75%)','23(100%)'},'XTickLabel', {'Tactile', 'Vestibular', 'Bimodal'}, 'Fontsize',14)
    ylabel('Nr Subjects')
    legend(Strats)
    legend boxoff
   
end

