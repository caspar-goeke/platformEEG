clear
clc

% 1 = vestibular;
% 2 = tactile;
% 3 = bimodal;

% add all the paths needed
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/eeglab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/libeep-3.3.171/mex/matlab');
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/eeglab13_4_4b/');
eeglab;
addpath('/net/store/nbp/projects/refbelt/PlatformEEG/');

path_data = '/net/store/nbp/projects/refbelt/PlatformEEG/data/preprocessed_eeg/';
path_plots = '/net/store/nbp/projects/refbelt/PlatformEEG/results/';


%% load data 
% load data with triggers renamed and checked

EEG = pop_loadset('filename','32_session3_block3_HPfilter_renameTrg.set','filepath',path_data);
eeglab redraw



%% latency firt OFF of the platform
% latency trigger #32

k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'33'))
        if (~strcmp(EEG.event(i-1).type,'17'))
            k = k+1;
            latency_first_off(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_first_off = nanmean(latency_first_off);
std_latency_first_off = nanstd(latency_first_off);
min_latency_first_off = min(latency_first_off);
max_latency_first_off = max(latency_first_off);

fig = figure;
histogram(latency_first_off,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency First Platform Off');

filename = strcat(path_plots,'latency_first_off/','32_session3_block1_frst_Off','.png')
print(fig',filename,'-dpng')
close all


%% latency second ON of the platform
% latency trigger #17

k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'17'))
        if (~strcmp(EEG.event(i-1).type,'17'))
            k = k+1;
            latency_second_on(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_second_on = nanmean(latency_second_on);
std_latency_second_on = nanstd(latency_second_on);
min_latency_second_on = min(latency_second_on);
max_latency_second_on = max(latency_second_on);

fig = figure;
histogram(latency_second_on,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency Second Platform On');

filename = strcat(path_plots,'latency_second_on/','32_session3_block3_second_On','.png')
print(fig',filename,'-dpng')
close all



%% latency second OFF of the platform 
% latency of trigger #33
% (from the second start --> trigger #17)

k = 0;
for i = 2:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'33'))
        if (strcmp(EEG.event(i-1).type,'17'))
            k = k+1;
            latency_second_off(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_second_off = nanmean(latency_second_off);
std_latency_second_off = nanstd(latency_second_off);
min_latency_second_off = min(latency_second_off);
max_latency_second_off = max(latency_second_off);

fig = figure;
histogram(latency_second_off,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency Second Platform Off');

filename = strcat(path_plots,'latency_second_off/','32_session3_block1_second_Off','.png')
print(fig',filename,'-dpng')
close all



%% latency answers
% latency of trigger #128
% (from the second off ot the platform --> trigger #33)


k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'128'))
        if (~strcmp(EEG.event(i-1).type,'128'))
            k = k+1;
            latency_answers(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000;
        end
    end
end

mean_latency_answers = nanmean(latency_answers);
std_latency_answers = nanstd(latency_answers);
min_latency_answers = min(latency_answers);
max_latency_answers = max(latency_answers);
median_latency_answers =median(latency_answers);


fig = figure;
histogram(latency_answers,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Answers Latency');

filename = strcat(path_plots,'latency_answers/','32_session3_block1_answers','.png')
print(fig',filename,'-dpng')
close all


%coolResponseTime = doStupidStuff(respTimes)


%% latency (next/first) ON of the platform
% latency of trigger #16
% (from the answer of the previous trial --> trigger #128)

k = 0;
for i = 2:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'16'))
        if (~strcmp(EEG.event(i-2).type,'16'))
            k = k+1;
            latency_first_on(1,k) = (EEG.event(i).latency - EEG.event(i-2).latency) /256 *1000; % in ms
        end
    end
end

mean_latency_first_on = nanmean(latency_first_on);
std_latency_first_on = nanstd(latency_first_on);
min_latency_first_on = min(latency_first_on);
max_latency_first_on = max(latency_first_on);

fig = figure;
histogram(latency_first_on,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency First Platform On');

filename = strcat(path_plots,'latency_first_on/','32_session3_block1__first_ON','.png')
print(fig',filename,'-dpng')
close all


%% overlap answer & first platform ON
% plot the 2 latency histograms toghether


fig = figure;
h1 = histogram(latency_answers,100);
hold on
h2 = histogram(latency_first_on,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
legend('Answers','Platform ON');
title('Latency Answers & Platform ON');

filename = strcat(path_plots,'latency_answers/','32_session3_block1__answers_vs_on','.png')
print(fig',filename,'-dpng')
close all



%% overlap second OFF & answers
% plot the 2 latency histograms toghether


fig = figure;
h1 = histogram(latency_second_off,100);
hold on
h2 = histogram(latency_answers,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
legend('Platform OFF','Answers');
title('Latency Second OFF Platform & Answers');

filename = strcat(path_plots,'latency_second_off/','32_session3_block1__SecondOff_vs_answers','.png')
print(fig',filename,'-dpng')
close all

