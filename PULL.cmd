@echo off
echo.
echo  Starte Claude Sync - PULL ...
echo  ================================
echo.

powershell.exe -ExecutionPolicy Bypass -File "%~dp0claude-sync.ps1" pull

if %ERRORLEVEL% EQU 0 (
    echo.
    echo  Pull erfolgreich abgeschlossen!
    echo  Jetzt mit Claude arbeiten ...
) else (
    echo.
    echo  FEHLER: Pull fehlgeschlagen. Exit-Code: %ERRORLEVEL%
)

echo.
echo  Fenster schliesst in 10 Sekunden ...
timeout /t 10 /nobreak >nul
exit
