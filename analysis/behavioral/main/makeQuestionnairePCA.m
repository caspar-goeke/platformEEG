function makeQuestionnairePCA ( )

    clear all
    clc

    N = 30;
    NrQuesntions = 35;
    Matrix =  nan(NrQuesntions,N);

    load 'Z:\nbp\refbelt\Platform\results\matData\QData.mat'; %Windows

    %% read subjective stuff

    for sub = 1:N
        %tactile general 
        Matrix(1,sub) =  mean([Data.subject{1,sub}.tactile.session1.setupComfortable,Data.subject{1,sub}.tactile.session2.setupComfortable,Data.subject{1,sub}.tactile.session3.setupComfortable]);
        Matrix(2,sub) =  mean([Data.subject{1,sub}.tactile.session1.noiseDisturbing,Data.subject{1,sub}.tactile.session2.noiseDisturbing,Data.subject{1,sub}.tactile.session3.noiseDisturbing]);
        Matrix(3,sub) =  mean([Data.subject{1,sub}.tactile.session1.blindfoldedDisturbing,Data.subject{1,sub}.tactile.session2.blindfoldedDisturbing,Data.subject{1,sub}.tactile.session3.blindfoldedDisturbing]);
        Matrix(4,sub) =  mean([Data.subject{1,sub}.tactile.session1.feelingWell,Data.subject{1,sub}.tactile.session2.feelingWell,Data.subject{1,sub}.tactile.session3.feelingWell]);     
        Matrix(5,sub) =  mean([Data.subject{1,sub}.tactile.session1.taskTiring,Data.subject{1,sub}.tactile.session2.taskTiring,Data.subject{1,sub}.tactile.session3.taskTiring]);
        Matrix(6,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltDistracting,Data.subject{1,sub}.tactile.session2.beltDistracting,Data.subject{1,sub}.tactile.session3.beltDistracting]);
       
        %tactile task speficic
        Matrix(7,sub) =  mean([Data.subject{1,sub}.tactile.session1.similarTask,Data.subject{1,sub}.tactile.session2.similarTask,Data.subject{1,sub}.tactile.session3.similarTask]);
        Matrix(8,sub) =  mean([Data.subject{1,sub}.tactile.session1.taskIntuitive,Data.subject{1,sub}.tactile.session2.taskIntuitive,Data.subject{1,sub}.tactile.session3.taskIntuitive]);       
        Matrix(9,sub) =  mean([Data.subject{1,sub}.tactile.session1.taskDifficult,Data.subject{1,sub}.tactile.session2.taskDifficult,Data.subject{1,sub}.tactile.session3.taskDifficult]);
        Matrix(10,sub) =  mean([Data.subject{1,sub}.tactile.session1.performedWell,Data.subject{1,sub}.tactile.session2.performedWell,Data.subject{1,sub}.tactile.session3.performedWell]);    
        Matrix(11,sub) =  mean([Data.subject{1,sub}.tactile.session1.answerConfidence,Data.subject{1,sub}.tactile.session2.answerConfidence,Data.subject{1,sub}.tactile.session3.answerConfidence]);
        Matrix(12,sub) =  mean([Data.subject{1,sub}.tactile.session1.comfortableWithTask,Data.subject{1,sub}.tactile.session2.comfortableWithTask,Data.subject{1,sub}.tactile.session3.comfortableWithTask]);
        Matrix(13,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltRelevantInfo,Data.subject{1,sub}.tactile.session2.beltRelevantInfo,Data.subject{1,sub}.tactile.session3.beltRelevantInfo]);
        Matrix(14,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltSignalProminent,Data.subject{1,sub}.tactile.session2.beltSignalProminent,Data.subject{1,sub}.tactile.session3.beltSignalProminent]);      
       
        % Belt Signal Overall (only for belt)
        Matrix(15,sub) =  mean([Data.subject{1,sub}.tactile.session1.usedBeltInfo,Data.subject{1,sub}.tactile.session2.usedBeltInfo,Data.subject{1,sub}.tactile.session3.usedBeltInfo]);     
        Matrix(16,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltHelpTask,Data.subject{1,sub}.tactile.session2.beltHelpTask,Data.subject{1,sub}.tactile.session3.beltHelpTask]);             
        Matrix(17,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltContinuous,Data.subject{1,sub}.tactile.session2.beltContinuous,Data.subject{1,sub}.tactile.session3.beltContinuous]);
        Matrix(18,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltIntuitive,Data.subject{1,sub}.tactile.session2.beltIntuitive,Data.subject{1,sub}.tactile.session3.beltIntuitive]);
        Matrix(19,sub) =  mean([Data.subject{1,sub}.tactile.session1.beltMoreSecure,Data.subject{1,sub}.tactile.session2.beltMoreSecure,Data.subject{1,sub}.tactile.session3.beltMoreSecure]);                
        
  %% 
        
        %vestibular general
        Matrix(20,sub) =  mean([Data.subject{1,sub}.vestibular.session1.setupComfortable,Data.subject{1,sub}.vestibular.session2.setupComfortable,Data.subject{1,sub}.vestibular.session3.setupComfortable]);
        Matrix(21,sub) =  mean([Data.subject{1,sub}.vestibular.session1.noiseDisturbing,Data.subject{1,sub}.vestibular.session2.noiseDisturbing,Data.subject{1,sub}.vestibular.session3.noiseDisturbing]);
        Matrix(22,sub) =  mean([Data.subject{1,sub}.vestibular.session1.blindfoldedDisturbing,Data.subject{1,sub}.vestibular.session2.blindfoldedDisturbing,Data.subject{1,sub}.vestibular.session3.blindfoldedDisturbing]);
        Matrix(23,sub) =  mean([Data.subject{1,sub}.vestibular.session1.feelingWell,Data.subject{1,sub}.vestibular.session2.feelingWell,Data.subject{1,sub}.vestibular.session3.feelingWell]);        
        Matrix(24,sub) =  mean([Data.subject{1,sub}.vestibular.session1.taskTiring,Data.subject{1,sub}.vestibular.session2.taskTiring,Data.subject{1,sub}.vestibular.session3.taskTiring]);
        Matrix(25,sub) =  mean([Data.subject{1,sub}.vestibular.session1.platformDisturbing,Data.subject{1,sub}.vestibular.session2.platformDisturbing,Data.subject{1,sub}.vestibular.session3.platformDisturbing]);      
        Matrix(26,sub) =  mean([Data.subject{1,sub}.vestibular.session1.rotationFeelDizzy,Data.subject{1,sub}.vestibular.session2.rotationFeelDizzy,Data.subject{1,sub}.vestibular.session3.rotationFeelDizzy]);
        
        % vestibular task specific
        Matrix(27,sub) =  mean([Data.subject{1,sub}.vestibular.session1.similarTask,Data.subject{1,sub}.vestibular.session2.similarTask,Data.subject{1,sub}.vestibular.session3.similarTask]);
        Matrix(28,sub) =  mean([Data.subject{1,sub}.vestibular.session1.taskIntuitive,Data.subject{1,sub}.vestibular.session2.taskIntuitive,Data.subject{1,sub}.vestibular.session3.taskIntuitive]);        
        Matrix(29,sub) =  mean([Data.subject{1,sub}.vestibular.session1.taskDifficult,Data.subject{1,sub}.vestibular.session2.taskDifficult,Data.subject{1,sub}.vestibular.session3.taskDifficult]);
        Matrix(30,sub) =  mean([Data.subject{1,sub}.vestibular.session1.performedWell,Data.subject{1,sub}.vestibular.session2.performedWell,Data.subject{1,sub}.vestibular.session3.performedWell]);       
        Matrix(31,sub) =  mean([Data.subject{1,sub}.vestibular.session1.answerConfidence,Data.subject{1,sub}.vestibular.session2.answerConfidence,Data.subject{1,sub}.vestibular.session3.answerConfidence]);  
        Matrix(32,sub) =  mean([Data.subject{1,sub}.vestibular.session1.comfortableWithTask,Data.subject{1,sub}.vestibular.session2.comfortableWithTask,Data.subject{1,sub}.vestibular.session3.comfortableWithTask]);            
        Matrix(33,sub) =  mean([Data.subject{1,sub}.vestibular.session1.platformRelevantInfo,Data.subject{1,sub}.vestibular.session2.platformRelevantInfo,Data.subject{1,sub}.vestibular.session3.platformRelevantInfo]);      
        Matrix(34,sub) =  mean([Data.subject{1,sub}.vestibular.session1.platformSignalProminent,Data.subject{1,sub}.vestibular.session2.platformSignalProminent,Data.subject{1,sub}.vestibular.session3.platformSignalProminent]);
        
        % only in vestibular
        Matrix(35,sub) =  mean([Data.subject{1,sub}.vestibular.session1.focusOnPlatform,Data.subject{1,sub}.vestibular.session2.focusOnPlatform,Data.subject{1,sub}.vestibular.session3.focusOnPlatform]);
        
    end
    
    % calcualte difference Matrix
    DiffMatrix = Matrix([7:14],:)- Matrix([27:34],:);

    % kick bad subjects 
    kickDueToRecordings = [2,26]; 
    kickDueToHighErrors = [15,16,17,18,28]; 
    kick = [kickDueToRecordings,kickDueToHighErrors];
    DiffMatrix(:,kick) = [];
    
    % transpose and then zscore Matrix
    DiffMatrix = DiffMatrix';
    DiffMatrix = zscore(DiffMatrix);

    % calcualte principle components
    [coefs,scores,variances,t] = princomp(DiffMatrix);    
    percent_explained = 100*variances/sum(variances)        
    out = scores(:,1:8); 
    
    % get minimum of weights
    minimum = abs(min(out));
    
    % normalize  weights 
    for comp = 1:size(out,2)  
      out(:,comp) = out(:,comp) + minimum(comp);        
      maxi = max(out(:,comp));          
      out2(:,comp) = out(:,comp) / maxi;     
    end  

   % save weights 
   PCAweights = out2;
   save ('Z:\nbp\refbelt\Platform\results\matData\PCAweights.mat', 'PCAweights') 

end

