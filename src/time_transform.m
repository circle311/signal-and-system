function [y, ty] = time_transform(x, Fs, mode)
%TIME_TRANSFORM Generate x(2t) or x(t/2) with interpolation.
%
% The source samples are treated as observations of a continuous-time signal
% x(t). For x(2t), the output time t maps to source time 2t. For x(t/2), the
% output time t maps to source time t/2.
%
% Linear interpolation is used here for consistency with the x(t)
% construction shown in the interpolation figure.

    sourceT = (0:numel(x)-1)' / Fs;
    duration = sourceT(end);

    switch mode
        case 'compress2'
            ty = (0:round((duration / 2) * Fs))' / Fs;
            sourceQuery = 2 * ty;
        case 'expand2'
            ty = (0:round((duration * 2) * Fs))' / Fs;
            sourceQuery = ty / 2;
        otherwise
            error('Unknown time transform mode: %s', mode);
    end

    % Samples outside the original finite support are set to zero.
    y = interp1(sourceT, x, sourceQuery, 'linear', 0);
    y = normalize_audio(y);
end
