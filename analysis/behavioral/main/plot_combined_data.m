clear all
clc

path = 'Z:\nbp\projects\refbelt\PlatformEEG\';
%path = '/net/store/nbp/refbelt/Platform/'; %Linux
%path  = '/Volumes/nbp/refbelt/Platform/analysis' %Mac

%files =dir(strcat(path,'combined_data\'));
files =dir(strcat(path,'data\combined\'));
N = 4;
Ende  = N*3 +2;
subjects = 3:Ende;
condcount = 0;
subcount = 1;



%probabilityChooseReference = zeros(11,8,3);

for subject = subjects          
    %loadi = strcat(path,'combined_data\',files(subject,1).name);  
    loadi = strcat(path,'data\combined\',files(subject,1).name); %Linux        
    load(loadi);         
    platform_angles = data(:,2:3)';
    givenAnswer = data(:,1)';
    % take out catch reponses
    catchResponses = find(sum(platform_angles)>390);
    givenAnswerCatch  = givenAnswer(catchResponses);
    
    platform_angles(:,catchResponses) = []; 
    givenAnswer(:,catchResponses) = [];

     % sanity check
    data (:,4:5) = 0;
    for i = 1:length(data)
        if data(i,2) > data(i,3)
        data(i,4)  = 1;
        else
        data(i,4)  = 2;
        end
        if data (i,1) == data (i,4)
            data(i,5) = 1;
        end
    end

    fixed =  ones(1,length(platform_angles));
    for i = 1:length(platform_angles)
        if (platform_angles(2,i)==146.25)
            fixed(1,i) = 2;
        end
    end

    for i = 1:length(platform_angles)
        if fixed(i) ==1
            angleDifference(i) =  platform_angles(2,i)- platform_angles(1,i);
        else
            angleDifference(i) = platform_angles(1,i) - platform_angles(2,i);
        end            
    end


    angleConditions = nan(30,11);   
    condi = 0;
    for i = 56.25:-11.25:-56.25
        condi = condi +1;
        temp = find(angleDifference == i);
        angleConditions(1:length(temp),condi) = temp;                 
    end


    choosefixedAnswer = nan(1,length(givenAnswer));
    for i = 1:length(choosefixedAnswer)
         if (givenAnswer(1,i) == fixed(1,i))
             choosefixedAnswer(1,i) = 1;
         else
             choosefixedAnswer(1,i) = 0;
         end
    end

    for i = 1:11
        probabilityChooseFix(i) = sum(choosefixedAnswer(angleConditions(1:30,i)))/30 *100;   
    end
    
    % here you fill the array
    %probabilityChooseReference(length(probabilityChooseFix),length(subject),:)  = probabilityChooseFix;  
    %probabilityChooseReference(length(subject),1:length(probabilityChooseFix),condi)  = probabilityChooseFix;
    
    condcount = condcount+1;
    if condcount > 3
       subcount = subcount +1;
       condcount = 1;
    end
    
    if condcount ==1 
        condi = 'Bimodal';
    elseif condcount ==2
        condi = 'Tactile';
    elseif condcount ==3
        condi = 'Vestibular';
        
    end
   tit = strcat('Subject_',32,num2str(subcount),32,'Condition',32,condi);

    h=figure; 
    plot(probabilityChooseFix,'*','MarkerSize',14)
    title(tit)
    xlabel('Angular Difference: Reference-Comparism [deg]','FontSize',14,'FontWeight','bold')
    set(gca,'YTick',[0:20:100],'XTick',[1:11],'XTickLabel',{'-56.25';'-45.00';'-33.75';'-22.25';'-11.25';'0';'11.25';'22.25';'33.75';'45.00';'56.25'},'FontSize',10,'FontWeight','bold')
    ylabel('Prob. to choose ref. angle [%]','FontSize',14,'FontWeight','bold')
    ylim ([-10  110])
    xlim ([-0.5  12])
    
    filename = strcat(path,'result_figures\psychometric_behavior\','subject',num2str(subcount),'condition',condi,'.png');
    print(h,'-dpng',filename)
    close all    
    
    if subcount < 10
       if  condcount ==1
           savepath = strcat(path,'data\psychometric\','subject_0',num2str(subcount),'_bimodal.mat');
       elseif  condcount ==2   
           savepath = strcat(path,'data\psychometric\','subject_0',num2str(subcount),'_tactile.mat');
       elseif  condcount ==3       
         savepath = strcat(path,'data\psychometric\','subject_0',num2str(subcount),'_vestibular.mat');
       end
    else
       if  condcount ==1
           savepath = strcat(path,'fitting_data\','subject_',num2str(subcount),'_bimodal.mat');
       elseif  condcount ==2   
           savepath = strcat(path,'fitting_data\','subject_',num2str(subcount),'_tactile.mat');
       elseif  condcount ==3       
         savepath = strcat(path,'fitting_data\','subject_',num2str(subcount),'_vestibular.mat');
       end
    end
        
     save(savepath,'probabilityChooseFix'); 

end

