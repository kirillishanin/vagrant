## Структура проекта:

```text
260227/
│
├── Vagrantfile
│
├── provision/
│   ├── common.sh
│   ├── docker.sh
│   ├── postgres.sh
│   └── ollama.sh
│
├── n8n/
│   └── docker-compose.yml
│
├── ollama/
│   └── docker-compose.yml
│
└── wikijs/
    └── docker-compose.yml
```

## Infrastructure Approach

Вся инфраструктура описана декларативно через Infrastructure as Code (IaC):

- `Vagrantfile`
- provisioning scripts
- `docker-compose.yml`

---

## Idempotent Provisioning

Provisioning безопасен для повторного запуска:

```bash
vagrant provision
```

Provisioning scripts автоматически проверяют:

- установлен ли Docker
- существуют ли PostgreSQL users/databases
- существуют ли Docker containers
- загружена ли Ollama model

Это позволяет безопасно переиспользовать provisioning без повторного создания инфраструктуры.

---

## How It Works

### 1. Vagrant создаёт VM

Каждая VM автоматически получает:

- hostname
- private IP
- RAM/CPU allocation
- shared folders

---

### 2. Provisioning scripts выполняются автоматически

Provisioning scripts:

- устанавливают Docker/PostgreSQL
- настраивают сервисы
- запускают containers
- создают databases/users
- загружают LLM model

---

### 3. Docker Compose запускает сервисы

Каждый сервис изолирован внутри своей VM через Docker-based architecture.