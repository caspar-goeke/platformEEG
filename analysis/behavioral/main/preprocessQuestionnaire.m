function preprocessQuestionnaire()

clear all
close all
clc

%% load data


 load 'Z:\nbp\refbelt\Platform\results\matData\QuestionnaireAnswers_Bimodal.mat'; %Windows
 load 'Z:\nbp\refbelt\Platform\results\matData\QuestionnaireAnswers_Vestibular.mat'; 
 load 'Z:\nbp\refbelt\Platform\results\matData\QuestionnaireAnswers_Tactile.mat'; 
 

Conditions = 3;
Sessions = 3;
N = 31;


path = 'Z:\nbp\refbelt\Platform\'; % mac
files = dir(strcat(path,'metadata\')); % mac


%% create structure

Data = struct();
Data.subject = cell(1,N);

%% fill meta info

for i = 1:N
    
    loadi = strcat(path,'metadata/',files(i+2,1).name);
    load(loadi);   
    Data.subject{1,i}.subjectNr = str2double(files(i+2,1).name(9:10));
    Data.subject{1,i}.age = Age;
    Data.subject{1,i}.gender = Gender;
    Data.subject{1,i}.culture = Culture;
    Data.subject{1,i}.handiness = Handiness;
    Data.subject{1,i}.education = Education;
    Data.subject{1,i}.occupation = Occupation;

end


%% meta data structure
for i = 1:length(Data.subject)
        
      Data.subject{1,i}.bimodal = struct();
      Data.subject{1,i}.vestibular = struct();
      Data.subject{1,i}.tactile = struct();
    
      Data.subject{1,i}.vestibular.session1 = struct();
      Data.subject{1,i}.vestibular.session2 = struct();
      Data.subject{1,i}.vestibular.session3 = struct();         

      Data.subject{1,i}.tactile.session1 = struct();
      Data.subject{1,i}.tactile.session2 = struct();
      Data.subject{1,i}.tactile.session3 = struct();  

      Data.subject{1,i}.bimodal.session1 = struct();
      Data.subject{1,i}.bimodal.session2 = struct();
      Data.subject{1,i}.bimodal.session3 = struct();  

end

%% insert bimodal 
for i = 2:length(QuestionnaireAnswers_Bimodal)
    subjectNr = cell2mat(QuestionnaireAnswers_Bimodal(i,2));
    sessionNr = cell2mat(QuestionnaireAnswers_Bimodal(i,3));

    if sessionNr ==1
            Data.subject{1,subjectNr}.bimodal.session1.feelingWell = cell2mat(QuestionnaireAnswers_Bimodal(i,4));
            Data.subject{1,subjectNr}.bimodal.session1.noiseDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,5));
            Data.subject{1,subjectNr}.bimodal.session1.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,6));
            Data.subject{1,subjectNr}.bimodal.session1.taskTiring = cell2mat(QuestionnaireAnswers_Bimodal(i,7));
            Data.subject{1,subjectNr}.bimodal.session1.taskDifficult = cell2mat(QuestionnaireAnswers_Bimodal(i,8));
            Data.subject{1,subjectNr}.bimodal.session1.taskIntuitive = cell2mat(QuestionnaireAnswers_Bimodal(i,9));
            Data.subject{1,subjectNr}.bimodal.session1.answerConfidence = cell2mat(QuestionnaireAnswers_Bimodal(i,10));
            Data.subject{1,subjectNr}.bimodal.session1.feelComfortable = cell2mat(QuestionnaireAnswers_Bimodal(i,11));
            Data.subject{1,subjectNr}.bimodal.session1.similarTask = cell2mat(QuestionnaireAnswers_Bimodal(i,12));
            Data.subject{1,subjectNr}.bimodal.session1.performedWell = cell2mat(QuestionnaireAnswers_Bimodal(i,13));
            Data.subject{1,subjectNr}.bimodal.session1.strategy = QuestionnaireAnswers_Bimodal(i,14);
            Data.subject{1,subjectNr}.bimodal.session1.beltContinuous = cell2mat(QuestionnaireAnswers_Bimodal(i,15));
            Data.subject{1,subjectNr}.bimodal.session1.beltIntuitive = cell2mat(QuestionnaireAnswers_Bimodal(i,16));
            Data.subject{1,subjectNr}.bimodal.session1.beltRelevantInfo = cell2mat(QuestionnaireAnswers_Bimodal(i,17));
            Data.subject{1,subjectNr}.bimodal.session1.beltSignalProminent = cell2mat(QuestionnaireAnswers_Bimodal(i,18));
            Data.subject{1,subjectNr}.bimodal.session1.beltHelpTask = cell2mat(QuestionnaireAnswers_Bimodal(i,19));
            Data.subject{1,subjectNr}.bimodal.session1.beltMoreSecure = cell2mat(QuestionnaireAnswers_Bimodal(i,20));
            Data.subject{1,subjectNr}.bimodal.session1.beltDistracting = cell2mat(QuestionnaireAnswers_Bimodal(i,21));
            Data.subject{1,subjectNr}.bimodal.session1.beltStrategy = QuestionnaireAnswers_Bimodal(i,22);
            Data.subject{1,subjectNr}.bimodal.session1.platformDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,23));
            Data.subject{1,subjectNr}.bimodal.session1.platformRelevantInfo = cell2mat(QuestionnaireAnswers_Bimodal(i,24));
            Data.subject{1,subjectNr}.bimodal.session1.rotationFeelDizzy = cell2mat(QuestionnaireAnswers_Bimodal(i,25));
            Data.subject{1,subjectNr}.bimodal.session1.platformSignalProminent = cell2mat(QuestionnaireAnswers_Bimodal(i,26));
            Data.subject{1,subjectNr}.bimodal.session1.NrPlatformSpeed = cell2mat(QuestionnaireAnswers_Bimodal(i,27));
            Data.subject{1,subjectNr}.bimodal.session1.platformStrategy = QuestionnaireAnswers_Bimodal(i,28);
            Data.subject{1,subjectNr}.bimodal.session1.beltDominatePerception = cell2mat(QuestionnaireAnswers_Bimodal(i,29));
            Data.subject{1,subjectNr}.bimodal.session1.platformDominatePerception = cell2mat(QuestionnaireAnswers_Bimodal(i,30));
            Data.subject{1,subjectNr}.bimodal.session1.focusOnBelt = cell2mat(QuestionnaireAnswers_Bimodal(i,31));
            Data.subject{1,subjectNr}.bimodal.session1.focusOnPlatform = cell2mat(QuestionnaireAnswers_Bimodal(i,32));
            Data.subject{1,subjectNr}.bimodal.session1.setupComfortable = cell2mat(QuestionnaireAnswers_Bimodal(i,33));            
            
    elseif sessionNr ==2
            Data.subject{1,subjectNr}.bimodal.session2.feelingWell = cell2mat(QuestionnaireAnswers_Bimodal(i,4));
            Data.subject{1,subjectNr}.bimodal.session2.noiseDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,5));
            Data.subject{1,subjectNr}.bimodal.session2.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,6));
            Data.subject{1,subjectNr}.bimodal.session2.taskTiring = cell2mat(QuestionnaireAnswers_Bimodal(i,7));
            Data.subject{1,subjectNr}.bimodal.session2.taskDifficult = cell2mat(QuestionnaireAnswers_Bimodal(i,8));
            Data.subject{1,subjectNr}.bimodal.session2.taskIntuitive = cell2mat(QuestionnaireAnswers_Bimodal(i,9));
            Data.subject{1,subjectNr}.bimodal.session2.answerConfidence = cell2mat(QuestionnaireAnswers_Bimodal(i,10));
            Data.subject{1,subjectNr}.bimodal.session2.feelComfortable = cell2mat(QuestionnaireAnswers_Bimodal(i,11));
            Data.subject{1,subjectNr}.bimodal.session2.similarTask = cell2mat(QuestionnaireAnswers_Bimodal(i,12));
            Data.subject{1,subjectNr}.bimodal.session2.performedWell = cell2mat(QuestionnaireAnswers_Bimodal(i,13));
            Data.subject{1,subjectNr}.bimodal.session2.strategy = QuestionnaireAnswers_Bimodal(i,14);
            Data.subject{1,subjectNr}.bimodal.session2.beltContinuous = cell2mat(QuestionnaireAnswers_Bimodal(i,15));
            Data.subject{1,subjectNr}.bimodal.session2.beltIntuitive = cell2mat(QuestionnaireAnswers_Bimodal(i,16));
            Data.subject{1,subjectNr}.bimodal.session2.beltRelevantInfo = cell2mat(QuestionnaireAnswers_Bimodal(i,17));
            Data.subject{1,subjectNr}.bimodal.session2.beltSignalProminent = cell2mat(QuestionnaireAnswers_Bimodal(i,18));
            Data.subject{1,subjectNr}.bimodal.session2.beltHelpTask = cell2mat(QuestionnaireAnswers_Bimodal(i,19));
            Data.subject{1,subjectNr}.bimodal.session2.beltMoreSecure = cell2mat(QuestionnaireAnswers_Bimodal(i,20));
            Data.subject{1,subjectNr}.bimodal.session2.beltDistracting = cell2mat(QuestionnaireAnswers_Bimodal(i,21));
            Data.subject{1,subjectNr}.bimodal.session2.beltStrategy = QuestionnaireAnswers_Bimodal(i,22);
            Data.subject{1,subjectNr}.bimodal.session2.platformDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,23));
            Data.subject{1,subjectNr}.bimodal.session2.platformRelevantInfo = cell2mat(QuestionnaireAnswers_Bimodal(i,24));
            Data.subject{1,subjectNr}.bimodal.session2.rotationFeelDizzy = cell2mat(QuestionnaireAnswers_Bimodal(i,25));
            Data.subject{1,subjectNr}.bimodal.session2.platformSignalProminent = cell2mat(QuestionnaireAnswers_Bimodal(i,26));
            Data.subject{1,subjectNr}.bimodal.session2.NrPlatformSpeed = cell2mat(QuestionnaireAnswers_Bimodal(i,27));
            Data.subject{1,subjectNr}.bimodal.session2.platformStrategy = QuestionnaireAnswers_Bimodal(i,28);
            Data.subject{1,subjectNr}.bimodal.session2.beltDominatePerception = cell2mat(QuestionnaireAnswers_Bimodal(i,29));
            Data.subject{1,subjectNr}.bimodal.session2.platformDominatePerception = cell2mat(QuestionnaireAnswers_Bimodal(i,30));
            Data.subject{1,subjectNr}.bimodal.session2.focusOnBelt = cell2mat(QuestionnaireAnswers_Bimodal(i,31));
            Data.subject{1,subjectNr}.bimodal.session2.focusOnPlatform = cell2mat(QuestionnaireAnswers_Bimodal(i,32));
            Data.subject{1,subjectNr}.bimodal.session2.setupComfortable = cell2mat(QuestionnaireAnswers_Bimodal(i,33));           
            
    elseif sessionNr ==3
            Data.subject{1,subjectNr}.bimodal.session3.feelingWell = cell2mat(QuestionnaireAnswers_Bimodal(i,4));
            Data.subject{1,subjectNr}.bimodal.session3.noiseDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,5));
            Data.subject{1,subjectNr}.bimodal.session3.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,6));
            Data.subject{1,subjectNr}.bimodal.session3.taskTiring = cell2mat(QuestionnaireAnswers_Bimodal(i,7));
            Data.subject{1,subjectNr}.bimodal.session3.taskDifficult = cell2mat(QuestionnaireAnswers_Bimodal(i,8));
            Data.subject{1,subjectNr}.bimodal.session3.taskIntuitive = cell2mat(QuestionnaireAnswers_Bimodal(i,9));
            Data.subject{1,subjectNr}.bimodal.session3.answerConfidence = cell2mat(QuestionnaireAnswers_Bimodal(i,10));
            Data.subject{1,subjectNr}.bimodal.session3.feelComfortable = cell2mat(QuestionnaireAnswers_Bimodal(i,11));
            Data.subject{1,subjectNr}.bimodal.session3.similarTask = cell2mat(QuestionnaireAnswers_Bimodal(i,12));
            Data.subject{1,subjectNr}.bimodal.session3.performedWell = cell2mat(QuestionnaireAnswers_Bimodal(i,13));
            Data.subject{1,subjectNr}.bimodal.session3.strategy = QuestionnaireAnswers_Bimodal(i,14);
            Data.subject{1,subjectNr}.bimodal.session3.beltContinuous = cell2mat(QuestionnaireAnswers_Bimodal(i,15));
            Data.subject{1,subjectNr}.bimodal.session3.beltIntuitive = cell2mat(QuestionnaireAnswers_Bimodal(i,16));
            Data.subject{1,subjectNr}.bimodal.session3.beltRelevantInfo = cell2mat(QuestionnaireAnswers_Bimodal(i,17));
            Data.subject{1,subjectNr}.bimodal.session3.beltSignalProminent = cell2mat(QuestionnaireAnswers_Bimodal(i,18));
            Data.subject{1,subjectNr}.bimodal.session3.beltHelpTask = cell2mat(QuestionnaireAnswers_Bimodal(i,19));
            Data.subject{1,subjectNr}.bimodal.session3.beltMoreSecure = cell2mat(QuestionnaireAnswers_Bimodal(i,20));
            Data.subject{1,subjectNr}.bimodal.session3.beltDistracting = cell2mat(QuestionnaireAnswers_Bimodal(i,21));
            Data.subject{1,subjectNr}.bimodal.session3.beltStrategy = QuestionnaireAnswers_Bimodal(i,22);
            Data.subject{1,subjectNr}.bimodal.session3.platformDisturbing = cell2mat(QuestionnaireAnswers_Bimodal(i,23));
            Data.subject{1,subjectNr}.bimodal.session3.platformRelevantInfo = cell2mat(QuestionnaireAnswers_Bimodal(i,24));
            Data.subject{1,subjectNr}.bimodal.session3.rotationFeelDizzy = cell2mat(QuestionnaireAnswers_Bimodal(i,25));
            Data.subject{1,subjectNr}.bimodal.session3.platformSignalProminent = cell2mat(QuestionnaireAnswers_Bimodal(i,26));
            Data.subject{1,subjectNr}.bimodal.session3.NrPlatformSpeed = cell2mat(QuestionnaireAnswers_Bimodal(i,27));
            Data.subject{1,subjectNr}.bimodal.session3.platformStrategy = QuestionnaireAnswers_Bimodal(i,28);
            Data.subject{1,subjectNr}.bimodal.session3.beltDominatePerception = cell2mat(QuestionnaireAnswers_Bimodal(i,29));
            Data.subject{1,subjectNr}.bimodal.session3.platformDominatePerception = cell2mat(QuestionnaireAnswers_Bimodal(i,30));
            Data.subject{1,subjectNr}.bimodal.session3.focusOnBelt = cell2mat(QuestionnaireAnswers_Bimodal(i,31));
            Data.subject{1,subjectNr}.bimodal.session3.focusOnPlatform = cell2mat(QuestionnaireAnswers_Bimodal(i,32));
            Data.subject{1,subjectNr}.bimodal.session3.setupComfortable = cell2mat(QuestionnaireAnswers_Bimodal(i,33));      
            
    end
        
