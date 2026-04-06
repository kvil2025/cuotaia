#!/bin/bash
# start-alerts.sh — Inicia el Motor de Alertas de CuotaIA
cd "$(dirname "$0")/backend"

if [ ! -f ../.env ]; then
  echo "❌ Error: .env no encontrado. Copia .env.example a .env primero."
  exit 1
fi

export $(grep -v '^#' ../.env | xargs)

echo "🚀 Iniciando CuotaIA Alert Engine..."
python3 alert_engine.py >> /tmp/cuotaia-alerts.log 2>&1 &
echo "[OK] Alert Engine corriendo (PID: $!)"
echo "📋 Logs: tail -f /tmp/cuotaia-alerts.log"
