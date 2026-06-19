function [y, mask, frequency] = ideal_lowpass_filter(x, Fs, cutoffHz)
%IDEAL_LOWPASS_FILTER Apply an ideal low-pass filter in the frequency domain.
%
% The filter is "ideal" because the frequency response is exactly 1 inside
% the cutoff band and 0 outside it. In real systems this brick-wall transition
% is not physically realizable, but it is appropriate for this course
% experiment and clearly shows frequency-domain filtering.

    N = numel(x);
    X = fftshift(fft(x));
    frequency = (-floor(N/2):ceil(N/2)-1)' * (Fs / N);
    mask = abs(frequency) <= cutoffHz;
    Y = X .* mask;

    y = real(ifft(ifftshift(Y)));
    y = normalize_audio(y);
end