end


%% insert vestibular

for i = 2:length(QuestionnaireAnswers_Vestibular)
    subjectNr = cell2mat(QuestionnaireAnswers_Vestibular(i,2));
    sessionNr = cell2mat(QuestionnaireAnswers_Vestibular(i,3));
   
    if sessionNr ==1
            Data.subject{1,subjectNr}.vestibular.session1.setupComfortable = cell2mat(QuestionnaireAnswers_Vestibular(i,4));
            Data.subject{1,subjectNr}.vestibular.session1.noiseDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,5));
            Data.subject{1,subjectNr}.vestibular.session1.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,5));
            Data.subject{1,subjectNr}.vestibular.session1.taskTiring = cell2mat(QuestionnaireAnswers_Vestibular(i,7));
            Data.subject{1,subjectNr}.vestibular.session1.taskDifficult = cell2mat(QuestionnaireAnswers_Vestibular(i,8));
            Data.subject{1,subjectNr}.vestibular.session1.taskIntuitive = cell2mat(QuestionnaireAnswers_Vestibular(i,9));
            Data.subject{1,subjectNr}.vestibular.session1.answerConfidence = cell2mat(QuestionnaireAnswers_Vestibular(i,10));
            Data.subject{1,subjectNr}.vestibular.session1.comfortableWithTask = cell2mat(QuestionnaireAnswers_Vestibular(i,11));
            Data.subject{1,subjectNr}.vestibular.session1.similarTask = cell2mat(QuestionnaireAnswers_Vestibular(i,12));
            Data.subject{1,subjectNr}.vestibular.session1.focusOnPlatform = cell2mat(QuestionnaireAnswers_Vestibular(i,13));
            Data.subject{1,subjectNr}.vestibular.session1.platformDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,14));
            Data.subject{1,subjectNr}.vestibular.session1.platformRelevantInfo = cell2mat(QuestionnaireAnswers_Vestibular(i,15));
            Data.subject{1,subjectNr}.vestibular.session1.rotationFeelDizzy = cell2mat(QuestionnaireAnswers_Vestibular(i,16));
            Data.subject{1,subjectNr}.vestibular.session1.platformSignalProminent = cell2mat(QuestionnaireAnswers_Vestibular(i,17));
            Data.subject{1,subjectNr}.vestibular.session1.NrPlatformSpeed = cell2mat(QuestionnaireAnswers_Vestibular(i,18));
            Data.subject{1,subjectNr}.vestibular.session1.strategy = QuestionnaireAnswers_Vestibular(i,19);
            Data.subject{1,subjectNr}.vestibular.session1.platformStrategy = QuestionnaireAnswers_Vestibular(i,20);
            Data.subject{1,subjectNr}.vestibular.session1.feelingWell = cell2mat(QuestionnaireAnswers_Vestibular(i,21));    
            Data.subject{1,subjectNr}.vestibular.session1.performedWell = cell2mat(QuestionnaireAnswers_Vestibular(i,22));
            
    elseif sessionNr ==2
            Data.subject{1,subjectNr}.vestibular.session2.setupComfortable = cell2mat(QuestionnaireAnswers_Vestibular(i,4));
            Data.subject{1,subjectNr}.vestibular.session2.noiseDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,5));
            Data.subject{1,subjectNr}.vestibular.session2.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,5));
            Data.subject{1,subjectNr}.vestibular.session2.taskTiring = cell2mat(QuestionnaireAnswers_Vestibular(i,7));
            Data.subject{1,subjectNr}.vestibular.session2.taskDifficult = cell2mat(QuestionnaireAnswers_Vestibular(i,8));
            Data.subject{1,subjectNr}.vestibular.session2.taskIntuitive = cell2mat(QuestionnaireAnswers_Vestibular(i,9));
            Data.subject{1,subjectNr}.vestibular.session2.answerConfidence = cell2mat(QuestionnaireAnswers_Vestibular(i,10));
            Data.subject{1,subjectNr}.vestibular.session2.comfortableWithTask = cell2mat(QuestionnaireAnswers_Vestibular(i,11));
            Data.subject{1,subjectNr}.vestibular.session2.similarTask = cell2mat(QuestionnaireAnswers_Vestibular(i,12));
            Data.subject{1,subjectNr}.vestibular.session2.focusOnPlatform = cell2mat(QuestionnaireAnswers_Vestibular(i,13));
            Data.subject{1,subjectNr}.vestibular.session2.platformDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,14));
            Data.subject{1,subjectNr}.vestibular.session2.platformRelevantInfo = cell2mat(QuestionnaireAnswers_Vestibular(i,15));
            Data.subject{1,subjectNr}.vestibular.session2.rotationFeelDizzy = cell2mat(QuestionnaireAnswers_Vestibular(i,16));
            Data.subject{1,subjectNr}.vestibular.session2.platformSignalProminent = cell2mat(QuestionnaireAnswers_Vestibular(i,17));
            Data.subject{1,subjectNr}.vestibular.session2.NrPlatformSpeed = cell2mat(QuestionnaireAnswers_Vestibular(i,18));
            Data.subject{1,subjectNr}.vestibular.session2.strategy = QuestionnaireAnswers_Vestibular(i,19);
            Data.subject{1,subjectNr}.vestibular.session2.platformStrategy = QuestionnaireAnswers_Vestibular(i,20);
            Data.subject{1,subjectNr}.vestibular.session2.feelingWell = cell2mat(QuestionnaireAnswers_Vestibular(i,21));    
            Data.subject{1,subjectNr}.vestibular.session2.performedWell = cell2mat(QuestionnaireAnswers_Vestibular(i,22));                
            
    elseif sessionNr ==3        
            Data.subject{1,subjectNr}.vestibular.session3.setupComfortable = cell2mat(QuestionnaireAnswers_Vestibular(i,4));
            Data.subject{1,subjectNr}.vestibular.session3.noiseDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,5));
            Data.subject{1,subjectNr}.vestibular.session3.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,5));
            Data.subject{1,subjectNr}.vestibular.session3.taskTiring = cell2mat(QuestionnaireAnswers_Vestibular(i,7));
            Data.subject{1,subjectNr}.vestibular.session3.taskDifficult = cell2mat(QuestionnaireAnswers_Vestibular(i,8));
            Data.subject{1,subjectNr}.vestibular.session3.taskIntuitive = cell2mat(QuestionnaireAnswers_Vestibular(i,9));
            Data.subject{1,subjectNr}.vestibular.session3.answerConfidence = cell2mat(QuestionnaireAnswers_Vestibular(i,10));
            Data.subject{1,subjectNr}.vestibular.session3.comfortableWithTask = cell2mat(QuestionnaireAnswers_Vestibular(i,11));
            Data.subject{1,subjectNr}.vestibular.session3.similarTask = cell2mat(QuestionnaireAnswers_Vestibular(i,12));
            Data.subject{1,subjectNr}.vestibular.session3.focusOnPlatform = cell2mat(QuestionnaireAnswers_Vestibular(i,13));
            Data.subject{1,subjectNr}.vestibular.session3.platformDisturbing = cell2mat(QuestionnaireAnswers_Vestibular(i,14));
            Data.subject{1,subjectNr}.vestibular.session3.platformRelevantInfo = cell2mat(QuestionnaireAnswers_Vestibular(i,15));
            Data.subject{1,subjectNr}.vestibular.session3.rotationFeelDizzy = cell2mat(QuestionnaireAnswers_Vestibular(i,16));
            Data.subject{1,subjectNr}.vestibular.session3.platformSignalProminent = cell2mat(QuestionnaireAnswers_Vestibular(i,17));
            Data.subject{1,subjectNr}.vestibular.session3.NrPlatformSpeed = cell2mat(QuestionnaireAnswers_Vestibular(i,18));
            Data.subject{1,subjectNr}.vestibular.session3.strategy = QuestionnaireAnswers_Vestibular(i,19);
            Data.subject{1,subjectNr}.vestibular.session3.platformStrategy = QuestionnaireAnswers_Vestibular(i,20);
            Data.subject{1,subjectNr}.vestibular.session3.feelingWell = cell2mat(QuestionnaireAnswers_Vestibular(i,21));    
            Data.subject{1,subjectNr}.vestibular.session3.performedWell = cell2mat(QuestionnaireAnswers_Vestibular(i,22));      
    end
    
