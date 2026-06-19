# Project Log

## 2026-06-19

### Completed

- Located the original project brief: `Course Project(1).docx`.
- Converted the DOCX project brief to Markdown: `Course Project(1).md`.
- Added `scripts/convert_docx_to_md.py` so the conversion can be rerun reproducibly.
- Confirmed the brief requires:
  - PDF report.
  - Resulting audio clips.
  - Source code used to generate the audio clips.
  - At least 30% notes/comments in source code.
  - No late submission.
- Initialized a local Git repository for project history.
- Created `workflow.md` to define the project execution plan and milestone tracking rules.
- Created the first Git commit: `30e9975 Initialize signals project workflow`.
- Checked remote GitHub creation options:
  - GitHub connector tools available in this session do not expose repository creation.
  - GitHub CLI is installed but cannot read its config file because of local permission denial.
- Selected MATLAB as the implementation language.
- Received GitHub repository address: `https://github.com/circle311/signal-and-system`.
- Configured `origin` as `https://github.com/circle311/signal-and-system.git`.
- Pushed local `master` branch to GitHub and set it to track `origin/master`.
- Confirmed input audio `audio/input/original.wav`:
  - Format: WAV, PCM signed 16-bit.
  - Sampling rate: 16000 Hz.
  - Channels: mono.
  - Duration: 7.000 seconds.
  - No ffmpeg preprocessing required.
- Implemented the MATLAB signal-processing pipeline under `src/`.
- Generated required audio outputs under `audio/output/`.
- Generated waveform, spectrum, reconstruction, and low-pass filter figures under `figures/`.
- Selected an OTFS paper for Part II and added notes under `paper/`.
- Created report source `report/report.tex` and compiled `report/report.pdf`.
- Verified every MATLAB source file has at least 30% comment lines.
- Rendered the PDF to PNG pages for visual QA and checked representative pages.
- Rewrote `report/report.tex` into Chinese as requested.
- Recompiled the Chinese `report/report.pdf`.
- Rendered the Chinese PDF to PNG pages and checked representative pages for font and layout quality.
- Rebuilt `submission.zip` with the Chinese PDF.

### Current Plan

1. Review whether the report should include personal/course identity fields.
2. Optionally expand the Part II paper translation if the instructor expects a longer standalone translation.
3. Submit `submission.zip` after identity fields are confirmed.

### Open Questions

- What name/student ID/course section should appear on the report cover?
- Should the Part II paper translation be expanded into a longer standalone translation?

### Notes

- The DOCX uses Office Math objects. The conversion script reads both normal text and math text from the underlying document XML so formula names such as `x[n]`, `x(t)`, `x(2t)`, and `X(jw)` are preserved.
- PowerShell may display some UTF-8 mathematical symbols incorrectly unless UTF-8 output is explicitly enabled.
