param (
    [string]$iisLogPath = "C:\inetpub\logs\LogFiles\W3SVC1",
    [string]$appLogPath = "E:\Web Example\logs",
    [int]$daysToKeep = 30
)

$logFile = "C:\Logs\Clean-IISLogs.log"

Function Write-Log {
    param ([string]$Message)
    Add-Content -Path $logFile -Value ("{0} {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message)
}

Write-Log "Iniciando limpieza de logs..."

if (Test-Path $iisLogPath) {
    Write-Log "Limpiando logs de IIS en $iisLogPath..."
    Get-ChildItem -Path $iisLogPath -Recurse -File -Include "*.log" |
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$daysToKeep) } |
        Remove-Item -Force -ErrorAction SilentlyContinue | Out-Null
    Write-Log "Limpieza de logs de IIS completada."
}

if (Test-Path $appLogPath) {
    Write-Log "Limpiando logs de la aplicación en $appLogPath..."
    Get-ChildItem -Path $appLogPath -Recurse -File -Include "*.log" |
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$daysToKeep) } |
        Remove-Item -Force -ErrorAction SilentlyContinue | Out-Null
    Write-Log "Limpieza de logs de la aplicación completada."
}

Write-Log "Limpieza de logs finalizada."