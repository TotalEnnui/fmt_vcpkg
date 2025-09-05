@echo off
setlocal enabledelayedexpansion

:: ===========================
:: Usage: build.cmd [msvc|ucrt64] [--clean]
:: ===========================

:: Default values
set BUILD_MODE=msvc
set CLEAN=false

:: ===========================
:: Parse arguments
:: ===========================
for %%A in (%*) do (
    if /I "%%A"=="msvc" set BUILD_MODE=msvc
    if /I "%%A"=="ucrt64" set BUILD_MODE=ucrt64
    if /I "%%A"=="--clean" set CLEAN=true
)

:: ===========================
:: Define presets and paths
:: ===========================
set MSVC_PRESET=msvc-release
set UCRT64_PRESET=ucrt64-release
set VC_VARS="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
set PROJECT_DIR=%~dp0

:: ===========================
:: Optional cleanup
:: ===========================
if /I "%CLEAN%"=="true" (
    echo [Cleanup] Removing CMakeCache.txt and CMakeFiles...
    del /q "%PROJECT_DIR%build\%BUILD_MODE%\CMakeCache.txt"
    rmdir /s /q "%PROJECT_DIR%build\%BUILD_MODE%\CMakeFiles"
)

:: ===========================
:: Toolchain setup
:: ===========================
if /I "%BUILD_MODE%"=="msvc" (
    echo [MSVC] Cleaning MSYS2 from PATH...
    set PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem
    echo [MSVC] Initializing MSVC environment...
    call %VC_VARS%
    set PRESET=%MSVC_PRESET%
) else if /I "%BUILD_MODE%"=="ucrt64" (
    echo [UCRT64] Using MSYS2 UCRT64 environment...
    set PRESET=%UCRT64_PRESET%
) else (
    echo [Error] Unknown build mode: %BUILD_MODE%
    echo [Usage] build.cmd [msvc|ucrt64] [--clean]
    exit /b 1
)

:: ===========================
:: Run CMake configure + build
:: ===========================
echo [CMake] Configuring with preset: %PRESET%
cmake --preset %PRESET%

echo [CMake] Building with preset: %PRESET%
cmake --build --preset %PRESET% --config Release

endlocal

:: From any project folder with a valid :
:: Cmd
::     build.cmd msvc
:: Cmd
::     build.cmd ucrt64 
:: Cmd
::     build.cmd msvc --clean