# Configurazione GitHub Repository

Questa guida spiega come configurare correttamente il repository GitHub per **Image Presentation AI** per utilizzare tutte le funzionalità CI/CD.

## 1. Secrets da Configurare

Vai su **Settings → Secrets and variables → Actions → New repository secret** e aggiungi i seguenti secrets:

### Secrets per Deploy
| Nome Secret | Descrizione | Esempio |
|------------|-------------|---------|
| `SERVER_HOST` | IP o dominio del server di produzione | `192.168.1.100` o `server.example.com` |
| `SERVER_USER` | Username SSH per accedere al server | `deploy` |
| `SERVER_PORT` | Porta SSH (opzionale, default 22) | `22` |
| `SSH_KEY` | Chiave privata SSH per l'autenticazione | Contenuto del file `~/.ssh/id_rsa` |
| `DEPLOY_PATH` | Path sul server dove è installata l'app | `/home/deploy/image-presentation-ai` |

### Secrets per Notifiche (Opzionali)
| Nome Secret | Descrizione |
|------------|-------------|
| `TELEGRAM_BOT_TOKEN` | Token del bot Telegram per notifiche |
| `TELEGRAM_CHAT_ID` | ID della chat Telegram dove inviare notifiche |

## 2. Protezione Branch

Vai su **Settings → Branches → Add branch protection rule**:

### Regole per `main`:
- ✅ Require a pull request before merging
- ✅ Require approvals (almeno 1)
- ✅ Require status checks to pass before merging
  - Seleziona: `Lint and Test`, `Build Docker Image`
- ✅ Require branches to be up to date before merging
- ✅ Do not allow bypassing the above settings

### Regole per `dev`:
- ✅ Require status checks to pass before merging
- ✅ Require branches to be up to date before merging

## 3. GitHub Actions Permissions

Vai su **Settings → Actions → General**:

- **Workflow permissions**: Seleziona "Read and write permissions"
- ✅ Allow GitHub Actions to create and approve pull requests

## 4. Abilitare Dependabot

Dependabot è già configurato nel file `.github/dependabot.yml`.

Per verificare: vai su **Security → Dependabot** e assicurati che sia attivo.

## 5. Abilitare GitHub Packages (Opzionale)

Se vuoi pubblicare le Docker images su GitHub Container Registry:

1. Vai su **Settings → Actions → General**
2. Abilita "Read and write permissions" per `GITHUB_TOKEN`

Le immagini Docker saranno pubblicate automaticamente su `ghcr.io/<username>/image-presentation-ai`

## 6. Labels Consigliate

Crea le seguenti labels per organizzare meglio gli issue e PR:

| Label | Colore | Descrizione |
|-------|--------|-------------|
| `bug` | `#d73a4a` | Qualcosa non funziona |
| `enhancement` | `#a2eeef` | Nuova funzionalità o richiesta |
| `documentation` | `#0075ca` | Miglioramenti alla documentazione |
| `dependencies` | `#0366d6` | Aggiornamento dipendenze |
| `python` | `#3572A5` | Codice Python |
| `docker` | `#384d54` | Docker/Container |
| `github-actions` | `#000000` | GitHub Actions workflow |
| `priority:high` | `#b60205` | Alta priorità |
| `priority:low` | `#0e8a16` | Bassa priorità |
| `good first issue` | `#7057ff` | Buono per i nuovi contributori |

## 7. Generare Chiave SSH per Deploy

Sul server di produzione:

```bash
# Genera una nuova chiave SSH
ssh-keygen -t ed25519 -C "github-actions-deploy" -f ~/.ssh/github_deploy

# Aggiungi la chiave pubblica alle authorized_keys
cat ~/.ssh/github_deploy.pub >> ~/.ssh/authorized_keys

# Copia la chiave privata (da aggiungere ai GitHub Secrets)
cat ~/.ssh/github_deploy
```

Incolla il contenuto della chiave privata nel secret `SSH_KEY` su GitHub.

## 8. Test della Pipeline

Dopo aver configurato tutti i secrets:

1. Fai un commit di test su un branch:
```bash
git checkout -b test/pipeline
echo "test" >> test.txt
git add .
git commit -m "test: verifica pipeline CI/CD"
git push origin test/pipeline
```

2. Apri una Pull Request verso `dev`
3. Verifica che le GitHub Actions vengano eseguite correttamente
4. Se tutto funziona, fai il merge

## 9. Monitoraggio

- **Actions tab**: per vedere lo stato delle pipeline
- **Security tab**: per vedere le vulnerabilità rilevate da Dependabot
- **Insights → Pulse**: per vedere l'attività del repository
- **Insights → Code frequency**: per vedere statistiche sui commit

## 10. Configurazione Telegram Bot (Opzionale)

Per ricevere notifiche su Telegram:

1. Crea un bot con [@BotFather](https://t.me/botfather)
2. Copia il token ricevuto
3. Avvia il bot e invia un messaggio
4. Ottieni il chat ID visitando: `https://api.telegram.org/bot<TOKEN>/getUpdates`
5. Aggiungi `TELEGRAM_BOT_TOKEN` e `TELEGRAM_CHAT_ID` ai GitHub Secrets

---

## Checklist Configurazione Completa

- [ ] Secrets configurati (SERVER_HOST, SERVER_USER, SSH_KEY)
- [ ] Branch protection attivata per `main`
- [ ] GitHub Actions permissions configurate
- [ ] Dependabot abilitato
- [ ] Labels create
- [ ] SSH key generata e configurata
- [ ] Pipeline testata con successo
- [ ] Notifiche Telegram configurate (opzionale)

✅ **Configurazione completata!** Il repository è pronto per il workflow DevOps completo.
