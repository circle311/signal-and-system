function plot_spectrum(x, Fs, plotTitle, outputPath)
%PLOT_SPECTRUM Compute an FFT-based magnitude spectrum and save it.
%
% fftshift places negative frequencies on the left and positive frequencies
% on the right, matching the usual continuous-time Fourier transform view.
%
% The spectrum is normalized before conversion to dB. This emphasizes the
% relative spectral shape instead of absolute audio loudness.

    N = numel(x);
    X = fftshift(fft(x));
    frequency = (-floor(N/2):ceil(N/2)-1)' * (Fs / N);
    magnitudeDb = 20 * log10(abs(X) / max(abs(X)) + eps);

    % eps avoids log(0), which would otherwise create -Inf values in the plot.
    fig = figure('Visible', 'off');
    plot(frequency, magnitudeDb, 'LineWidth', 1.0);
    grid on;
    xlabel('Frequency (Hz)');
    ylabel('Normalized magnitude (dB)');
    title(plotTitle);
    ylim([-100, 5]);
    xlim([-Fs/2, Fs/2]);
    saveas(fig, outputPath);
    close(fig);
end
