#!/usr/bin/env bash
#Подключаем наш common.sh
source /opt/provision/common.sh
log "Starting PostgreSQL provisioning"

#Проверяем установлен ли posgresql

if command_exists psql; then

    log "PostgreSQL already installed"

else

    apt-get update

    apt-get install -y \
        postgresql \
        postgresql-contrib

fi

# Определяем версию

PG_VERSION=$(ls /etc/postgresql)
# Назначаем переменные
POSTGRES_CONF="/etc/postgresql/${PG_VERSION}/main/postgresql.conf"
PG_HBA_CONF="/etc/postgresql/${PG_VERSION}/main/pg_hba.conf"

# Меняем конфигурацию 
if ! grep -q "listen_addresses = '*'" "${POSTGRES_CONF}"; then

    echo "listen_addresses = '*'" >> "${POSTGRES_CONF}"

fi

if ! grep -q "10.77.133.0/28" "${PG_HBA_CONF}"; then

    echo "host all all 10.77.133.0/28 md5" >> "${PG_HBA_CONF}"

fi

systemctl restart postgresql

# Дополнительные функции
create_pg_user() {

    local USERNAME=$1
    local PASSWORD=$2

    if sudo -u postgres psql -tAc \
        "SELECT 1 FROM pg_roles WHERE rolname='${USERNAME}'" \
        | grep -q 1; then

        log "User ${USERNAME} already exists"

    else

        log "Creating user ${USERNAME}"

        sudo -u postgres psql -c \
            "CREATE USER ${USERNAME} WITH PASSWORD '${PASSWORD}';"

    fi
}

create_pg_database() {

    local DATABASE=$1
    local OWNER=$2

    if sudo -u postgres psql -lqt \
        | cut -d \| -f 1 \
        | grep -qw "${DATABASE}"; then

        log "Database ${DATABASE} already exists"

    else

        log "Creating database ${DATABASE}"

        sudo -u postgres psql -c \
            "CREATE DATABASE ${DATABASE} OWNER ${OWNER};"

    fi
}

# Создаем пользователй:

create_pg_user n8n n8n
create_pg_user ollama ollama
create_pg_user wikijs wikijs

# Создаем базы данных:

create_pg_database n8n_db n8n
create_pg_database ollama_db ollama
create_pg_database wikijs_db wikijs

log "PostgreSQL provisioning completed"