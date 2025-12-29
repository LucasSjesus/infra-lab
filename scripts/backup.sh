#!/usr/bin/env bash
set -e

# Variáveis
BACKUP_DIR="/var/backups/infra-lab"
LOG_FILE="/var/log/infra-lab-backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

TARGETS=(
  "/etc"
  "/home/devuser"
)

# Garantir diretórios
mkdir -p "$BACKUP_DIR"
touch "$LOG_FILE"

echo "[$(date)] Iniciando backup..." >> "$LOG_FILE"

for TARGET in "${TARGETS[@]}"; do
  NAME=$(basename "$TARGET")
  ARCHIVE="$BACKUP_DIR/${NAME}_${DATE}.tar.gz"

  echo "[$(date)] Backup de $TARGET iniciado" >> "$LOG_FILE"

  tar -czpf "$ARCHIVE" "$TARGET" 2>>"$LOG_FILE"

  echo "[$(date)] Backup de $TARGET concluído: $ARCHIVE" >> "$LOG_FILE"
done

echo "[$(date)] Backup finalizado com sucesso" >> "$LOG_FILE"


# lembre-se de adicionar as permissões chmod +x scripts/backup.sh sudo chown root:root scripts/backup.sh
# para automatizar : sudo crontab -e depois 0 2 * * * /caminho/absoluto/infra-lab/scripts/backup.sh

