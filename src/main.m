% Signals and Systems Course Project
% Main MATLAB pipeline.
%
% This script reads audio/input/original.wav as the sampled signal x[n],
% builds a linear-interpolation view of x(t), creates the required
% time-domain transforms, analyzes spectra, reconstructs magnitude-only and
% phase-only signals, and applies an ideal low-pass filter in the frequency
% domain.
%
% All generated files are deterministic for the same input audio. This makes
% the repository easy to audit: rerunning this script should overwrite the
% figures and audio clips with the same experimental products.
%
% The source code intentionally contains detailed notes because the project
% brief requires at least 30 percent notes/comments in the submitted code.

clear; close all; clc;

srcDir = fileparts(mfilename('fullpath'));
addpath(srcDir);
projectRoot = fileparts(srcDir);
inputPath = fullfile(projectRoot, 'audio', 'input', 'original.wav');
outputDir = fullfile(projectRoot, 'audio', 'output');
figureDir = fullfile(projectRoot, 'figures');
summaryPath = fullfile(projectRoot, 'report', 'matlab_results_summary.md');

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end
if ~exist(fullfile(projectRoot, 'report'), 'dir')
    mkdir(fullfile(projectRoot, 'report'));
end

% The following sections mirror the order of the course project brief. Keeping
% this order makes it easier to map report figures back to code.

% -------------------------------------------------------------------------
% 1. Load and normalize the source audio.
% -------------------------------------------------------------------------
[x, Fs, audioInfo] = load_audio(inputPath);
T = numel(x) / Fs;
t = (0:numel(x)-1)' / Fs;

% Store a clean normalized copy so every later output has a common reference.
audiowrite(fullfile(outputDir, 'original_normalized.wav'), x, Fs);

% Plot the original sampled signal and the linear interpolation counterpart.
plot_waveform(t, x, 'Original sampled signal x[n]', ...
    fullfile(figureDir, '01_original_waveform.png'));
plot_interpolation(t, x, Fs, fullfile(figureDir, '02_linear_interpolation_xt.png'));

% -------------------------------------------------------------------------
% 2. Generate x(-t), x(2t), and x(t/2).
% -------------------------------------------------------------------------
% x(-t) is a time reversal. For finite audio, this is implemented by flipping
% the sample order, which makes the sound play backward.
x_reverse = flipud(x);
t_reverse = (0:numel(x_reverse)-1)' / Fs;
audiowrite(fullfile(outputDir, 'x_reverse.wav'), x_reverse, Fs);
plot_waveform(t_reverse, x_reverse, 'Time reversal x(-t)', ...
    fullfile(figureDir, '03_x_reverse_waveform.png'));

% x(2t) compresses the time axis by 2, so the duration is half of the source.
% x(t/2) expands the time axis by 2, so the duration is twice the source.
[x_fast, t_fast] = time_transform(x, Fs, 'compress2');
[x_slow, t_slow] = time_transform(x, Fs, 'expand2');

% The transformed audio is normalized before writing so that interpolation does
% not accidentally create samples outside the valid [-1, 1] audio range.
audiowrite(fullfile(outputDir, 'x_2t.wav'), normalize_audio(x_fast), Fs);
audiowrite(fullfile(outputDir, 'x_t_over_2.wav'), normalize_audio(x_slow), Fs);
plot_waveform(t_fast, x_fast, 'Time compression x(2t)', ...
    fullfile(figureDir, '04_x_2t_waveform.png'));
plot_waveform(t_slow, x_slow, 'Time expansion x(t/2)', ...
    fullfile(figureDir, '05_x_t_over_2_waveform.png'));

% -------------------------------------------------------------------------
% 3. Fourier transform spectra for the required signals.
% -------------------------------------------------------------------------
plot_spectrum(x, Fs, 'Spectrum of x(t)', ...
    fullfile(figureDir, '06_spectrum_original.png'));
plot_spectrum(x_reverse, Fs, 'Spectrum of x(-t)', ...
    fullfile(figureDir, '07_spectrum_x_reverse.png'));
plot_spectrum(x_fast, Fs, 'Spectrum of x(2t)', ...
    fullfile(figureDir, '08_spectrum_x_2t.png'));
