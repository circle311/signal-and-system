Signals and Systems – 2026 Spring

Course Project

Due: June 21rd, 2026, at 11:59 pm

Goal:

To help students to understand and master the fundamental theories of the course.

To improve their ability to apply the theories in engineering.

General Policy:

Please submit on CANVAS a .zip version of your solutions to the course project, which should contain at least the following three items:

a project report written in English/Chinese and in .pdf format;

resulting audio clips;

and your source code to generate the above audio clips.

No less than 30% notes in the source code

NO LATE submission is allowed, otherwise the grade will be discounted.

Part I: Signal Processing

Software Requirements:

Tools: MATLAB/ Python (recommended), or others like C/C++

Requirements:

Select a clip of audio (music or so on), denote it as x[n]. Use an interpolation method (e.g., zero order hold, first order hold, etc.) to construct the continuous time counterpart x(t), and show its signal waveform.

Generate x-t,  x(2t) and x(t/2), respectively, and show their waveforms.

Calculate the Fourier transform of x(-t), x(2t) and x(t/2), respectively. Show their spectra, compare and analyze them.

Denote X(jω) as the Fourier transform of x(t). Show the waveform of the inverse Fourier transform of the magnitude spectrum F-1{|Xjω|} and the waveform of the inverse Fourier transform of the phase spectrum F-1{ej∡X(jω)}. Compare them with the original signal x(t).

Implement a low-pass filtering (using ideal low-pass filter, cut-off frequency decided by yourself) to x(t) in the frequency domain, and show the waveform and spectrum of the resulting signal.

Part II: Signal Characterization in Transform Domain

Read one paper published on IEEE Transactions on Communications or IEEE Transactions on Wireless Communications on OFDM or OTFS, understand and translate it, followed by your understanding on why it can overcome the frequency selective fading channels or the fast mobility scenarios.
