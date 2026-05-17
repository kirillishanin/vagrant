Структура проекта:

## Project Structure

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

Вся инфраструктура описана декларативно через {IaC}:
Vagrantfile
provisioning scripts
docker-compose
