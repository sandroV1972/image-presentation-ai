.PHONY: help install test lint format clean docker-build docker-up docker-down deploy backup

help: ## Mostra questo messaggio di aiuto
	@echo "Comandi disponibili:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Installa dipendenze Python
	pip install -r requirements.txt
	pip install -r requirements-dev.txt || pip install pytest flake8 black isort mypy pylint bandit pytest-cov

test: ## Esegui tutti i test
	pytest tests/ -v

test-cov: ## Esegui test con coverage
	pytest tests/ --cov=app --cov-report=html --cov-report=term

lint: ## Esegui linting del codice
	flake8 app/
	pylint app/ --exit-zero

format: ## Formatta il codice con black e isort
	black app/ tests/
	isort app/ tests/

format-check: ## Controlla formattazione senza modificare
	black --check app/ tests/
	isort --check-only app/ tests/

security: ## Controlla vulnerabilità di sicurezza
	bandit -r app/ -f json -o bandit-report.json
	@echo "Report salvato in bandit-report.json"

type-check: ## Controlla type hints
	mypy app/ --ignore-missing-imports

quality: lint format-check type-check security ## Esegui tutti i controlli di qualità

dev: ## Avvia applicazione in modalità development
	FLASK_ENV=development python app/main.py

run: ## Avvia applicazione in modalità production
	python app/main.py

docker-build: ## Build immagine Docker
	docker build -t image-presentation-ai:latest .

docker-up: ## Avvia container Docker
	docker compose up -d

docker-down: ## Ferma container Docker
	docker compose down

docker-logs: ## Visualizza logs Docker
	docker compose logs -f

docker-restart: ## Riavvia container Docker
	docker compose restart

docker-clean: ## Rimuovi container e immagini
	docker compose down -v
	docker image prune -af

clean: ## Pulisci file temporanei
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	find . -type d -name '*.egg-info' -exec rm -rf {} +
	rm -rf .pytest_cache
	rm -rf .coverage
	rm -rf htmlcov
	rm -rf dist
	rm -rf build

deploy: ## Deploy su server remoto (richiede SSH configurato)
	@echo "Deploy automatico tramite GitHub Actions"
	@echo "Oppure esegui manualmente:"
	@echo "  ssh user@server 'cd /path/to/app && git pull && docker compose up -d --build'"

backup: ## Crea backup locale dei dati
	@mkdir -p backups
	@tar -czf backups/backup_$$(date +%Y%m%d_%H%M%S).tar.gz data/
	@echo "Backup creato in backups/"

setup-git-hooks: ## Configura git hooks per controlli pre-commit
	@echo "Configurazione git hooks..."
	@echo '#!/bin/sh\nmake format-check && make lint && make test' > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Git hooks configurati!"

init: install setup-git-hooks ## Setup iniziale del progetto
	@echo "Creazione directory..."
	@mkdir -p data/uploads data/output data/temp logs
	@cp .env.example .env
	@echo "Setup completato! Modifica .env con le tue configurazioni."

all: clean install quality test ## Esegui tutto: clean, install, quality checks, test
