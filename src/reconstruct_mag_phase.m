function [xMagOnly, xPhaseOnly] = reconstruct_mag_phase(x)
%RECONSTRUCT_MAG_PHASE Compare inverse transforms of magnitude and phase.
%
% The magnitude-only reconstruction keeps |X| but discards phase. The
% phase-only reconstruction keeps exp(j angle(X)) but discards magnitude. This
% makes the report discussion concrete: phase strongly affects waveform shape
% and timing, while magnitude strongly affects spectral energy distribution.

    X = fft(x);
    xMagOnly = real(ifft(abs(X)));
    xPhaseOnly = real(ifft(exp(1j * angle(X))));

    xMagOnly = normalize_audio(xMagOnly);
    xPhaseOnly = normalize_audio(xPhaseOnly);
end

