@echo off
SET MCS_ENDPOINT=Sophos\Management Communications System\Endpoint\McsClient.exe
IF "%PROCESSOR_ARCHITECTURE%" == "x86" GOTO X86_PROG
IF NOT EXIST "%ProgramFiles(x86)%\%MCS_ENDPOINT%" GOTO INSTALL
exit /b 0

:X86_PROG
IF NOT EXIST "%ProgramFiles%\%MCS_ENDPOINT%" GOTO INSTALL
exit /b 0

:INSTALL
pushd C:\Windows\Temp\SophosSetup.exe
SophosSetup.exe --quiet
Popd
