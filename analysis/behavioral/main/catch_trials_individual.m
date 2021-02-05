clear all
clc

%path = '/net/store/nbp/refbelt/Platform/';
path = 'Z:\nbp\refbelt\Platform\'; %Windows
files =dir(strcat(path,'combined_data\'));
N = 21;
subjects = [1:3*N]+2;
subjects(2) = [];
condcount = 0;
subcount = 1;
FinalArray = nan(3,N);


for subject = [3:length(files)] % subjects          

    loadi = strcat(path,'combined_data\',files(subject,1).name);         
    load(loadi);         
    platform_angles = data(:,2:3)';
    givenAnswer = data(:,1)';
    
    % clean catch reponses
    normalResponses = find(sum(platform_angles)<350);
    
    platform_angles(:,normalResponses) = [];
    givenAnswer(:, normalResponses) = [];

    %get coorect angles (1 for correct 2 for incoorect)
    correctAnswer = zeros(1,30);
    for i = 1:length(platform_angles)
    
        if platform_angles(1,i) > platform_angles(2,i)
           correctAnswer(1,i) = 1;
        else
           correctAnswer(1,i) = 2;
        end
    
    end
  
    % compare how many matches bewtween given answers and correct angles (0
    % for correct, 1 for wrong)
    matchingAnswer = zeros(1,30);
    
    for i = 1:length(correctAnswer)
        
        if correctAnswer(1,i) == givenAnswer(i)
            matchingAnswer(1,i) = 1; % correct
        else
            matchingAnswer(1,i) = 0; % wrong
        end
    end
         FindCorrectAnswer = sum(matchingAnswer);
         
    
    % divide by 30 (n^ of Catch Trials)
      
        CatchAnswer = ((FindCorrectAnswer/30)*100);
        
    %individual plots
    
     condcount = condcount+1;
    if condcount > 3
       subcount = subcount +1;
       condcount = 1;
    end
    
    FinalArray(condcount,subcount) = CatchAnswer;
 
end



CatchMean(1,1) = mean(FinalArray(1,:));
CatchMean(1,2) = mean(FinalArray(2,:));
CatchMean(1,3) = mean(FinalArray(3,:));

CatchStd(1,1) = std(FinalArray(1,:)) / sqrt(size(FinalArray,2));
CatchStd(1,2) = std(FinalArray(2,:))/ sqrt(size(FinalArray,2));
CatchStd(1,3) = std(FinalArray(3,:))/ sqrt(size(FinalArray,2));

h = figure
errorbar(CatchMean,CatchStd,'*', 'Markersize',5)
ylim ([0 100])
xlim([0.5 3.5])
ylabel('Probability correct answer [%]','FontSize',14,'FontWeight','bold' )
set(gca,'XTick',[1 2 3],'XTickLabel',{'Bimodal';'Tactile';'Vestibular'},'FontSize',14,'FontWeight','bold')
line([0 4],[50 50 ],'Color', 'r')

filename = strcat(path,'results\CatchTrials\Compare_Conditions_On_Catch_Trials.png');
print(h,'-dpng',filename)
close all

%tit = strcat('Subject_',32,num2str(subcount),32,'Catch Trials',32);



