# Audio Selection Requirements

Use one short, clean audio clip as the source signal `x[n]`.

## Recommended Choice

- Format: `.wav`
- Duration: 5 to 10 seconds
- Sampling rate: 16 kHz, 22.05 kHz, or 44.1 kHz
- Channels: mono is preferred
- Bit depth: 16-bit PCM is preferred
- Content: speech, simple music, or a short instrumental clip with clear amplitude variation

## Acceptable Alternatives

- `.mp3`, `.m4a`, or other MATLAB-readable formats are acceptable if MATLAB `audioread` can load them.
- Stereo audio is acceptable, but the MATLAB code should convert it to mono before processing:

```matlab
x = mean(x, 2);
```

## Avoid

- Clips longer than 15 seconds, because waveform and FFT plots become harder to read and slower to regenerate.
- Very short clips below 2 seconds, because spectra and time-scaling comparisons may be less convincing.
- Audio with long silence at the beginning or end.
- Audio that is already heavily distorted or clipped.
- Copyright-sensitive full songs. Use a short self-recorded clip, royalty-free sample, or trimmed excerpt.

## Practical Target For This Project

The best practical input is:

- `audio/input/original.wav`
- 5 to 8 seconds long
- mono
- 44.1 kHz or 16 kHz
- normalized so the maximum absolute amplitude is below 1

This length is long enough to show meaningful spectral content, but short enough for clean waveform plots, time reversal, time scaling, phase/magnitude reconstruction, and frequency-domain filtering.
