#!/usr/bin/env bash

set -e #caso falhe ele n inicia

SERVICE="sshd" #no caso pode ser necessário ajustar para ssh.service dependendo da distro
LOG_FILE="/var/log/infra-lab-watchdog.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

#Criar o log file

touch "$LOG_FILE"

if systemctl is-active --quiet "$SERVICE"; then
  echo "{\"timestamp\":\"$TIMESTAMP\",\"service\":\"$SERVICE\",\"status\":\"running\"}" >> "$LOG_FILE"
else
  echo "{\"timestamp\":\"$TIMESTAMP\",\"service\":\"$SERVICE\",\"status\":\"down\",\"action\":\"restart\"}" >> "$LOG_FILE"
  systemctl restart "$SERVICE"

  if systemctl is-active --quiet "$SERVICE"; then
    echo "{\"timestamp\":\"$TIMESTAMP\",\"service\":\"$SERVICE\",\"status\":\"restarted_successfully\"}" >> "$LOG_FILE"
  else
    echo "{\"timestamp\":\"$TIMESTAMP\",\"service\":\"$SERVICE\",\"status\":\"restart_failed\"}" >> "$LOG_FILE"
  fi
fi


# lembre-se de adicionar as permissões chmod +x scripts/watchdog.sh sudo chown root:root scripts/watchdog.sh
# conferir log em /var/log/infra-lab-watchdog.log
# crontab -e
# */5 * * * * /etc/scripts/watchdog.sh