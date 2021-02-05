function  variance_model_comparison_final( )

    clear all
    clc
    
    %1= tac
    %2= vest
    %3= bim

 if ispc
     load 'Z:\nbp\projects\refbelt\Platform\results\matData\Output_glm.mat'; %Windows  
     load 'Z:\nbp\projects\refbelt\Platform\results\matData\PCAweights.mat'; %Windows
 else
    load '/net/store/nbp/refbelt/Platform/results/matData/Output_glm.mat'; %linux
    load '/net/store/nbp/refbelt/Platform/results/matData/PCAweights.mat'; %linux
 end    

    % remove subject 2 and 26, wrong condition, kick others due to high uncertainty, 
    MeasurementError = Output(:,:,4) ;
    upperTresh =  mean(MeasurementError)+ (2*std(MeasurementError));
    kicktac= [find(MeasurementError(:,1)>upperTresh(1,1))];
    kickvest= [find(MeasurementError(:,2)>upperTresh(1,2))];
    kickbim= [find(MeasurementError(:,3)>upperTresh(1,3))];
    kickall = sort([kicktac;kickvest;kickbim]');    
    Output(kickall,:,:) = [];


    N = length(Output);
    StandartDev =  Output(:,:,2);
    Variance =  StandartDev.^2;
    Reliability = 1./Variance;
    Observed_Variance = Variance(:,3); 
    Uncertainty_tresh =  Output(:,:,4);   
    Uncertainty_Variance = (2*StandartDev).*Uncertainty_tresh;   
    obv_weight1 = Reliability(:,1) ./ (Reliability(:,1) +Reliability(:,2)); 
    obv_weight2 = Reliability(:,2) ./ (Reliability(:,1) +Reliability(:,2));
    Mu = Output(:,:,1);
    MuSquared= Mu.^2;
    Term1_tac = Variance(:,1)+MuSquared(:,1);
    Term1_vest = Variance(:,2)+MuSquared(:,2);  
    const = log(cumprod((1./(2.*pi.*Uncertainty_Variance(:,3))).^0.5 ));
    const = const(end);
    k = N-1;
    
   %%   Difference between Conditions plot
  
    Mean_overSubjects = squeeze(mean(Output));
    SEM_overSubjects = squeeze(std(Output))./ sqrt(length(Output));
    figure;
    hold on 
    bar1 = bar(Mean_overSubjects(:,2));   
    set(bar1(1),'FaceColor',[0.313725501298904 0.313725501298904 0.313725501298904]);
    errorb(Mean_overSubjects(:,2),SEM_overSubjects(:,2),'Linewidth',3,'top');     
    set(gca,'XTick', [1,2,3],'XTickLabel',{'Tactile','Vestibular','Bimodal'},'FontSize',16)%,'FontWeight','bold')
    ylabel('Variance [deg]')
    xlim([0.5 3.5])
    ylim([25 40])
     
    
    %% Static Model      
    staticModel(1:N,1) = mean(Observed_Variance);  
    chi_static = sum(((Observed_Variance-staticModel).^2)./Uncertainty_Variance(:,3).^2);   
    red_chi_static = chi_static / k;   
    loglikelihood_static = const-0.5*chi_static;
    AIC_static = 2*k - 2*loglikelihood_static;
  
    figure
    hold on
    errorbar(staticModel,Observed_Variance,Uncertainty_Variance(:,3), 'k*','LineWidth',2)
     line([0, 5000],[0, 5000],'LineStyle','--','Color','g','LineWidth',3)
    set(gca,'XTick',[0:500:4000],'YTick',[0:500:4000],'FontSize',16)
    %xlabel('Predicted Varaince')
    %ylabel('Observed Varaince')
   %title(strcat('MODEL:STATIC, reduced-Chi²:', num2str(red_chi_static)))
    xlim([0 4000])
    ylim([0 4000])      
    
    %% MLE Model   
    MLE_Variance = (Variance(:,1).*Variance(:,2)) ./  (Variance(:,1)+Variance(:,2));  
    chi_mle = sum(((Observed_Variance-MLE_Variance).^2)./Uncertainty_Variance(:,3).^2);  
    red_chi_mle = chi_mle / k;  
    loglikelihood_mle= const- 0.5*chi_mle;
    AIC_mle = 2*k - 2*loglikelihood_mle;  
      
    figure
    hold on
    errorbar(MLE_Variance,Observed_Variance,Uncertainty_Variance(:,3), 'k*','LineWidth',2)
     line([0, 4000],[0, 4000],'LineStyle','--','Color','g','LineWidth',3)
    set(gca,'XTick',[0:500:4000],'FontSize',16,'YTick',[0:500:4000],'FontSize',16)%, 'FontWeight', 'bold')
   % xlabel('Predicted JND')
   % ylabel('Observed JND')
   % title(strcat('MODEL:MLE, reduced-Chi²:',num2str(red_chi_mle)),'FontSize',14)
    legend('boxoff')
    xlim([0 4000])
    ylim([0 4000])


    %% Bayesian Alternation model
  
    BAM_Variance = ((obv_weight1.*Term1_tac) + (obv_weight2.*Term1_vest))-(((obv_weight1.*Mu(:,1))+(obv_weight2.*Mu(:,2))).^2);    
    chi_bam = sum(((Observed_Variance-BAM_Variance).^2)./Uncertainty_Variance(:,3).^2); 
    red_chi_bam = chi_bam / k; 
    loglikelihood_bam= const- 0.5*chi_bam;
    AIC_bam = 2*k - 2*loglikelihood_bam;  

    figure
    hold on
    errorbar(BAM_Variance,Observed_Variance,Uncertainty_Variance(:,3), 'k*','LineWidth',2)  
    line([0, 4000],[0, 4000],'LineStyle','--','Color','g','LineWidth',3)
    set(gca,'XTick',[0:500:4000],'YTick',[0:500:4000],'FontSize',16)%, 'FontWeight', 'bold')
    %xlabel('Predicted JND')
    %ylabel('Observed JND')
   % title(strcat('MODEL:BAM, reduced-Chi²:', num2str(red_chi_bam)),'FontSize',14)
    xlim([0 4000])
    ylim([0 4000])
    

    %% Bayesian Alternation model with questionnaire Data and PCA weights    
    weight_tactile = PCAweights(:,1);
    weight_vestibular = 1-weight_tactile;
    BAMSQ_Variance = ((weight_tactile.*Term1_tac) + (weight_vestibular.*Term1_vest))-(((weight_tactile.*Mu(:,1))+(weight_vestibular.*Mu(:,2))).^2);     
    chi_bamsq = sum(((Observed_Variance-BAMSQ_Variance).^2)./Uncertainty_Variance(:,3).^2);  
    red_chi_bamsq = chi_bamsq / k;  
    loglikelihood_bamsq = const- 0.5*chi_bamsq;
    AIC_bamsq = 2*k - 2*loglikelihood_bamsq;    

    % plot     
    figure
    hold on
    errorbar(BAMSQ_Variance ,Observed_Variance,Uncertainty_Variance(:,3), 'k*','LineWidth',2)
    line([0, 4000],[0, 4000],'LineStyle','--','Color','g','LineWidth',3)
   % title(strcat('MODEL:BAM-SUBJECTIVE, reduced-Chi²:',num2str(red_chi_bamsq)),'FontSize',14)
    set(gca,'XTick',[0:500:4000],'YTick',[0:500:4000],'FontSize',16)%, 'FontWeight', 'bold')
    xlabel('Predicted JND')
    ylabel('Observed JND')
    xlim([0 4000])
    ylim([0 4000])
   
    
   %% compare AIC's
   modelAICs = [AIC_static,AIC_mle,AIC_bam,AIC_bamsq];
   minAIC = min(modelAICs);
   modelAICs(find(modelAICs==minAIC)) = [];
   Deltas = nan(1,length(modelAICs)+1);
   
   for model =1:length(modelAICs)  
    Deltas(1,model) = modelAICs(model) - minAIC;
   end
   Deltas(end) = 0;
   
   AkaikeWeights = nan(1,length(Deltas));
   sumAllDeltas  = sum(exp(-Deltas(:)/2));
   
   for model =1:length(Deltas)
    AkaikeWeights(1,model) = exp(-Deltas(model)/2) /  sumAllDeltas;
   end
   
    figure
    hold on
    bar(AkaikeWeights)
    set(gca,'XTick',[1,2,3,4], 'XTickLabel',{'Static','MLE','Alternation-Obj','Alternation-Subj'})
    xlabel('Models')  
    ylabel('Probability (%)')
    title(strcat('Model Comaprison with Akaike Weights'));

   
   
 
   %%    find optimal weights
    BestWeights = nan(101,1,N);
    BestWeights2 = nan(2,N);
    
    for subj = 1:N
        obvVar = Observed_Variance(subj);
        temp_Term1_tac = Term1_tac(subj); 
        temp_Term1_vest = Term1_vest(subj); 
        temp_Mu = Mu(subj,:); 
        count = 0;
        for i = 0.00:0.01:1
          count = count +1;
          weight_tactile = i; 
          weight_vestibular = 1-i;
          Alternation_Variance = ((weight_tactile.*temp_Term1_tac) + (weight_vestibular.*temp_Term1_vest))-(((weight_tactile.*temp_Mu(:,1))+(weight_vestibular.*temp_Mu(:,2))).^2);
          BestWeights(count,1,subj) = abs(Alternation_Variance-obvVar);

          weight_tactile = 1-i; 
          weight_vestibular = i;
          Alternation_Variance = ((weight_tactile.*temp_Term1_tac) + (weight_vestibular.*temp_Term1_vest))-(((weight_tactile.*temp_Mu(:,1))+(weight_vestibular.*temp_Mu(:,2))).^2);
          BestWeights(count,2,subj) = abs(Alternation_Variance-obvVar);
          
        end
        
        BestWeights2(1,subj) = find(BestWeights(:,1,subj)==min(BestWeights(:,1,subj)))-1;
        BestWeights2(2,subj) = find(BestWeights(:,2,subj)==min(BestWeights(:,2,subj)))-1;
    end
    
     BestWeights3 = BestWeights2'/100;
     optimal_tactile = BestWeights3(:,1); 
     optimal_vestibular = 1-optimal_tactile;     
     Alternation_Variance = ((optimal_tactile.*Term1_tac) + (optimal_vestibular.*Term1_vest))-(((optimal_tactile.*Mu(:,1))+(optimal_vestibular.*Mu(:,2))).^2);
     
     
     chi_absOptimum = sum(((Observed_Variance-Alternation_Variance).^2)./Uncertainty_Variance(:,3).^2);  
     red_chi_absOptimum = chi_absOptimum / k; 
   
    figure
    hold on
    errorbar(BAM_Variance,Observed_Variance,Uncertainty_Variance(:,3), 'b*','LineWidth',2)  
    line([0, 4000],[0, 4000],'LineStyle','--','Color','g','LineWidth',3)
    set(gca,'XTick',[0:500:2000],'YTick',[0:1000:4000],'FontSize',18)
    xlabel('Predicted Variance')
    ylabel('Observed Variance')  
    title(strcat('MODEL:OPTIMAL, reduced-Chi²:', num2str(red_chi_absOptimum)))
    xlim([0 2000])
    ylim([0 4000])
    
    %% Compare to optimal
    
    [b,~,~,~,stats] = regress(optimal_tactile,[PCAweights(:,1),ones(N,1)]);
    figure
    plot(PCAweights(:,1),optimal_tactile, 'b*','LineWidth',3)
    %title(strcat('CORR:Optimal-Subjective, R²:', num2str(stats(1))))
    line([0 max(PCAweights(:,1))], [b(2) (max(PCAweights(:,1))*b(1))+b(2)], 'Color', 'g','LineWidth',3);
    set(gca,'XTick',[0:0.25:1],'YTick',[0:0.25:1],'FontSize',16)
    xlabel('Subjective (Questionnaire)')
    ylabel('Best Possible')
    xlim([-0.3 1.2])
    ylim([-0.2 1.2])
    %legend('Tactile Weights', 'Fit',3)



    [b,~,~,~,stats] = regress(optimal_tactile,[obv_weight1,ones(N,1)]);
    figure
    plot(obv_weight1,optimal_tactile, 'b*','LineWidth',3)
   % title(strcat('CORR:Optimal-Objective, R²:', num2str(stats(1))))
    line([(min(obv_weight1(:,1))) max(obv_weight1(:,1))], [b(2) (max(obv_weight1(:,1))*b(1))+b(2)], 'Color', 'g','LineWidth',3);
    set(gca,'XTick',[0:0.25:1],'YTick',[0:0.25:1],'FontSize',16)
    xlabel('Objective (Measured)')
    ylabel('Best Possible')
    xlim([-0.3 1.2])
    ylim([-0.2 1.2])
    legend('Tactile Weights', 'Fit',1)  

    
end

