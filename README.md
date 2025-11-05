# Image Presentation AI

[![CI/CD Pipeline](https://github.com/YOUR_USERNAME/image-presentation-ai/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/YOUR_USERNAME/image-presentation-ai/actions)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)
[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Sistema open-source per riconoscere automaticamente immagini cliniche e generare presentazioni standardizzate con AI.

## 🚀 Funzionalità

- ✅ **Upload multiplo** di immagini con validazione automatica
- 🤖 **Riconoscimento automatico** tramite OpenCV e algoritmi ML
- 📄 **Generazione PDF/Presentazioni** dinamiche con ReportLab
- 🎨 **Template personalizzabili** caricabili e modificabili
- 🐳 **Deploy Docker** con Docker Compose
- ⚡ **Automazioni n8n** per workflow avanzati
- 🔄 **CI/CD completo** con GitHub Actions
- 📊 **Monitoraggio** e logging centralizzato

## 📋 Requisiti

- Python 3.11+
- Docker & Docker Compose (per deploy containerizzato)
- Git

## 🏁 Avvio Rapido

### Ambiente Locale

```bash
# Clona il repository
git clone https://github.com/YOUR_USERNAME/image-presentation-ai.git
cd image-presentation-ai

# Crea virtual environment
python3 -m venv venv
source venv/bin/activate  # Su Windows: venv\Scripts\activate

# Installa dipendenze
pip install -r requirements.txt

# Avvia l'applicazione
python app/main.py
```

Apri il browser su [http://localhost:8080](http://localhost:8080)

### Deploy con Docker

```bash
# Build e avvio con Docker Compose
docker compose up -d

# Verifica stato
docker compose ps

# Visualizza logs
docker compose logs -f web
```

## 📚 Documentazione

La documentazione completa è disponibile nella directory [`docs/`](docs/):

- [01 - Infrastruttura Tecnica](docs/01_infrastruttura_tecnica.md)
- [02 - Documento di Progetto](docs/02_documento_progetto.md)
- [03 - Tools e Ambiente](docs/03_tools_e_ambiente.md)
- [04 - Case Scenarios](docs/04_case_scenarios.md)
- [05 - API e Deploy](docs/05_api_e_deploy.md)
- [06 - Roadmap](docs/06_roadmap.md)
- [07 - Licenza e Crediti](docs/07_licenza_e_crediti.md)
- [08 - Pipeline DevOps](docs/08_devops_pipeline.md)

### Guide GitHub

- [📖 Setup Repository](.github/SETUP.md) - Configurazione completa GitHub
- [🤝 Contributing](.github/CONTRIBUTING.md) - Guida per contribuire
- [🔒 Security](.github/SECURITY.md) - Policy di sicurezza
- [💻 Git Commands](.github/COMMANDS.md) - Comandi Git utili

## 🏗️ Architettura

```
┌─────────────────┐
│  Web Frontend   │
│ (Flask + Jinja) │
└────────┬────────┘
         │
┌────────▼────────┐
│  Backend API    │
│  Upload & Flow  │
└────────┬────────┘
         │
┌────────▼────────┐
│ OpenCV/AI Class │
│   Classifier    │
└────────┬────────┘
         │
┌────────▼────────┐
│ PDF Generator   │
│   (ReportLab)   │
└────────┬────────┘
         │
┌────────▼────────┐
│ Storage + n8n   │
│   Automation    │
└─────────────────┘
```

## 🔧 Configurazione

### Variabili d'Ambiente

Crea un file `.env` nella root del progetto:

```env
# Flask
FLASK_ENV=production
SECRET_KEY=your-secret-key-here
UPLOAD_FOLDER=data/uploads
OUTPUT_FOLDER=data/output
MAX_FILE_SIZE=20971520  # 20MB

# Server
HOST=0.0.0.0
PORT=8080

# n8n (opzionale)
N8N_WEBHOOK_URL=http://localhost:5678/webhook/
```

## 🧪 Testing

```bash
# Esegui tutti i test
pytest tests/

# Con coverage
pytest tests/ --cov=app --cov-report=html

# Lint del codice
flake8 app/
black app/ --check
```

## 🚀 Deploy in Produzione

### GitHub Actions CI/CD

Il progetto include pipeline automatizzate per:
- ✅ Test e linting automatici
- 🏗️ Build Docker image
- 🚀 Deploy automatico su server
- 📦 Pubblicazione su GitHub Container Registry
- 🗄️ Backup automatici giornalieri

Vedi [SETUP.md](.github/SETUP.md) per la configurazione completa.

### Server Mac Studio / Linux

```bash
# Sul server
git clone https://github.com/YOUR_USERNAME/image-presentation-ai.git
cd image-presentation-ai
docker compose up -d

# Configura backup automatici
crontab -e
# Aggiungi: 0 2 * * * cd /path/to/project && docker compose exec web python backup.py
```

## 🤝 Contribuire

Contributi, issue e feature request sono benvenuti!

1. Fork del progetto
2. Crea il tuo branch (`git checkout -b feature/AmazingFeature`)
3. Commit delle modifiche (`git commit -m 'feat: add amazing feature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

Leggi [CONTRIBUTING.md](.github/CONTRIBUTING.md) per i dettagli.

## 📝 Changelog

Vedi [CHANGELOG.md](CHANGELOG.md) per la cronologia delle modifiche.

## 🔐 Sicurezza

Per segnalare vulnerabilità di sicurezza, vedi [SECURITY.md](.github/SECURITY.md).

## 📄 Licenza

Questo progetto è distribuito sotto licenza MIT. Vedi [LICENSE](LICENSE) per i dettagli.

## 👥 Autori

- **Alessandro Valenti** - *Ideazione e sviluppo iniziale*

## 🙏 Ringraziamenti

- Community OpenCV
- Flask Framework
- Docker Community
- Tutti i contributori

---

<div align="center">

**[Documentazione](docs/)** • **[Issues](https://github.com/YOUR_USERNAME/image-presentation-ai/issues)** • **[Roadmap](docs/06_roadmap.md)**

Made with ❤️ for healthcare professionals

</div>
