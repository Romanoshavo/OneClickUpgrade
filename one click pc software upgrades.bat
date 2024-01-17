
@echo off
:: Check if the script is already running as admin
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :run
) else (
    echo Running as administrator...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\admin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\admin.vbs"
    "%temp%\admin.vbs"
    del "%temp%\admin.vbs"
    exit /B
)

:run
:: Your batch script continues here
echo Running with elevated privileges...
pause

@echo off
echo Creating System Restore Point...
wmic /Namespace:\\root\default path SystemRestore Call CreateRestorePoint "Pre-Winget Upgrade", 100, 7
echo Restore Point Created.
echo Running winget Upgrade...
winget upgrade --All
echo Running winget Upgrade...
echo include unknown software
winget upgrade --include-unknown
echo Running Upgrade....
echo Enjoy By RasingDead
pause


