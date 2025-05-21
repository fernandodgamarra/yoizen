@echo off
:: Establecer la ruta al directorio donde están los scripts
set SCRIPT_DIR=%~dp0

:: Ejecutar script de limpieza de logs
powershell.exe -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Clean-IISLogs.ps1"

:: Ejecutar script de monitoreo de AppPools
powershell.exe -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Monitor-IISAppPool.ps1"

echo Scripts ejecutados correctamente.
pause