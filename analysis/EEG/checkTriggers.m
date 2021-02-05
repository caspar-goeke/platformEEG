
k = 0;
i = 1;
tockeck = '128';
while i<=length(EEG.event)
    EEG.event(i).type
    if strcmp(EEG.event(i).type,tockeck)
        k = k+1;
    end
    i = i+1;
end

%  time difference between treiggers
 one = 564;
 two = 565;
(EEG.event(two).latency-EEG.event(one).latency) /256 *1000;