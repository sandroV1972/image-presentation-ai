#!/bin/bash

# 🚀 Script di inizializzazione GitHub Infrastructure
# Questo script esegue il setup iniziale e il primo commit

set -e  # Exit on error

echo "🎉 Inizializzazione Image Presentation AI - GitHub Infrastructure"
echo "================================================================="
echo ""

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Funzione per stampare step
print_step() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# 1. Verifica Git
echo "1️⃣  Verifico configurazione Git..."
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Non sei in un repository Git!"
    echo "Inizializzo repository..."
    git init
    print_step "Repository Git inizializzato"
else
    print_step "Repository Git trovato"
fi

# 2. Verifica configurazione Git
echo ""
echo "2️⃣  Verifico configurazione utente Git..."
if ! git config user.name > /dev/null 2>&1; then
    print_warning "Nome utente Git non configurato"
    read -p "Inserisci il tuo nome: " git_name
    git config user.name "$git_name"
fi

if ! git config user.email > /dev/null 2>&1; then
    print_warning "Email Git non configurata"
    read -p "Inserisci la tua email: " git_email
    git config user.email "$git_email"
fi

print_step "Utente Git: $(git config user.name) <$(git config user.email)>"

# 3. Crea .env da .env.example
echo ""
echo "3️⃣  Configurazione ambiente..."
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        print_step "File .env creato da .env.example"
        print_warning "IMPORTANTE: Modifica .env con le tue configurazioni!"
    else
        print_warning ".env.example non trovato, saltato"
    fi
else
    print_step "File .env già esistente"
fi

# 4. Crea directory necessarie
echo ""
echo "4️⃣  Creazione directory..."
mkdir -p data/uploads data/output data/temp logs backups
print_step "Directory create: data/, logs/, backups/"

# 5. Verifica dipendenze Python (opzionale)
echo ""
echo "5️⃣  Verifica ambiente Python..."
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version)
    print_step "Python trovato: $python_version"
    
    if [ -d "venv" ]; then
        print_step "Virtual environment già esistente"
    else
        print_warning "Virtual environment non trovato"
        read -p "Vuoi creare un virtual environment? (s/n): " create_venv
        if [ "$create_venv" = "s" ] || [ "$create_venv" = "S" ]; then
            python3 -m venv venv
            print_step "Virtual environment creato in ./venv"
            echo "Attivalo con: source venv/bin/activate"
        fi
    fi
else
    print_warning "Python3 non trovato nel PATH"
fi

# 6. Git add all
echo ""
echo "6️⃣  Preparazione commit iniziale..."
git add .
print_step "File staged per commit"

# Mostra file staged
echo ""
echo "File da committare:"
git status --short

# 7. Verifica se ci sono modifiche
if git diff --cached --quiet; then
    print_warning "Nessuna modifica da committare"
    echo "L'infrastruttura potrebbe essere già stata committata"
    exit 0
fi

# 8. Commit
echo ""
echo "7️⃣  Creazione commit iniziale..."
read -p "Vuoi procedere con il commit? (s/n): " do_commit

if [ "$do_commit" = "s" ] || [ "$do_commit" = "S" ]; then
    git commit -m "chore: setup complete GitHub infrastructure

- Add GitHub Actions workflows (CI/CD, quality, docker, backup)
- Add issue and PR templates
- Add comprehensive documentation
- Add testing infrastructure
- Add developer tools (Makefile, setup.cfg)
- Add security policies and contributing guidelines
- Configure Dependabot for automated updates
- Update README with badges and detailed info

This commit establishes the complete DevOps infrastructure for
Image Presentation AI project, ready for collaborative development
and automated deployments."
    
    print_step "Commit creato con successo!"
    
    # 9. Branch info
    echo ""
    echo "8️⃣  Informazioni branch..."
    current_branch=$(git branch --show-current)
    print_step "Branch corrente: $current_branch"
    
    # 10. Remote check
    echo ""
    echo "9️⃣  Verifica remote repository..."
    if git remote get-url origin > /dev/null 2>&1; then
        remote_url=$(git remote get-url origin)
        print_step "Remote origin: $remote_url"
        
        echo ""
        read -p "Vuoi fare push su origin/$current_branch? (s/n): " do_push
        if [ "$do_push" = "s" ] || [ "$do_push" = "S" ]; then
            git push -u origin $current_branch
            print_step "Push completato!"
        else
            echo "Push saltato. Puoi farlo manualmente con:"
            echo "  git push -u origin $current_branch"
        fi
    else
        print_warning "Nessun remote 'origin' configurato"
        echo ""
        echo "Per aggiungere un remote:"
        echo "  git remote add origin https://github.com/USERNAME/image-presentation-ai.git"
        echo "  git push -u origin $current_branch"
    fi
else
    print_warning "Commit saltato"
    echo "Puoi committare manualmente con:"
    echo "  git commit -m 'chore: setup GitHub infrastructure'"
fi

# 11. Final checklist
echo ""
echo "================================================================="
echo "✅ Setup completato!"
echo "================================================================="
echo ""
echo "📋 Prossimi passi:"
echo ""
echo "1. Se non l'hai fatto, crea un repository su GitHub:"
echo "   https://github.com/new"
echo ""
echo "2. Aggiungi il remote (se non presente):"
echo "   git remote add origin https://github.com/USERNAME/image-presentation-ai.git"
echo ""
echo "3. Push del codice:"
echo "   git push -u origin main"
echo ""
echo "4. Configura GitHub Secrets:"
echo "   Settings → Secrets and variables → Actions"
echo "   - SERVER_HOST"
echo "   - SERVER_USER"
echo "   - SSH_KEY"
echo ""
echo "5. Attiva Branch Protection:"
echo "   Settings → Branches → Add branch protection rule"
echo ""
echo "6. Testa la pipeline:"
echo "   Actions → CI/CD Pipeline"
echo ""
echo "📚 Documentazione completa in:"
echo "   - .github/QUICKSTART.md    (guida rapida)"
echo "   - .github/SETUP.md         (setup dettagliato)"
echo "   - .github/README.md        (overview .github)"
echo ""
echo "🚀 Buon sviluppo!"
echo ""
