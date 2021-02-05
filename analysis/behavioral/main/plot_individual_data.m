clear all
clc

path = 'Z:\nbp\refbelt\Platform\'; % Windows
%path = '/net/store/nbp/refbelt/Platform/'; %Linux
%path  = '/Volumes/nbp/refbelt/Platform/analysis' %Mac

%files =dir(strcat(path,'combined_tosave\'));
files =dir(strcat(path,'individual_data\'));
N = 28;
Ende  = N*9 +2;
subjects = 3:Ende;
condcount = 0;
sessioncount = 1;
subcount = 1;

performanceTotal = zeros(N,3,3,2);

for subject = subjects          
    %loadi = strcat(path,'combined_tosave\',files(subject,1).name);  
    loadi = strcat(path,'individual_data\',files(subject,1).name); %Linux        
    load(loadi);         
    platform_angles = data(:,2:3)';
    givenAnswer = data(:,1)';
    
    % take out catch reponses
    catchResponses = find(sum(platform_angles)>390);    
    platform_angles(:,catchResponses) = []; 
    givenAnswer(:,catchResponses) = [];
    
    zeroResponses = find(sum(platform_angles)== 292.5); 
    platform_angles(:,zeroResponses) = []; 
    givenAnswer(:,zeroResponses) = [];
       
    firstHalfReponses = zeros(11,5);
    firstHalfAngles = zeros(11,5);    
    secondHalfReponses = zeros(11,5);
    secondtHalfAngles = zeros(11,5);
    
    
    summedAngles = sum(platform_angles);
    start = min(summedAngles);
    ende = max(summedAngles);
    idxcount = 0;
    for i = start:11.25:ende
        idxcount = idxcount+1;
        all = find(summedAngles==i);
        if (length(all)==10)
        firstHalfAngles(idxcount,:) = all(1:5);
        secondHalfAngles(idxcount,:) = all(6:10);
        end
    end
    firstHalfAngles(6,:) = [];
    secondHalfAngles(6,:) = [];
    

   correctAnswer = zeros(1,length(platform_angles));
   performance = zeros(1,length(platform_angles)); 
   for i = 1:length(platform_angles)
       if platform_angles(1,i) > platform_angles(2,i)
           correctAnswer(1,i) = 1;
       else
           correctAnswer(1,i) = 2;
       end           
      if givenAnswer(1,i) ==  correctAnswer(1,i)
           performance(1,i) = 1;
      end
   end
   first = firstHalfAngles(:);
   second = secondHalfAngles(:);
   
   percentCorrectFirst = (sum(performance(first))/50)*100;
   percentCorrectSecond = (sum(performance(second))/50)*100;
    
    condcount = condcount+1;
    if condcount > 3
       sessioncount =sessioncount +1;
       condcount =1;
    end
    
    if sessioncount >3
       subcount = subcount+1; 
       sessioncount=1;
    end
    
    performanceTotal(subcount,condcount,sessioncount,1) = percentCorrectFirst;
    performanceTotal(subcount,condcount,sessioncount,2) = percentCorrectSecond;
     
end

bimodal_indv = squeeze(performanceTotal(:,1,:,:));
tactile_indv = squeeze(performanceTotal(:,2,:,:));
vestibular_indv = squeeze(performanceTotal(:,3,:,:));

savepath1 = strcat(path,'individual_performance_data\bimodal.mat');
savepath2 = strcat(path,'individual_performance_data\tactile.mat');
savepath3 = strcat(path,'individual_performance_data\vestibular.mat');
        
save(savepath1,'bimodal_indv'); 
save(savepath2,'tactile_indv'); 
save(savepath3,'vestibular_indv'); 


