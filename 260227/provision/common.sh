#!/usr/bin/env bash
# Остановить скрипт при любой ошибке, не существующей переменной.
set -euo pipefail
# Функция логирования
log() {
    echo "[INFO] $1"
}
# Логирование warning сообщений
warn() {
    echo "[WARN] $1"
}
# Логированеи ошибок
error() {
    echo "[ERROR] $1"
}
# Проверка существования команды в PATH
command_exists() {
    command -v "$1" &> /dev/null
}