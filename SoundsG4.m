clear all;
clc;
%% set path
cd '/Users/PsychofMusic/project';
savepth = [pwd '/stimuli'];
if ~isfolder(savepth)
    mkdir(savepth);
end

freqCs = [50, 500, 5000]; % center frequencies: low mid high
fs = 44100; % sampling frequency 16khz (or 44.1khz?)
Ts = 0:1/fs:.250; % length of each tone: 250ms
Ti = .500; % silent interval between two tones: 500ms
for i = 1:length(freqCs)
    Frq = freqCs(i); % center frequency
    levels = [0 0.001, 0.002, 0.005, 0.01, 0.05]; % difference ratio of two pure tones
    for j = 1:length(levels)        
        Y1 = sin(2*pi*Frq*(1-levels(j)/2)*Ts);
        Y0 = zeros(1, fs*Ti);
        Y2 = sin(2*pi*Frq*(1+levels(j)/2)*Ts);
        if levels(j) ~= 0
            sound_lh = [Y1 Y0 Y2];
            sound_hl = [Y2 Y0 Y1];
            audiowrite([savepth '/stim_' num2str(freqCs(i)) '_' num2str(levels(j)) '_lh.wav'], sound_lh, fs);
            audiowrite([savepth '/stim_' num2str(freqCs(i)) '_' num2str(levels(j)) '_hl.wav'], sound_hl, fs);
            clear Y1 Y0 Y2 sound_lh sound_hl
        else
            sound_s = [Y1 Y0 Y2]; % s = same
            audiowrite([savepth '/stim_' num2str(freqCs(i)) '_' num2str(levels(j)) '_s.wav'], sound_s, fs);
            clear Y1 Y0 Y2 sound_lh sound_s
        end
    end
end
