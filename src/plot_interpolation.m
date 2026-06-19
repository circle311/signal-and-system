function plot_interpolation(t, x, Fs, outputPath)
%PLOT_INTERPOLATION Show x[n] and a linear-interpolation approximation of x(t).
%
% A continuous-time signal cannot be represented exactly on a computer, so the
% figure uses dense samples from interp1 as the continuous-time counterpart.
% Only the first 50 ms are plotted to keep the interpolation visible.
%
% Plotting the full seven-second clip with stems would hide the interpolation
% behavior, so this function deliberately zooms into a short segment.

    windowSeconds = min(0.05, t(end));
    idx = t <= windowSeconds;
    tWindow = t(idx);
    xWindow = x(idx);
    denseT = linspace(tWindow(1), tWindow(end), max(1000, numel(tWindow) * 20));
    denseX = interp1(tWindow, xWindow, denseT, 'linear');

    % The stem plot represents x[n], while the line plot represents the chosen
    % continuous-time approximation x(t).
    fig = figure('Visible', 'off');
    plot(denseT, denseX, 'LineWidth', 1.2);
    hold on;
    stem(tWindow, xWindow, 'filled', 'MarkerSize', 2);
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Linear interpolation approximation of x(t), Fs = %d Hz', Fs));
    legend('Linear interpolation x(t)', 'Samples x[n]', 'Location', 'best');
    saveas(fig, outputPath);
    close(fig);
end