end


%% insert tactile  

for i = 2:length(QuestionnaireAnswers_Tactile)
    subjectNr = cell2mat(QuestionnaireAnswers_Tactile(i,2));
    sessionNr = cell2mat(QuestionnaireAnswers_Tactile(i,3));  
   
    if sessionNr ==1
            Data.subject{1,subjectNr}.tactile.session1.setupComfortable = cell2mat(QuestionnaireAnswers_Tactile(i,4));
            Data.subject{1,subjectNr}.tactile.session1.noiseDisturbing = cell2mat(QuestionnaireAnswers_Tactile(i,5));
            Data.subject{1,subjectNr}.tactile.session1.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Tactile(i,6));
            Data.subject{1,subjectNr}.tactile.session1.taskTiring = cell2mat(QuestionnaireAnswers_Tactile(i,7));
            Data.subject{1,subjectNr}.tactile.session1.taskDifficult = cell2mat(QuestionnaireAnswers_Tactile(i,8));
            Data.subject{1,subjectNr}.tactile.session1.taskIntuitive = cell2mat(QuestionnaireAnswers_Tactile(i,9));
            Data.subject{1,subjectNr}.tactile.session1.answerConfidence = cell2mat(QuestionnaireAnswers_Tactile(i,10));
            Data.subject{1,subjectNr}.tactile.session1.beltContinuous = cell2mat(QuestionnaireAnswers_Tactile(i,11));
            Data.subject{1,subjectNr}.tactile.session1.beltIntuitive = cell2mat(QuestionnaireAnswers_Tactile(i,12));
            Data.subject{1,subjectNr}.tactile.session1.beltRelevantInfo = cell2mat(QuestionnaireAnswers_Tactile(i,13));
            Data.subject{1,subjectNr}.tactile.session1.usedBeltInfo = cell2mat(QuestionnaireAnswers_Tactile(i,14));
            Data.subject{1,subjectNr}.tactile.session1.beltSignalProminent = cell2mat(QuestionnaireAnswers_Tactile(i,15));
            Data.subject{1,subjectNr}.tactile.session1.beltMoreSecure = cell2mat(QuestionnaireAnswers_Tactile(i,16));
            Data.subject{1,subjectNr}.tactile.session1.beltDistracting = cell2mat(QuestionnaireAnswers_Tactile(i,17));
            Data.subject{1,subjectNr}.tactile.session1.comfortableWithTask = cell2mat(QuestionnaireAnswers_Tactile(i,18));
            Data.subject{1,subjectNr}.tactile.session1.similarTask = cell2mat(QuestionnaireAnswers_Tactile(i,19));
            Data.subject{1,subjectNr}.tactile.session1.performedWell = cell2mat(QuestionnaireAnswers_Tactile(i,20));
            Data.subject{1,subjectNr}.tactile.session1.beltStrategy = QuestionnaireAnswers_Tactile(i,21);
            Data.subject{1,subjectNr}.tactile.session1.feelingWell = cell2mat(QuestionnaireAnswers_Tactile(i,22));
            Data.subject{1,subjectNr}.tactile.session1.strategy = QuestionnaireAnswers_Tactile(i,23);
            Data.subject{1,subjectNr}.tactile.session1.beltHelpTask = cell2mat(QuestionnaireAnswers_Tactile(i,24));         
            
    elseif sessionNr ==2
            Data.subject{1,subjectNr}.tactile.session2.setupComfortable = cell2mat(QuestionnaireAnswers_Tactile(i,4));
            Data.subject{1,subjectNr}.tactile.session2.noiseDisturbing = cell2mat(QuestionnaireAnswers_Tactile(i,5));
            Data.subject{1,subjectNr}.tactile.session2.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Tactile(i,6));
            Data.subject{1,subjectNr}.tactile.session2.taskTiring = cell2mat(QuestionnaireAnswers_Tactile(i,7));
            Data.subject{1,subjectNr}.tactile.session2.taskDifficult = cell2mat(QuestionnaireAnswers_Tactile(i,8));
            Data.subject{1,subjectNr}.tactile.session2.taskIntuitive = cell2mat(QuestionnaireAnswers_Tactile(i,9));
            Data.subject{1,subjectNr}.tactile.session2.answerConfidence = cell2mat(QuestionnaireAnswers_Tactile(i,10));
            Data.subject{1,subjectNr}.tactile.session2.beltContinuous = cell2mat(QuestionnaireAnswers_Tactile(i,11));
            Data.subject{1,subjectNr}.tactile.session2.beltIntuitive = cell2mat(QuestionnaireAnswers_Tactile(i,12));
            Data.subject{1,subjectNr}.tactile.session2.beltRelevantInfo = cell2mat(QuestionnaireAnswers_Tactile(i,13));
            Data.subject{1,subjectNr}.tactile.session2.usedBeltInfo = cell2mat(QuestionnaireAnswers_Tactile(i,14));
            Data.subject{1,subjectNr}.tactile.session2.beltSignalProminent = cell2mat(QuestionnaireAnswers_Tactile(i,15));
            Data.subject{1,subjectNr}.tactile.session2.beltMoreSecure = cell2mat(QuestionnaireAnswers_Tactile(i,16));
            Data.subject{1,subjectNr}.tactile.session2.beltDistracting = cell2mat(QuestionnaireAnswers_Tactile(i,17));
            Data.subject{1,subjectNr}.tactile.session2.comfortableWithTask = cell2mat(QuestionnaireAnswers_Tactile(i,18));
            Data.subject{1,subjectNr}.tactile.session2.similarTask = cell2mat(QuestionnaireAnswers_Tactile(i,19));
            Data.subject{1,subjectNr}.tactile.session2.performedWell = cell2mat(QuestionnaireAnswers_Tactile(i,20));
            Data.subject{1,subjectNr}.tactile.session2.beltStrategy = QuestionnaireAnswers_Tactile(i,21);
            Data.subject{1,subjectNr}.tactile.session2.feelingWell = cell2mat(QuestionnaireAnswers_Tactile(i,22));
            Data.subject{1,subjectNr}.tactile.session2.strategy = QuestionnaireAnswers_Tactile(i,23);
            Data.subject{1,subjectNr}.tactile.session2.beltHelpTask = cell2mat(QuestionnaireAnswers_Tactile(i,24));    
            
    elseif sessionNr ==3
            Data.subject{1,subjectNr}.tactile.session3.setupComfortable = cell2mat(QuestionnaireAnswers_Tactile(i,4));
            Data.subject{1,subjectNr}.tactile.session3.noiseDisturbing = cell2mat(QuestionnaireAnswers_Tactile(i,5));
            Data.subject{1,subjectNr}.tactile.session3.blindfoldedDisturbing = cell2mat(QuestionnaireAnswers_Tactile(i,6));
            Data.subject{1,subjectNr}.tactile.session3.taskTiring = cell2mat(QuestionnaireAnswers_Tactile(i,7));
            Data.subject{1,subjectNr}.tactile.session3.taskDifficult = cell2mat(QuestionnaireAnswers_Tactile(i,8));
            Data.subject{1,subjectNr}.tactile.session3.taskIntuitive = cell2mat(QuestionnaireAnswers_Tactile(i,9));
            Data.subject{1,subjectNr}.tactile.session3.answerConfidence = cell2mat(QuestionnaireAnswers_Tactile(i,10));
            Data.subject{1,subjectNr}.tactile.session3.beltContinuous = cell2mat(QuestionnaireAnswers_Tactile(i,11));
            Data.subject{1,subjectNr}.tactile.session3.beltIntuitive = cell2mat(QuestionnaireAnswers_Tactile(i,12));
            Data.subject{1,subjectNr}.tactile.session3.beltRelevantInfo = cell2mat(QuestionnaireAnswers_Tactile(i,13));
            Data.subject{1,subjectNr}.tactile.session3.usedBeltInfo = cell2mat(QuestionnaireAnswers_Tactile(i,14));
            Data.subject{1,subjectNr}.tactile.session3.beltSignalProminent = cell2mat(QuestionnaireAnswers_Tactile(i,15));
            Data.subject{1,subjectNr}.tactile.session3.beltMoreSecure = cell2mat(QuestionnaireAnswers_Tactile(i,16));
            Data.subject{1,subjectNr}.tactile.session3.beltDistracting = cell2mat(QuestionnaireAnswers_Tactile(i,17));
            Data.subject{1,subjectNr}.tactile.session3.comfortableWithTask = cell2mat(QuestionnaireAnswers_Tactile(i,18));
            Data.subject{1,subjectNr}.tactile.session3.similarTask = cell2mat(QuestionnaireAnswers_Tactile(i,19));
            Data.subject{1,subjectNr}.tactile.session3.performedWell = cell2mat(QuestionnaireAnswers_Tactile(i,20));
            Data.subject{1,subjectNr}.tactile.session3.beltStrategy = QuestionnaireAnswers_Tactile(i,21);
            Data.subject{1,subjectNr}.tactile.session3.feelingWell = cell2mat(QuestionnaireAnswers_Tactile(i,22));
            Data.subject{1,subjectNr}.tactile.session3.strategy = QuestionnaireAnswers_Tactile(i,23);
            Data.subject{1,subjectNr}.tactile.session3.beltHelpTask = cell2mat(QuestionnaireAnswers_Tactile(i,24));    
    end
end

   save ('Z:\nbp\refbelt\Platform\results\matData\QData.mat', 'Data') 

   
   
end

