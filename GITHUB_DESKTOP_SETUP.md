# 🚀 Guida Rapida: Pubblicazione su GitHub

## ✅ Repository Git Inizializzato!

Il repository Git è stato creato con successo! Ora puoi usare **GitHub Desktop** o la **riga di comando** per pubblicare su GitHub.

---

## 📱 Opzione 1: GitHub Desktop (Consigliato)

### Passo 1: Apri GitHub Desktop

1. Apri **GitHub Desktop**
2. Vai su **File → Add Local Repository**
3. Clicca **Choose...** e seleziona:
   ```
   /Users/alessandrovalenti/Library/Application Support/DeepAgent/Workspaces/image-presentation-ai
   ```
4. Clicca **Add Repository**

### Passo 2: Pubblica su GitHub

1. GitHub Desktop ora mostra il repository con 1 commit
2. Clicca su **Publish repository** (in alto a destra)
3. Configura:
   - **Name**: `image-presentation-ai`
   - **Description**: `Sistema AI per riconoscimento e presentazione immagini cliniche`
   - ⚠️ **IMPORTANTE**: Deseleziona "Keep this code private" se vuoi renderlo pubblico
4. Clicca **Publish Repository**

### ✅ Fatto!

Il repository è ora su GitHub! Vai su:
```
https://github.com/sandroV1972/image-presentation-ai
```

---

## 💻 Opzione 2: Riga di Comando

### Se preferisci usare il terminale:

```bash
# Vai nella directory del progetto
cd "/Users/alessandrovalenti/Library/Application Support/DeepAgent/Workspaces/image-presentation-ai"

# Aggiungi il remote GitHub (sostituisci USERNAME con il tuo username)
git remote add origin https://github.com/USERNAME/image-presentation-ai.git

# Oppure con SSH (se hai configurato le chiavi SSH)
git remote add origin git@github.com:USERNAME/image-presentation-ai.git

# Push del codice
git push -u origin main
```

---

## 🔧 Prossimi Passi Dopo la Pubblicazione

### 1. Configura GitHub Secrets

Vai su **Settings → Secrets and variables → Actions → New repository secret**

Aggiungi i seguenti secrets per abilitare il deploy automatico:

| Nome Secret | Valore | Descrizione |
|------------|--------|-------------|
| `SERVER_HOST` | `192.168.1.100` | IP o dominio del tuo server |
| `SERVER_USER` | `deploy` | Username SSH |
| `SSH_KEY` | `contenuto chiave privata` | Chiave SSH per accesso server |
| `TELEGRAM_BOT_TOKEN` | (opzionale) | Token bot Telegram |
| `TELEGRAM_CHAT_ID` | (opzionale) | Chat ID Telegram |

**Come ottenere SSH_KEY**:
```bash
# Sul tuo Mac, genera una chiave SSH (se non ce l'hai)
ssh-keygen -t ed25519 -C "github-deploy"

# Visualizza la chiave privata da copiare in GitHub Secrets
cat ~/.ssh/id_ed25519

# Copia la chiave pubblica sul server
ssh-copy-id user@server
```

### 2. Attiva Branch Protection

Vai su **Settings → Branches → Add branch protection rule**

- **Branch name pattern**: `main`
- ✅ Require a pull request before merging
- ✅ Require approvals: 1
- ✅ Require status checks to pass before merging
  - Seleziona: `Lint and Test`, `Build Docker Image`
- ✅ Require branches to be up to date before merging

### 3. Verifica GitHub Actions

Dopo la pubblicazione:

1. Vai su **Actions** tab
2. Dovresti vedere i workflow disponibili:
   - CI/CD Pipeline
   - Code Quality
   - Docker Publish
   - Automated Backup

Le Actions partiranno automaticamente al prossimo push!

### 4. Testa la Pipeline

```bash
# Crea un branch di test
git checkout -b test/github-actions

# Fai una modifica
echo "# Test" >> test.md

# Commit e push
git add test.md
git commit -m "test: verifica GitHub Actions"
git push -u origin test/github-actions
```

Poi su GitHub:
- Vai su **Pull Requests**
- Clicca **New Pull Request**
- Seleziona `test/github-actions` → `main`
- Verifica che le Actions vengano eseguite ✅

---

## 📊 Stato Attuale Repository

```
Branch: main
Commit: 672d94e
File: 48 files
Righe: 3,759 insertions
Status: ✅ Ready to publish
```

**Contenuto del repository**:
- ✅ Applicazione Flask completa
- ✅ GitHub Actions workflows (4)
- ✅ Testing infrastructure
- ✅ Documentazione estensiva
- ✅ Developer tools
- ✅ Docker configuration

---

## 🆘 Risoluzione Problemi

### GitHub Desktop non vede il repository

1. **Chiudi e riapri GitHub Desktop**
2. Assicurati di selezionare la directory corretta:
   ```
   /Users/alessandrovalenti/Library/Application Support/DeepAgent/Workspaces/image-presentation-ai
   ```
3. Se ancora non funziona, usa **File → Add Local Repository** invece di aprire la directory

### "Repository already exists on GitHub"

Se hai già creato un repository vuoto su GitHub:

```bash
# Aggiungi il remote esistente
git remote add origin https://github.com/USERNAME/image-presentation-ai.git

# Push del codice
git push -u origin main
```

### Errore di autenticazione

Se GitHub chiede username/password ma non funziona:

1. Usa un **Personal Access Token** invece della password
2. Vai su GitHub → Settings → Developer settings → Personal access tokens
3. Genera un nuovo token con permessi `repo`
4. Usa il token come password

Oppure configura SSH:
```bash
# Genera chiave SSH
ssh-keygen -t ed25519 -C "your_email@example.com"

# Aggiungi chiave a GitHub
# Copia il contenuto di:
cat ~/.ssh/id_ed25519.pub

# Vai su GitHub → Settings → SSH and GPG keys → New SSH key
# Incolla la chiave pubblica
```

---

## 🎯 Quick Reference

### Comandi Git Utili

```bash
# Stato repository
git status

# Log commit
git log --oneline

# Verifica remote
git remote -v

# Aggiungi remote
git remote add origin URL

# Push su GitHub
git push -u origin main

# Pull da GitHub
git pull origin main

# Crea nuovo branch
git checkout -b feature/nome

# Cambia branch
git checkout main

# Lista branch
git branch -a
```

### Comandi Makefile

```bash
# Mostra tutti i comandi
make help

# Test pipeline localmente
make quality
make test
make docker-build
```

---

## 📚 Documentazione

Per maggiori dettagli consulta:

- **[GITHUB_SETUP_COMPLETE.md](../GITHUB_SETUP_COMPLETE.md)** - Setup completo
- **[.github/QUICKSTART.md](../.github/QUICKSTART.md)** - Quick start
- **[.github/SETUP.md](../.github/SETUP.md)** - Configurazione GitHub
- **[.github/COMMANDS.md](../.github/COMMANDS.md)** - Comandi Git

---

## ✅ Checklist Post-Pubblicazione

- [ ] Repository pubblicato su GitHub
- [ ] GitHub Secrets configurati (SERVER_HOST, SERVER_USER, SSH_KEY)
- [ ] Branch Protection attivata su `main`
- [ ] GitHub Actions verificate (tab Actions)
- [ ] README.md visibile con badges
- [ ] Test pipeline con PR di prova
- [ ] Deploy automatico testato

---

**Ora sei pronto! Apri GitHub Desktop e pubblica il repository!** 🚀

*Guida creata: 5 Novembre 2025*
