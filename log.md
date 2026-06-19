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

### Current Plan

1. Choose implementation language: MATLAB or Python.
2. Create project folders for source code, audio, figures, paper notes, and report files.
3. Select and preprocess the input audio clip.
4. Implement signal processing experiments.
5. Generate figures and output audio.
6. Select and study the IEEE OFDM/OTFS paper.
7. Write and export the final report.
8. Package and verify the final submission zip.

### Open Questions

- Which implementation language should be used: MATLAB or Python?
- Which audio clip should be selected as the input signal?
- Which OFDM/OTFS paper will be used for Part II?
- Should the final GitHub archive be a local Git repository only, or should it also be pushed to a remote GitHub repository after GitHub CLI access is fixed or a remote URL is provided?

### Notes

- The DOCX uses Office Math objects. The conversion script reads both normal text and math text from the underlying document XML so formula names such as `x[n]`, `x(t)`, `x(2t)`, and `X(jω)` are preserved.
- PowerShell may display some UTF-8 mathematical symbols incorrectly unless UTF-8 output is explicitly enabled.
