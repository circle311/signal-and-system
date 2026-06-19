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

### Current Plan

1. Configure the GitHub remote and push the local archive when authentication/network access allows.
2. Select and preprocess the input audio clip according to `audio_requirements.md`.
3. Implement the MATLAB signal processing experiments.
4. Generate figures and output audio.
5. Select and study the IEEE OFDM/OTFS paper.
6. Write and export the final report.
7. Package and verify the final submission zip.

### Open Questions

- Which audio clip should be selected as the input signal?
- Which OFDM/OTFS paper will be used for Part II?
- Can the local repository be pushed to GitHub through HTTPS authentication from this environment?

### Notes

- The DOCX uses Office Math objects. The conversion script reads both normal text and math text from the underlying document XML so formula names such as `x[n]`, `x(t)`, `x(2t)`, and `X(jw)` are preserved.
- PowerShell may display some UTF-8 mathematical symbols incorrectly unless UTF-8 output is explicitly enabled.
