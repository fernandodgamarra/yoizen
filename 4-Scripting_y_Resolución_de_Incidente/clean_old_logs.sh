#!/bin/bash

# Directorio donde se encuentran los logs a limpiar
LOG_DIR="/var/log/apache"

# Número de días para mantener los logs (logs más antiguos serán eliminados)
DAYS_TO_KEEP=30

# Archivo de log para el propio script de limpieza
SCRIPT_LOG="/var/log/clean_old_logs.log"

echo "$(date): Iniciando limpieza de logs en $LOG_DIR. Manteniendo los últimos $DAYS_TO_KEEP días." >> "$SCRIPT_LOG"

# Verificar si el directorio de logs existe
if [ ! -d "$LOG_DIR" ]; then
    echo "$(date): Error: El directorio de logs '$LOG_DIR' no existe." >> "$SCRIPT_LOG"
    exit 1
fi

# Buscar y eliminar archivos de log modificados hace más de DAYS_TO_KEEP días
find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS_TO_KEEP -delete

if [ $? -eq 0 ]; then
    echo "$(date): Limpieza de logs completada exitosamente." >> "$SCRIPT_LOG"
else
    echo "$(date): Error durante la limpieza de logs." >> "$SCRIPT_LOG"
    exit 1
fi

echo "$(date): Script de limpieza finalizado." >> "$SCRIPT_LOG"

exit 0
