#!/usr/bin/env bash
#Подключаем наш common.sh
source /opt/provision/common.sh
#Вывод и проверка работы фукцнии логирования
log "Starting Docker provisioning"

# Имя приложения (директория с docker-compose.yml) передаётся аргументом.
# Если не передано — используем имя текущей директории.
APP_NAME="${1:-$(basename "$PWD")}"

# Проверка установлен ли докер
if ! command_exists docker; then
    # Установка зависимостей:
    apt-get update

    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    # Добавляем gpg key
    install -m 0755 -d /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | gpg --dearmor \
        -o /etc/apt/keyrings/docker.gpg

    chmod a+r /etc/apt/keyrings/docker.gpg
    # Подключаем репозиторий докера
    echo \
      "deb [arch=$(dpkg --print-architecture) \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update
    # Установка докер
    apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

    # Включаем сервисы, добавляем автозапуск
    systemctl enable docker
    systemctl start docker
    # Добавляем пользователя vagrant в группу docker

    usermod -aG docker vagrant

    log "Docker installed successfully"
else
    log "Docker already installed"
fi

# Директория приложения
APP_DIR="/home/vagrant/${APP_NAME}"

# Запуск docker-compose.yml внутри директории приложения.
if [ -f "${APP_DIR}/docker-compose.yml" ]; then
    cd "${APP_DIR}"
    # Проверяем, запущен ли уже стек (по имени проекта compose).
    # Compose именует контейнеры как "<project>-<service>-1", поэтому
    # ищем по префиксу "${APP_NAME}-".
    if docker ps -a --format '{{.Names}}' | grep -q "^${APP_NAME}-"; then
        log "Container stack ${APP_NAME} already exists"
    else
        log "Starting Docker Compose stack ${APP_NAME}"
        docker compose up -d
    fi
else
    log "No docker-compose.yml found in ${APP_DIR}, skipping"
fi