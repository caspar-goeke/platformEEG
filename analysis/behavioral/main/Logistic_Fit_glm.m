function Logistic_Fit_glm ()

    clear
    clc
    
    %path = '/net/store/nbp/refbelt/Platform/'; %Linux
    %files =dir(strcat(path,'fitting_data/'));%Linux
    path = 'Z:\nbp\projects\refbelt\PlatformEEG\'; %Windows
    files =dir(strcat(path,'data\psychometric\')); %Windows

    N = (length(files)-2)/3; 
    angleConditions = [-56.25:11.25:56.25];
    Output= zeros(N,3,4); % subject; tactile, vestibular, bimodal;  bias, treshhold, uncertainty bias, uncertainty treshhold   
    NTrials = 30;  
    midPoint = 50;
    n = repmat([NTrials],11,1);  
    [a,var]  = binostat(NTrials,0.5);
    higherStd = round(binocdf(NTrials/2+sqrt(var),NTrials,0.5)*100); % one standard deviation in binominal distribution 
    lowerStd = 100-higherStd;

    for subject = 1:N
        count = (subject*3)-2;

        loadi = strcat(path,'data\psychometric\',files(count+2,1).name); 
        %loadi = strcat(path,'fitting_data/',files(count+2,1).name); %Linux
        bim =load(loadi); 
        y_bim = (((bim.probabilityChooseFix)/100)*NTrials)';
        [p_bim,dev,stats_bim]= glmfit(angleConditions,[y_bim n],'binomial','link','logit');
        [yfit_bim,dylo_bim,dyhi_bim]= glmval(p_bim, angleConditions,'logit',stats_bim,'size', n, 'constant', 'on');
        
        loadi = strcat(path,'data\psychometric\',files(count+3,1).name); 
        %loadi = strcat(path,'fitting_data/',files(count+3,1).name); %Linux
        tac =load(loadi); 
        y_tac = (((tac.probabilityChooseFix)/100)*NTrials)';
        [p_tac,dev,stats_tac]= glmfit(angleConditions,[y_tac n],'binomial','link','logit');
        [yfit_tac,dylo_tac,dyhi_tac]= glmval(p_tac, angleConditions,'logit',stats_tac,'size', n, 'constant', 'on');
        
        loadi = strcat(path,'data\psychometric\',files(count+4,1).name);
        %loadi = strcat(path,'fitting_data/',files(count+4,1).name); %Linux
        vest= load(loadi); 
        y_vest = (((vest.probabilityChooseFix)/100)*NTrials)';
        [p_vest,dev,stats_vest]= glmfit(angleConditions,[y_vest n],'binomial','link','logit');
        [yfit_vest,dylo_vest,dyhi_vest]= glmval(p_vest, angleConditions,'logit',stats_vest,'size', n, 'constant', 'on');

        % initialize x vecotors
        bimAll = nan(1,100);
        tacAll = nan(1,100);
        vestAll = nan(1,100);
                                 
        % Xb = log(µ/(1 – µ)) --> solved to X 
        % X(i) = log(i-1)/-beta(2) - beta(1)/beta(2)  
        for i = 1:100
            bimAll(i) =  (log((100/i)-1) /(-p_bim(2)))  -(p_bim(1)/p_bim(2));                        
            tacAll(i) =  (log((100/i)-1) /(-p_tac(2))) -(p_tac(1)/p_tac(2));
            vestAll(i) =  (log((100/i)-1) /(-p_vest(2))) -(p_vest(1)/p_vest(2));
        end   
        
         for i = 1:100        
             % x1 = (log(a) /-b) - (x/b)  --> solved to p_bim(1)
             % x2 = (log(a) /-x) -(b/x)  --> solved to p_bim(2)   

             % derivatives
             dx1_bim = -1 /p_bim(2);
             dx2_bim = ((log((100/i)-1))/p_bim(2)^2) + (p_bim(1)/p_bim(2)^2);
             dx1_tac = -1 /p_tac(2);
             dx2_tac = ((log((100/i)-1))/p_tac(2)^2) + (p_tac(1)/p_tac(2)^2);
             dx1_vest = -1 /p_vest(2);
             dx2_vest = ((log((100/i)-1))/p_vest(2)^2) + (p_vest(1)/p_vest(2)^2);

             % jacobian matrix
             jacobi_bim = [dx1_bim,dx2_bim];
             jacobi_tac = [dx1_tac,dx2_tac]; 
             jacobi_vest = [dx1_vest,dx2_vest]; 

             % uncertainty
             Err_bim(i) = sqrt(jacobi_bim * stats_bim.covb  * jacobi_bim');
             Err_tac(i) = sqrt(jacobi_tac * stats_tac.covb  * jacobi_tac');
             Err_vest(i) = sqrt(jacobi_vest * stats_vest.covb  * jacobi_vest');        
         end
         
        % get X value for intercerpt and  standard deviation, and uncertainty
        % for the stardard deviation
        tac_zero = tacAll(midPoint);
        tac_treshold = (abs(tacAll(lowerStd)) + abs(tacAll(higherStd)))/2;
        vest_zero = vestAll(midPoint);
        vest_treshold = (abs(vestAll(lowerStd)) + abs(vestAll(higherStd)))/2;
        bim_zero = bimAll(midPoint);
        bim_treshold = (abs(bimAll(lowerStd)) + abs(bimAll(higherStd)))/2; 
        
        bim_uncertainty = (Err_bim(lowerStd) + Err_bim(higherStd)) /2;
        tac_uncertainty = (Err_tac(lowerStd) + Err_tac(higherStd)) /2;
        vest_uncertainty = (Err_vest(lowerStd) + Err_vest(higherStd)) /2;       
        bim_uncertainty_zero = Err_bim(midPoint);
        tac_uncertainty_zero = Err_tac(midPoint);
        vest_uncertainty_zero = Err_vest(midPoint);

        % save it to Output matrix
        Output(subject,1,1) = tac_zero;
        Output(subject,2,1) = vest_zero;
        Output(subject,3,1) = bim_zero;        
        Output(subject,1,2) = tac_treshold;
        Output(subject,2,2) = vest_treshold;
        Output(subject,3,2) = bim_treshold;
        Output(subject,1,3) = bim_uncertainty_zero;
        Output(subject,2,3) = tac_uncertainty_zero;
        Output(subject,3,3) = vest_uncertainty_zero;        
        Output(subject,1,4) = tac_uncertainty;
        Output(subject,2,4) = vest_uncertainty;
        Output(subject,3,4) = bim_uncertainty;

        
        h= figure;
        hold on
        plot(angleConditions, (y_tac./n)*100,'go','LineWidth',3)
        plot(tacAll,[1:100],'r-','LineWidth',3)
        plot(angleConditions,((yfit_tac./n)-(dylo_tac./n))*100,'r--','LineWidth',3)       
        line([-70,70], [higherStd ,higherStd])
        plot(angleConditions,((yfit_tac./n)+(dyhi_tac./n))*100,'r--','LineWidth',3)
        line([tacAll(higherStd ), tacAll(higherStd )], [0,90])
        line([-70,70], [lowerStd ,lowerStd ])
        line([tacAll(lowerStd), tacAll(lowerStd)], [0,90])
        line([-70,70], [midPoint,midPoint])
        line([tac_zero,tac_zero], [0,90])        
        xlim([-100  100])       
        ylim([0 120])
        set(gca,'XTick',[-100:20:100],'YTick',[-100:20:100],'FontSize',16)
        xlabel('Angluar Difference Ref - Comp Angle (°)','FontSize',16)
        ylabel('Probability to Choose Ref Angle (%)','FontSize',16)
        legend('Data','Fit','Fit-Confidence', 'Treshholds', 'Location','northwest')
        legend boxoff
        
       % title(strcat('Tactile Treshold:',num2str(tac_treshold)),'FontSize',15);      
        if subject < 10
            filename = strcat(path,'result_figures\fitted_with_GLM\','subject_0',num2str(subject),'_tactile.png');
            %filename = strcat(path,'results/FittedGLM/','subject_0',num2str(subject),'_tactile.png'); %Linux
        else
            filename = strcat(path,'result_figures\fitted_with_GLM\','subject_',num2str(subject),'_tactile.png');
            %filename = strcat(path,'results/FittedGLM/','subject_',num2str(subject),'_tactile.png'); %Linux
        end
        print(h,'-dpng',filename)
        close all  


        h= figure;
        hold on
        plot(angleConditions, (y_vest./n)*100,'go','LineWidth',3)
        plot(vestAll,[1:100],'r-','LineWidth',3)
        plot(angleConditions,((yfit_vest./n)-(dylo_vest./n))*100,'r--','LineWidth',3)       
        line([-70,70], [higherStd ,higherStd])
        plot(angleConditions,((yfit_vest./n)+(dyhi_vest./n))*100,'r--','LineWidth',3)
        line([vestAll(higherStd ), vestAll(higherStd )], [0,90])
        line([-70,70], [lowerStd ,lowerStd ])
        line([vestAll(lowerStd), vestAll(lowerStd)], [0,90])
        line([-70,70], [midPoint,midPoint])
        line([vest_zero,vest_zero], [0,90])        
        xlim([-100  100])       
        ylim([0 120])
        xlabel('Angluar Difference Ref - Comp Angle','FontSize',16)
        ylabel('Probability to Choose Ref Angle ','FontSize',16)
        legend('Data','Fit','Fit-Confidence', 'Teshholds', 'Location','northwest')
        legend boxoff
        set(gca,'XTick',[-100:20:100],'YTick',[-100:20:100],'FontSize',16)
       % title(strcat('Vestibular Treshold:',num2str(vest_treshold)),'FontSize',15);      
        if subject < 10
            filename = strcat(path,'result_figures\fitted_with_GLM\','subject_0',num2str(subject),'_vestibular.png');
            %filename = strcat(path,'results/FittedGLM/','subject_0',num2str(subject),'_vestibular.png'); %Linux
        else
            filename = strcat(path,'result_figures\fitted_with_GLM\','subject_',num2str(subject),'_vestibular.png');
            %filename = strcat(path,'results/FittedGLM/','subject_',num2str(subject),'_vestibular.png'); %Linux
        end
        print(h,'-dpng',filename)
        close all  


        h= figure;
        hold on
        plot(angleConditions, (y_bim./n)*100,'go','LineWidth',3)
        plot(bimAll,[1:100],'r-','LineWidth',3)
        plot(angleConditions,((yfit_bim./n)-(dylo_bim./n))*100,'r--','LineWidth',3)       
        line([-70,70], [higherStd ,higherStd])
        plot(angleConditions,((yfit_bim./n)+(dyhi_bim./n))*100,'r--','LineWidth',3)
        line([bimAll(higherStd ), bimAll(higherStd )], [0,90])
        line([-70,70], [lowerStd ,lowerStd ])
        line([bimAll(lowerStd), bimAll(lowerStd)], [0,90])
        line([-70,70], [midPoint,midPoint])
        line([bim_zero,bim_zero], [0,90])        
        xlim([-100  100])       
        ylim([0 120])
        xlabel('Angluar Difference Ref - Comp Angle','FontSize',16)
        ylabel('Probability to Choose Ref Angle','FontSize',16)
        legend('Data','Fit','Fit-Confidence', 'Teshholds', 'Location','northwest')
        legend boxoff
        set(gca,'XTick',[-100:20:100],'YTick',[-100:20:100],'FontSize',16)
       % title(strcat('Bimodal Treshold:',num2str(bim_treshold)),'FontSize',15);      
        if subject < 10
            filename = strcat(path,'result_figures\fitted_with_GLM\','subject_0',num2str(subject),'_bimodal.png');
            %filename = strcat(path,'results/FittedGLM/','subject_0',num2str(subject),'_bimodal.png'); %Linux
        else
           filename = strcat(path,'result_figures\fitted_with_GLM\','subject_',num2str(subject),'_bimodal.png');
           %filename = strcat(path,'results/FittedGLM/','subject_',num2str(subject),'_bimodal.png'); %Linux
        end
        print(h,'-dpng',filename)
        close all  

    end

  savepath = strcat(path,'data\matData\Output_glm.mat');
  %savepath = strcat(path,'results/matData/Output_glm.mat');%Linux
  save(savepath,'Output'); 
  
end




