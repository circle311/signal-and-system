# Submission Manifest

Final package contents should include:

1. Report PDF:
   - `report/report.pdf`
2. Generated audio clips:
   - `audio/input/original.wav`
   - `audio/output/original_normalized.wav`
   - `audio/output/x_reverse.wav`
   - `audio/output/x_2t.wav`
   - `audio/output/x_t_over_2.wav`
   - `audio/output/magnitude_only_reconstruction.wav`
   - `audio/output/phase_only_reconstruction.wav`
   - `audio/output/lowpass_ideal_3000Hz.wav`
3. MATLAB source code:
   - `src/main.m`
   - `src/load_audio.m`
   - `src/normalize_audio.m`
   - `src/plot_waveform.m`
   - `src/plot_interpolation.m`
   - `src/plot_spectrum.m`
   - `src/time_transform.m`
   - `src/reconstruct_mag_phase.m`
   - `src/ideal_lowpass_filter.m`
4. Supporting notes:
   - `paper/otfs_paper_notes.md`
   - `report/matlab_results_summary.md`

Current verification status:

- MATLAB pipeline ran successfully.
- Generated audio files exist.
- Generated figures exist.
- Report PDF compiled successfully.
- PDF visual QA was performed by rendering pages to PNG and checking representative pages.
- Every MATLAB source file has at least 30% comment lines.
