function y = normalize_audio(x)
%NORMALIZE_AUDIO Scale an audio vector to avoid clipping.
%
% A small headroom factor keeps the maximum absolute value below one, which is
% useful after inverse FFT and interpolation operations.

    peak = max(abs(x(:)));
    if peak > 0
        y = 0.98 * x / peak;
    else
        y = x;
    end
end

