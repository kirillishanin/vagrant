#!/usr/bin/env bash

source /opt/provision/common.sh

log "Starting Ollama provisioning"

# =========================================================
# INSTALL DOCKER
# =========================================================

bash /opt/provision/docker.sh

# =========================================================
# START OLLAMA STACK
# =========================================================

cd /home/vagrant/ollama

if ! docker ps -a --format '{{.Names}}' | grep -q "^ollama$"; then

    log "Starting Ollama container"

    docker compose up -d

    log "Waiting for Ollama startup"

    sleep 60

else

    log "Ollama container already exists"

fi

# =========================================================
# DOWNLOAD MODEL
# =========================================================

if docker exec ollama ollama list \
    | grep -q "llama3.2:3b"; then

    log "Model llama3.2:3b already installed"

else

    log "Pulling model llama3.2:3b"

    docker exec ollama ollama pull llama3.2:3b

fi

log "Ollama provisioning completed"