%% calculate difference offset platform & belt

%%%%%%%%%%%%%  first offset   %%%%%%%%%%%%%

k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'74'))
        if (strcmp(EEG.event(i-1).type,'32'))
            k = k+1;
            latency_diff_first_off(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_diff_first_off = mean(latency_diff_first_off);
std_latency_diff_first_off = std(latency_diff_first_off);
min_latency_diff_first_off = min(latency_diff_first_off);
max_latency_diff_first_off = max(latency_diff_first_off);

fig = figure;
histogram(latency_diff_first_off,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency Difference First Offset');

% filename = strcat(path_plots,'latency_second_on/','32_session3_block3_second_On','.png')
% print(fig',filename,'-dpng')
% close all


%%%%%%%%%%%%%  second offset  %%%%%%%%%%%%%

k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'75'))
        if (strcmp(EEG.event(i-1).type,'33'))
            k = k+1;
            latency_diff_second_off(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_diff_second_off = nanmean(latency_diff_second_off);
std_latency_diff_second_off = nanstd(latency_diff_second_off);
min_latency_diff_second_off = min(latency_diff_second_off);
max_latency_diff_second_off = max(latency_diff_second_off);

fig = figure;
histogram(latency_diff_second_off,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency Difference First Offset');


%% calculate difference onset platform & belt

%%%%%%%%%%%%%  first onset   %%%%%%%%%%%%%

k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'26'))
        if (strcmp(EEG.event(i-1).type,'16'))
            k = k+1;
            latency_diff_first_on(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_diff_first_on = mean(latency_diff_first_on);
std_latency_diff_first_on = std(latency_diff_first_on);
min_latency_diff_first_on = min(latency_diff_first_on);
max_latency_diff_first_on = max(latency_diff_first_on);

fig = figure;
histogram(latency_diff_first_off,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency Difference First Offset');

% filename = strcat(path_plots,'latency_second_on/','32_session3_block3_second_On','.png')
% print(fig',filename,'-dpng')
% close all


%%%%%%%%%%%%%  second onset   %%%%%%%%%%%%%

k = 0;
for i = 1:length(EEG.event)
    
    if (strcmp(EEG.event(i).type,'27'))
        if (strcmp(EEG.event(i-1).type,'17'))
            k = k+1;
            latency_diff_second_on(1,k) = (EEG.event(i).latency - EEG.event(i-1).latency) /256 * 1000; % in ms
        end
    end
end

mean_latency_diff_second_on = mean(latency_diff_second_on);
std_latency_diff_second_on = std(latency_diff_second_on);
min_latency_diff_second_on = min(latency_diff_second_on);
max_latency_diff_second_on = max(latency_diff_second_on);

fig = figure;
histogram(latency_diff_second_on,100);
ylabel('Number of Trials','FontSize',14);
xlabel('Time [ms]','FontSize',14);
title('Latency Difference First Offset');
