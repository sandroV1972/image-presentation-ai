# Changelog

Tutte le modifiche significative al progetto verranno documentate in questo file.

Il formato è basato su [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
e questo progetto aderisce al [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Integrazione con modelli AI (Ollama, OpenAI)
- Supporto GPU per classificazione CNN
- Interfaccia multiutente
- Database PostgreSQL per storico operazioni
- API REST completa con FastAPI

## [1.0.0] - 2025-11-05

### Added
- Interfaccia web Flask per upload immagini
- Modulo di classificazione automatica con OpenCV
- Generazione PDF dinamica con ReportLab
- Sistema di template personalizzabili
- Containerizzazione Docker
- Pipeline CI/CD con GitHub Actions
- Documentazione tecnica completa
- Sistema di backup automatico
- Integrazione n8n per automazioni

### Security
- Validazione upload file (estensioni e dimensioni)
- Isolamento container Docker
- Gestione sicura delle variabili d'ambiente

---

## Come Contribuire al Changelog

Quando apporti modifiche significative:
1. Aggiungi una voce sotto `[Unreleased]`
2. Usa le categorie: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`
3. Durante un release, sposta le modifiche sotto una nuova versione con data

Esempio:
```markdown
## [Unreleased]

### Added
- Nuova funzionalità di export multiplo

### Fixed
- Risolto bug caricamento immagini HEIC
```
