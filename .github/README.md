# GitHub Automation & Configuration

Questa directory contiene tutta l'automazione e la configurazione per il repository GitHub di **Image Presentation AI**.

## 📁 Struttura

```
.github/
├── workflows/          # GitHub Actions workflows
│   ├── ci-cd.yml      # Pipeline CI/CD principale
│   ├── code-quality.yml  # Controlli qualità codice
│   ├── docker-publish.yml  # Pubblicazione immagini Docker
│   └── backup.yml     # Backup automatici
├── ISSUE_TEMPLATE/    # Template per issue
│   ├── bug_report.md
│   └── feature_request.md
├── PULL_REQUEST_TEMPLATE.md  # Template PR
├── dependabot.yml     # Configurazione Dependabot
├── CONTRIBUTING.md    # Guida contribuzione
├── SECURITY.md        # Policy sicurezza
├── SETUP.md          # Setup repository
├── COMMANDS.md       # Comandi Git utili
└── INFRASTRUCTURE.md  # Documentazione infrastruttura
```

## 🔄 Workflows Disponibili

### 1. CI/CD Pipeline
**File**: `workflows/ci-cd.yml`  
**Trigger**: Push/PR su `main` o `dev`

Esegue:
- Lint e test Python
- Build Docker image
- Deploy automatico (solo `main`)
- Notifiche Telegram

### 2. Code Quality
**File**: `workflows/code-quality.yml`  
**Trigger**: Push/PR su `main` o `dev`

Controlli:
- Black (formattazione)
- isort (import)
- mypy (type checking)
- pylint (linting)
- Bandit (security)

### 3. Docker Publish
**File**: `workflows/docker-publish.yml`  
**Trigger**: Release o manuale

Pubblica su GitHub Container Registry.

### 4. Automated Backup
**File**: `workflows/backup.yml`  
**Trigger**: Schedulato (02:00 UTC) o manuale

Backup giornaliero di dati e log.

## 🎯 Quick Start

### Prima Configurazione

1. **Configura Secrets**
   ```
   Settings → Secrets and variables → Actions
   ```
   Aggiungi: `SERVER_HOST`, `SERVER_USER`, `SSH_KEY`

2. **Attiva Branch Protection**
   ```
   Settings → Branches → Add rule
   ```
   Proteggi `main` con requisiti PR e checks

3. **Test Pipeline**
   ```bash
   git checkout -b test/github-actions
   echo "test" > test.txt
   git add .
   git commit -m "test: verifica GitHub Actions"
   git push origin test/github-actions
   ```

4. **Verifica Actions**
   ```
   Actions tab → CI/CD Pipeline
   ```

### Workflow Sviluppo

```bash
# Feature development
git checkout -b feature/my-feature
# ... sviluppo ...
git commit -am "feat: nuova feature"
git push origin feature/my-feature
# Apri PR su GitHub

# Hotfix
git checkout -b hotfix/critical-fix
# ... fix ...
git commit -am "fix: bug critico"
git push origin hotfix/critical-fix
# Apri PR con priority:high
```

## 📋 Templates

### Issue Templates
- **Bug Report**: Template strutturato per bug
- **Feature Request**: Template per nuove funzionalità

### PR Template
Checklist completa per assicurare qualità:
- [ ] Codice segue linee guida
- [ ] Self-review completata
- [ ] Documentazione aggiornata
- [ ] Test passano
- [ ] Docker build funziona

## 🤖 Dependabot

Aggiorna automaticamente:
- Python packages (settimanale)
- Docker images (settimanale)
- GitHub Actions (settimanale)

Configura in: `dependabot.yml`

## 📖 Documentazione

- **[INFRASTRUCTURE.md](INFRASTRUCTURE.md)**: Riepilogo completo infrastruttura
- **[SETUP.md](SETUP.md)**: Guida setup dettagliata
- **[CONTRIBUTING.md](CONTRIBUTING.md)**: Come contribuire
- **[SECURITY.md](SECURITY.md)**: Policy sicurezza
- **[COMMANDS.md](COMMANDS.md)**: Comandi Git comuni

## 🔐 Sicurezza

### Secrets Richiesti

| Nome | Obbligatorio | Descrizione |
|------|--------------|-------------|
| `SERVER_HOST` | ✅ | IP/dominio server |
| `SERVER_USER` | ✅ | Username SSH |
| `SSH_KEY` | ✅ | Chiave privata SSH |
| `TELEGRAM_BOT_TOKEN` | ❌ | Bot Telegram |
| `TELEGRAM_CHAT_ID` | ❌ | Chat ID Telegram |

### Best Practices

- ✅ Non committare mai `.env` o secrets
- ✅ Usa sempre GitHub Secrets
- ✅ Mantieni aggiornate le dipendenze
- ✅ Rivedi PR prima del merge
- ✅ Testa localmente prima del push

## 🚀 Deploy

### Automatico
Push su `main` → Deploy automatico su server

### Manuale
```bash
# Vai su Actions → CI/CD Pipeline → Run workflow
# Seleziona branch e conferma
```

### Rollback
```bash
# Sul server
cd /home/deploy/image-presentation-ai
git checkout <commit-precedente>
docker compose down && docker compose up -d --build
```

## 📊 Monitoraggio

- **Actions**: Pipeline status
- **Security**: Dependabot alerts
- **Insights**: Repository analytics
- **Telegram**: Notifiche real-time (se configurato)

## 🆘 Troubleshooting

### Pipeline Fallisce

1. Verifica logs in Actions tab
2. Controlla secrets configurati
3. Testa build Docker localmente
4. Verifica connessione SSH al server

### Deploy Non Funziona

1. Verifica `SERVER_HOST` raggiungibile
2. Controlla chiave SSH valida
3. Verifica permessi directory deploy
4. Controlla logs server: `docker compose logs`

### Tests Falliscono

```bash
# Esegui localmente
pytest tests/ -v
flake8 app/
black --check app/
```

## 🔗 Link Utili

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Docker Docs](https://docs.docker.com/)
- [Dependabot Docs](https://docs.github.com/en/code-security/dependabot)

---

**Domande?** Apri un issue o consulta la documentazione nel repo.
