# GitHub Workflow Commands

Quick reference per i comandi più comuni nel workflow GitHub.

## Branch Management

```bash
# Crea e passa a un nuovo branch
git checkout -b feature/nome-feature

# Aggiorna branch corrente con main
git pull origin main

# Lista tutti i branch
git branch -a

# Elimina branch locale
git branch -d feature/nome-feature

# Elimina branch remoto
git push origin --delete feature/nome-feature
```

## Workflow Tipico per Nuova Feature

```bash
# 1. Aggiorna main locale
git checkout main
git pull origin main

# 2. Crea nuovo branch
git checkout -b feature/nuova-funzionalità

# 3. Sviluppa e testa
# ... modifiche al codice ...

# 4. Verifica modifiche
git status
git diff

# 5. Staging e commit
git add .
git commit -m "feat: aggiunta nuova funzionalità"

# 6. Push al repository remoto
git push origin feature/nuova-funzionalità

# 7. Apri Pull Request su GitHub
# Vai su GitHub → Pull Requests → New Pull Request
```

## Hotfix Workflow

```bash
# 1. Crea branch hotfix da main
git checkout main
git pull origin main
git checkout -b hotfix/descrizione-fix

# 2. Applica fix
# ... modifiche al codice ...

# 3. Commit e push
git commit -am "fix: risolto bug critico"
git push origin hotfix/descrizione-fix

# 4. Apri PR con label priority:high
```

## Gestione Release

```bash
# 1. Aggiorna CHANGELOG.md
# Sposta le modifiche da [Unreleased] a [x.y.z]

# 2. Crea tag versione
git tag -a v1.0.0 -m "Release versione 1.0.0"
git push origin v1.0.0

# 3. Crea Release su GitHub
# GitHub → Releases → Create a new release
# Seleziona il tag appena creato
```

## Comandi Utili Git

```bash
# Annulla ultimo commit (mantieni modifiche)
git reset --soft HEAD~1

# Annulla modifiche non staged
git checkout -- .

# Visualizza log dei commit
git log --oneline --graph --all

# Trova commit che ha introdotto un bug
git bisect start
git bisect bad  # commit corrente è buggato
git bisect good <commit-id>  # questo commit era ok

# Stash temporaneo modifiche
git stash
git stash pop  # recupera stash
```

## Sync Fork con Upstream

```bash
# 1. Aggiungi remote upstream (solo prima volta)
git remote add upstream https://github.com/original-repo/image-presentation-ai.git

# 2. Fetch e merge da upstream
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## GitHub CLI (gh)

```bash
# Installa GitHub CLI
brew install gh  # macOS

# Login
gh auth login

# Crea PR da CLI
gh pr create --title "feat: nuova feature" --body "Descrizione"

# Lista PR aperte
gh pr list

# Merge PR
gh pr merge 123

# Visualizza issue
gh issue list
gh issue create

# Clona repository
gh repo clone username/image-presentation-ai
```

## Docker + Git Workflow

```bash
# Rebuild dopo modifiche
git pull origin main
docker compose down
docker compose build --no-cache
docker compose up -d

# Verifica logs
docker compose logs -f web

# Cleanup immagini vecchie
docker image prune -a
```

## Pre-commit Checks

```bash
# Esegui test prima del commit
pytest tests/
flake8 app/
black --check app/

# Testa Docker build
docker build -t image-presentation-ai:test .

# Se tutto ok, procedi con commit
git commit -m "..."
```

## Troubleshooting

```bash
# Reset completo a origin/main (ATTENZIONE: perdi modifiche locali)
git fetch origin
git reset --hard origin/main

# Recupera file cancellato
git checkout HEAD -- percorso/file.py

# Visualizza differenze tra branch
git diff main..feature/nome-branch

# Trova chi ha modificato una linea
git blame app/main.py
```

---

💡 **Tip**: Aggiungi alias Git utili nel tuo `~/.gitconfig`:

```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    lg = log --oneline --graph --all --decorate
    unstage = reset HEAD --
```
