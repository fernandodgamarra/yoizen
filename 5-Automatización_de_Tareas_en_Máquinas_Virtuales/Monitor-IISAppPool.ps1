param (
    [string]$appPoolName = "DefaultAppPool"
)

$logFile = "C:\Logs\Monitor-IISAppPool.log"

Function Write-Log {
    param ([string]$Message)
    Add-Content -Path $logFile -Value ("{0} {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message)
}

Write-Log "Verificando el estado del Pool de Aplicaciones '$appPoolName'..."

try {
    $appPool = Get-WebAppPoolState -Name $appPoolName -ErrorAction Stop
    if ($appPool.Value -ne "Started") {
        Write-Log "Reiniciando AppPool '$appPoolName'..."
        Restart-WebAppPool -Name $appPoolName -ErrorAction Stop
        Start-Sleep -Seconds 10
        $appPoolNewState = Get-WebAppPoolState -Name $appPoolName
        if ($appPoolNewState.Value -eq "Started") {
            Write-Log "Reinicio exitoso de AppPool."
        } else {
            Write-Log "Fallo al reiniciar AppPool."
            exit 1
        }
    } else {
        Write-Log "AppPool '$appPoolName' está en ejecución."
    }
}
catch {
    Write-Log "Error durante la verificación: $($_.Exception.Message)"
    exit 1
}