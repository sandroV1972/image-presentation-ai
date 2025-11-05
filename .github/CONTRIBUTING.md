# Guida al Contributo

Grazie per il tuo interesse nel contribuire a **Image Presentation AI**! 🎉

## Come Contribuire

### 1. Fork del Repository
Fai un fork del repository e clonalo localmente:
```bash
git clone https://github.com/<tuo-username>/image-presentation-ai.git
cd image-presentation-ai
```

### 2. Crea un Branch
Crea un branch per la tua feature o bugfix:
```bash
git checkout -b feature/nome-feature
# oppure
git checkout -b hotfix/nome-fix
```

### 3. Sviluppa e Testa
- Scrivi codice pulito e ben commentato
- Segui le convenzioni di stile Python (PEP 8)
- Aggiungi test per le nuove funzionalità
- Esegui i test localmente:
```bash
pytest tests/
flake8 app/
black app/
```

### 4. Commit
Usa messaggi di commit chiari e descrittivi:
```bash
git commit -m "feat: aggiunta classificazione automatica immagini"
git commit -m "fix: risolto bug upload file grandi"
git commit -m "docs: aggiornata documentazione API"
```

Convenzioni per i messaggi di commit:
- `feat:` nuova funzionalità
- `fix:` correzione bug
- `docs:` modifiche alla documentazione
- `style:` formattazione codice
- `refactor:` refactoring
- `test:` aggiunta o modifica test
- `chore:` modifiche build o dipendenze

### 5. Push e Pull Request
```bash
git push origin feature/nome-feature
```

Apri una Pull Request su GitHub con:
- Descrizione chiara delle modifiche
- Riferimenti agli issue correlati
- Screenshot se applicabile
- Checklist completata

## Standard di Codice

### Python
- Usa Python 3.11+
- Segui PEP 8
- Usa type hints dove possibile
- Documenta le funzioni con docstring

### Testing
- Scrivi test unitari per nuove funzionalità
- Mantieni la copertura dei test >80%
- Usa pytest come framework di testing

### Docker
- Testa sempre il build Docker prima del commit
- Mantieni le immagini leggere e ottimizzate

## Processo di Review

1. Un maintainer revisionerà la tua PR
2. Potrebbero essere richieste modifiche
3. Una volta approvata, la PR verrà mergiata
4. Il codice verrà automaticamente deployato tramite CI/CD

## Segnalazione Bug

Usa i template degli issue per segnalare bug o proporre feature.

## Domande?

Apri una discussione in **GitHub Discussions** o contatta i maintainer.

Grazie per il tuo contributo! 🚀
