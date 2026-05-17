#!/usr/bin/env bash
#Подключаем наш common.sh
source /opt/provision/common.sh
#Вывод и проверка работы фукцнии логирования
log "Starting Docker provisioning"
# Проверка установлен ли докер
if command_exists docker; then
    log "Docker already installed"
    exit 0
fi
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
# Поиск директории
APP_DIR=$(find /home/vagrant -maxdepth 1 -type d | tail -n 1)
# Поиск docker-compose.yml внутри найденой директории, и его запускю.
if [ -f "${APP_DIR}/docker-compose.yml" ]; then
    cd "${APP_DIR}"
    STACK_NAME=$(basename "${APP_DIR}")
    if docker ps -a --format '{{.Names}}' | grep -q "^${STACK_NAME}$"; then
        log "Container ${STACK_NAME} already exists"
    else
        log "Starting Docker Compose stack"
        docker compose up -d
    fi
fi