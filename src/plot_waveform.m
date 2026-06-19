function plot_waveform(t, x, plotTitle, outputPath)
%PLOT_WAVEFORM Save a time-domain waveform as a PNG file.
%
% The plot uses seconds on the horizontal axis because the project asks for
% signal waveforms of x(t), x(-t), x(2t), and x(t/2).
%
% A fixed amplitude range makes the figures directly comparable across all
% transformations.

    fig = figure('Visible', 'off');
    plot(t, x, 'LineWidth', 0.8);
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(plotTitle);
    xlim([0, max(t)]);
    ylim([-1.05, 1.05]);
    saveas(fig, outputPath);
    close(fig);
end
