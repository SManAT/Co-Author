@echo off
echo.
echo  Starte Claude Sync - PUSH ...
echo  ================================
echo.

powershell.exe -ExecutionPolicy Bypass -File "%~dp0claude-sync.ps1" push

if %ERRORLEVEL% EQU 0 (
    echo.
    echo  Push erfolgreich abgeschlossen!
) else (
    echo.
    echo  FEHLER: Push fehlgeschlagen. Exit-Code: %ERRORLEVEL%
)

echo.
echo  Fenster schliesst in 10 Sekunden ...
timeout /t 10 /nobreak >nul
exit
