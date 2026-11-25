# Clipped by Imad
A Windows desktop launcher for a browser-based clipping studio. Version 1.2.1.
## Install
Download ClippedSetup.exe from a release. Run Install, then Finish. Launch Clipped by Imad from Start. On a fresh Windows x64 PC setup uses Windows Package Manager and may download Python, FFmpeg and speech libraries. Local speech models download on first use.
## Clip a video
Choose New project, paste a link or select a video, choose your settings, then Generate clips. For Hindi in Latin letters choose Hindi or Auto-detect under Spoken language and Hinglish under Caption script. Original script and Banglish are also available. The Projects menu opens earlier projects. Completed clips and exports stay in the existing project directories. Text in a source video itself is unchanged.
## Build the installer
On Windows x64, run Build.ps1 from PowerShell. It uses Windows PowerShell, the built-in .NET Framework 4.x C# compiler and .NET ZIP libraries. The compiled Windows application is written to dist/ClippedSetup.exe. Clipped users only need the installer.
## License
Copyright (c) 2026 Imad. Released under the MIT License. See LICENSE and THIRD-PARTY-NOTICES.txt.
