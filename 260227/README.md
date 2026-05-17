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

Вся инфраструктура описана декларативно через {IaC}
Provisioning безопасен для повторного запуска:
Скрипты проверяют:
- установлен ли Docker
- существуют ли PostgreSQL users/databases
- существует ли container
- загружена ли Ollama model
Как это работает
1. Vagrant создаёт VM

Каждая VM:
- получает hostname
- private IP
- RAM/CPU allocation
- shared folders
2. Provisioning scripts выполняются автоматически:
- устанавливает Docker/PostgreSQL
- настраивает сервисы
- запускает containers
- создаёт databases/users
- загружает LLM model
3. Docker Compose запускает сервисы
Каждый сервис изолирован внутри своей VM.