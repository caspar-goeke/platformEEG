function [wrong_field] = sanityCheck( ALLEEG, triggerSeq)
%SANITYCHECK checks sequence of triggers as given, and renames wrong
%triggers with empty string
%EEG : all eeg datasets stored
%triggerSeq : correct Sequence of triggers expected
%EEG_out: corrected eeg dataset with all seq
n1=numel(triggerSeq); n=numel(ALLEEG.event);
n1
n
wrong_field=struct('eventType', [],'eventIdx', [],'correct', []);
d=1;
while d<=length(ALLEEG.event)
    trig=1;
    if d>numel(ALLEEG.event)
        break;
    end;
    while trig<=numel(triggerSeq)
        if trig>numel(triggerSeq)
            break;
        end;
        if (strcmp(ALLEEG.event(d).type,triggerSeq(trig)))
            
        else
            d
            trig
            if strcmp(ALLEEG.event(d).type,'')
                continue;
            else
                wrong_field.eventType=[wrong_field.eventType '' ALLEEG.event(d).type];
                wrong_field.eventIdx=[wrong_field.eventIdx d];
                wrong_field.correct=[wrong_field.correct triggerSeq(trig)];
            end
            
        end
        d=d+1;
        trig=trig+1;
    end
end
end

