function [x, Fs, info] = load_audio(inputPath)
%LOAD_AUDIO Read the source audio and put it into a stable analysis form.
%
% The project treats the audio as a one-dimensional discrete-time signal
% x[n]. If the input is stereo, averaging the channels produces a mono signal
% while preserving the main waveform content. The amplitude is then normalized
% so later audio writes do not clip.

    if ~exist(inputPath, 'file')
        error('Input audio file not found: %s', inputPath);
    end

    info = audioinfo(inputPath);
    [x, Fs] = audioread(inputPath);

    if size(x, 2) > 1
        x = mean(x, 2);
    end

    x = normalize_audio(x);
end