plot_spectrum(x_slow, Fs, 'Spectrum of x(t/2)', ...
    fullfile(figureDir, '09_spectrum_x_t_over_2.png'));

% -------------------------------------------------------------------------
% 4. Magnitude-only and phase-only inverse Fourier transform comparison.
% -------------------------------------------------------------------------
[x_mag_only, x_phase_only] = reconstruct_mag_phase(x);
t_mag = (0:numel(x_mag_only)-1)' / Fs;
t_phase = (0:numel(x_phase_only)-1)' / Fs;

% These two audio clips are not expected to sound like the source. Their role
% is to demonstrate that magnitude and phase carry different information.
audiowrite(fullfile(outputDir, 'magnitude_only_reconstruction.wav'), ...
    normalize_audio(x_mag_only), Fs);
audiowrite(fullfile(outputDir, 'phase_only_reconstruction.wav'), ...
    normalize_audio(x_phase_only), Fs);
plot_waveform(t_mag, x_mag_only, 'Inverse transform of magnitude spectrum', ...
    fullfile(figureDir, '10_magnitude_only_waveform.png'));
plot_waveform(t_phase, x_phase_only, 'Inverse transform of phase spectrum', ...
    fullfile(figureDir, '11_phase_only_waveform.png'));

% -------------------------------------------------------------------------
% 5. Ideal low-pass filtering in the frequency domain.
% -------------------------------------------------------------------------
% Fs is 16 kHz for the provided input, so Nyquist frequency is 8 kHz. A 3 kHz
% cutoff keeps the low and middle audio band while visibly removing high
% frequency components from the spectrum.
cutoffHz = min(3000, 0.35 * Fs);
[x_lowpass, filterMask, freqAxis] = ideal_lowpass_filter(x, Fs, cutoffHz);
t_lowpass = (0:numel(x_lowpass)-1)' / Fs;
audiowrite(fullfile(outputDir, 'lowpass_ideal_3000Hz.wav'), ...
    normalize_audio(x_lowpass), Fs);
plot_waveform(t_lowpass, x_lowpass, 'Ideal low-pass filtered signal', ...
    fullfile(figureDir, '12_lowpass_waveform.png'));
plot_spectrum(x_lowpass, Fs, 'Spectrum after ideal low-pass filtering', ...
    fullfile(figureDir, '13_lowpass_spectrum.png'));

% Plot the binary ideal low-pass mask to make the cutoff explicit.
maskFig = figure('Visible', 'off');
plot(freqAxis, filterMask, 'LineWidth', 1.2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Gain');
title(sprintf('Ideal low-pass filter mask, cutoff = %.0f Hz', cutoffHz));
ylim([-0.1 1.1]);
saveas(maskFig, fullfile(figureDir, '14_lowpass_filter_mask.png'));
close(maskFig);

% -------------------------------------------------------------------------
% 6. Write a compact summary for the report folder.
% -------------------------------------------------------------------------
summaryText = sprintf([ ...
    '# MATLAB Results Summary\n\n', ...
    '- Input file: `%s`\n', ...
    '- Original duration: %.3f seconds\n', ...
    '- Sampling rate: %d Hz\n', ...
    '- Channels after preprocessing: 1\n', ...
    '- Source bit depth: %d bits\n', ...
    '- Interpolation method: linear interpolation for the x(t) visualization\n', ...
    '- Time reversal output: `audio/output/x_reverse.wav`\n', ...
    '- Time compression output: `audio/output/x_2t.wav`\n', ...
    '- Time expansion output: `audio/output/x_t_over_2.wav`\n', ...
    '- Magnitude-only reconstruction: `audio/output/magnitude_only_reconstruction.wav`\n', ...
    '- Phase-only reconstruction: `audio/output/phase_only_reconstruction.wav`\n', ...
    '- Low-pass output: `audio/output/lowpass_ideal_3000Hz.wav`\n', ...
    '- Low-pass cutoff: %.0f Hz\n\n', ...
    'Generated figures are saved under `figures/`.\n'], ...
    strrep(inputPath, projectRoot, '.'), T, Fs, audioInfo.BitsPerSample, cutoffHz);

fid = fopen(summaryPath, 'w');
fprintf(fid, '%s', summaryText);
fclose(fid);

disp(summaryText);
