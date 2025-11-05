# Documento Tecnico: Infrastruttura del Sistema "Image Presentation AI"

## 1. Panoramica Generale

Il sistema **Image Presentation AI** è progettato per automatizzare la gestione e la presentazione di immagini cliniche, integrando algoritmi di riconoscimento automatico, generazione dinamica di presentazioni e un'interfaccia web intuitiva. L'obiettivo è offrire un'architettura scalabile, modulare e facilmente distribuibile sia in ambiente locale (on-premise) sia in infrastrutture cloud o ibride.

L'applicazione si basa su una **stack tecnologica ibrida Python + Web**, con una struttura containerizzata tramite Docker e automazioni opzionali gestite con n8n.

---

## 2. Architettura del Sistema

### 2.1 Componenti Principali

| Componente                    | Descrizione                                                                             | Tecnologie                                    |
| ----------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------- |
| **Frontend Web**              | Interfaccia utente per caricamento immagini, scelta del template e revisione automatica | HTML5, CSS3, Jinja2 (Flask templating)        |
| **Backend API**               | Gestione logica applicativa, classificazione immagini, generazione file                 | Flask (Python)                                |
| **Modulo di Riconoscimento**  | Analisi automatica delle immagini tramite feature extraction o modelli ML               | OpenCV, NumPy, (opzionale TensorFlow/PyTorch) |
| **Motore di Generazione PDF** | Creazione di report e presentazioni PDF basate su layout predefiniti                    | ReportLab                                     |
| **Storage Dati**              | Archiviazione immagini e presentazioni generate                                         | File System locale / NAS / S3 compatibile     |
| **Automazione dei Flussi**    | Gestione notifiche, esportazioni e pipeline automatizzate                               | n8n (Dockerized)                              |
| **Containerizzazione**        | Isolamento e portabilità dell'applicazione                                              | Docker, Docker Compose                        |

### 2.2 Architettura Logica

```
[Utente Web]
     ↓
[Frontend Flask + Template Jinja2]
     ↓
[API Flask - Upload e Analisi Immagini]
     ↓
[Modulo OpenCV → Classificazione]
     ↓
[Motore ReportLab → Generazione PDF]
     ↓
[Storage Locale/Cloud + Automazioni n8n]
```

Ogni componente è disaccoppiato e comunicante attraverso interfacce REST o condivisione di file strutturati in JSON, garantendo indipendenza e scalabilità.

---

## 3. Dettaglio Tecnico dei Moduli

### 3.1 Backend Flask

Il backend Flask gestisce:

* Routing HTTP (upload, anteprima, generazione, download)
* Validazione dei file e controllo formati
* Logging interno e monitoraggio operazioni
* Connessione con moduli esterni (OpenCV, ReportLab, n8n)

Esempio di endpoint:

```python
@app.route('/api/classify', methods=['POST'])
def classify_endpoint():
    file = request.files['image']
    path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(path)
    result = classify_image(path)
    return jsonify({"file": file.filename, "class": result})
```

### 3.2 Modulo OpenCV e AI

Il modulo di riconoscimento utilizza **feature extraction** (luminosità, contorni, forme) o modelli ML pre-addestrati per categorizzare le immagini.

Pipeline tipica:

1. Lettura immagine (`cv2.imread`)
2. Conversione in scala di grigi
3. Filtraggio (Gaussian blur, edge detection)
4. Estrazione di caratteristiche principali
5. Classificazione basata su soglie o modelli AI

In fase avanzata, è prevista l'integrazione con modelli CNN addestrati su dataset clinici specifici.

### 3.3 Generazione PDF (ReportLab)

Il motore di output usa ReportLab per:

* Inserire immagini nei punti predefiniti (layout JSON)
* Aggiungere testi descrittivi e metadati
* Generare file multipagina esportabili

Esempio di struttura layout:

```json
{
  "slots": [
    {"x": 50, "y": 100, "width": 300, "height": 200, "type": "viso"},
    {"x": 400, "y": 100, "width": 300, "height": 200, "type": "intraorale"}
  ]
}
```

---

## 4. Infrastruttura di Deploy

### 4.1 Ambiente Locale (sviluppo)

* **OS:** macOS / Linux
* **Web server interno:** Flask nativo (`python app/main.py`)
* **Storage:** directory locale `data/uploads` e `data/output`

### 4.2 Ambiente di Produzione (server Mac o Linux)

* **Docker Compose** per orchestrare:

  * `web`: container Flask
  * `n8n`: automazione flussi
  * `watchtower`: aggiornamenti automatici opzionali

Esempio `docker-compose.yml`:

```yaml
version: "3.8"
services:
  web:
    build: .
    ports:
      - "8080:8080"
    volumes:
      - ./data:/app/data
    restart: always
  n8n:
    image: n8nio/n8n
    ports:
      - "5678:5678"
    volumes:
      - ./n8n_data:/home/node/.n8n
```

### 4.3 Opzionale: Integrazione Cloud

* **Storage esterno:** AWS S3, Backblaze B2 o MinIO
* **Backup:** rsync, cronjob, o pipeline n8n
* **Accesso remoto:** tramite Cloudflare Tunnel o Nginx reverse proxy

---

## 5. Configurazioni Consigliate per Ambienti

| Ambiente | Descrizione | Configurazione |
|-----------|-------------|----------------|
| **Locale (sviluppo)** | Per test e debug. Permette di iterare rapidamente sul codice e testare l’upload e la classificazione in tempo reale. | Flask in modalità debug (`debug=True`), dati locali salvati in `data/uploads`. Logging dettagliato abilitato. |
| **Server Mac Studio** | Deploy interno per uso clinico o demo in rete locale. | Docker Compose con build automatica, volumi persistenti per i dati (`./data:/app/data`), e accesso tramite `http://localhost:8080` o IP LAN. |
| **Cloud (es. Render / AWS / DigitalOcean)** | Distribuzione pubblica per accesso remoto e scalabilità. | Deploy containerizzato (Docker), reverse proxy HTTPS (Nginx o Traefik), backup automatici su S3, e certificati SSL gestiti. |
| **NAS o Linux Server** | Archiviazione centralizzata e automazioni interne. | Montaggio volumi remoti via NFS o SMB, backup automatico giornaliero con `rsync` o `rclone`, e monitoraggio con `cron` o `systemd timers`. |

### 5.1 Modalità di Creazione degli Ambienti

#### Ambiente Locale
1. Clonare il repository: `git clone https://github.com/<utente>/image-presentation-ai.git`
2. Creare un virtual environment: `python3 -m venv venv`
3. Installare le dipendenze: `pip install -r requirements.txt`
4. Avviare l’applicazione: `python app/main.py`

#### Ambiente Server Mac Studio (Deploy Interno)
1. Installare Docker e Docker Compose.
2. Copiare la directory del progetto nel server.
3. Eseguire `docker compose up -d`.
4. Verificare l’accesso da altri dispositivi nella rete locale tramite IP del server.

#### Ambiente Cloud (Render / AWS / DigitalOcean)
1. Costruire l’immagine: `docker build -t image-presentation-ai .`
2. Pubblicare su un registry (Docker Hub, ECR, ecc.).
3. Configurare un reverse proxy con HTTPS.
4. Impostare variabili d’ambiente per i percorsi dati e sicurezza (es. `SECRET_KEY`, `UPLOAD_FOLDER`).

#### Ambiente NAS o Linux Server
1. Montare un volume di rete (es. `/mnt/nas_data`).
2. Modificare `docker-compose.yml` per puntare ai volumi montati.
3. Configurare backup automatici con `cron` o `systemd`.
4. Facoltativo: integrazione con `n8n` per sincronizzazione e notifiche.

---

## 6. Sicurezza e Accesso

* **Autenticazione opzionale:** futura integrazione di Flask-Login o JWT per accesso utenti.
* **Upload sicuro:** controllo estensione file e dimensione massima (<20MB)
* **Isolamento container:** sandbox Docker, nessun accesso esterno diretto al filesystem host.
* **Backup automatici:** sincronizzazione periodica verso destinazioni cifrate.

---

## 7. Pipeline CI/CD e Infrastruttura DevOps

### 7.1 Cosa sono le Pipeline CI/CD

Le **pipeline CI/CD (Continuous Integration / Continuous Deployment)** sono una serie di processi automatizzati che garantiscono che ogni modifica al codice venga **testata, verificata e distribuita** senza interventi manuali.

Nel contesto del progetto *Image Presentation AI*, una pipeline CI/CD permette di:
- Eseguire test automatici sul codice Python (linting, test unitari);
- Costruire automaticamente l’immagine Docker ad ogni commit su GitHub;
- Eseguire il deploy automatico su un server o cloud (es. Render, AWS, o un server Mac interno);
- Mantenere l’app sempre aggiornata e stabile, riducendo errori umani.

### 7.2 Esempio di Pipeline (GitHub Actions)

File `.github/workflows/deploy.yml`:

```yaml
name: CI/CD
on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout codice
        uses: actions/checkout@v3

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install dipendenze
        run: pip install -r requirements.txt

      - name: Test linting
        run: flake8 app/

      - name: Build Docker image
        run: docker build -t image-presentation-ai .

      - name: Deploy su server remoto (via SSH)
        uses: appleboy/scp-action@master
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SSH_KEY }}
          source: ./
          target: /home/deploy/image-presentation-ai/

      - name: Restart container remoto
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SSH_KEY }}
          script: |
            cd /home/deploy/image-presentation-ai
            docker compose down && docker compose up -d
```

Questa pipeline costruisce e distribuisce automaticamente l’applicazione ogni volta che si aggiorna il codice nel branch `main`.

### 7.3 Versionamento (Git e GitHub)

Il **versionamento del codice** è gestito tramite Git. Ogni modifica è tracciata in un repository GitHub pubblico o privato.

Flusso di lavoro consigliato:
1. `main` → versione stabile in produzione
2. `dev` → ambiente di sviluppo
3. `feature/*` → branch per nuove funzionalità
4. `hotfix/*` → correzioni urgenti in produzione

Esempio di comandi principali:
```bash
git checkout -b feature/aggiunta-ai
# modifica codice
git commit -am "Aggiunto modulo AI base"
git push origin feature/aggiunta-ai
```

### 7.4 Infrastruttura DevOps nel progetto

Nel contesto di *Image Presentation AI*, l’infrastruttura DevOps include:
- **GitHub** come repository e sistema di versionamento;
- **GitHub Actions** come piattaforma CI/CD per test e deploy automatici;
- **Docker** come standard di containerizzazione per garantire coerenza tra ambienti;
- **n8n** come orchestratore di flussi e automazioni post-deploy (es. notifiche o backup);
- **Monitoraggio continuo** con logging centralizzato e alert automatici.

Questo approccio DevOps consente di unificare sviluppo, testing, deploy e monitoraggio in un ciclo continuo e affidabile.

---

## 8. Monitoraggio e Logging

* **Logging centralizzato:** `logging` Python con rotazione file
* **Performance metrics:** tempi di elaborazione e uso CPU/RAM (psutil)
* **n8n Webhooks:** per notifiche di completamento o errori
* **Alerting opzionale:** via Telegram, email o Slack webhook

---

## 9. Scalabilità e Futuri Sviluppi

* Migrazione a **FastAPI** per migliorare la performance in I/O intensivo
* Supporto **GPU (CUDA)** per modelli CNN tramite PyTorch o TensorFlow
* Introduzione di **database relazionale** (PostgreSQL) per tracciare metadati e storico report
* Estensione multiutente e multi-template

---

## 10. Diagramma di Architettura (concettuale)

```
            +------------------+
            |   Web Frontend   |
            | (Flask + Jinja2) |
            +---------+--------+
                      |
                      v
           +----------+----------+
           |   Backend Flask API |
           |  Upload & Classify  |
           +----------+----------+
                      |
                      v
         +------------+------------+
         | OpenCV / AI Classifier  |
         +------------+------------+
                      |
                      v
         +------------+------------+
         |  PDF Generator (Report) |
         +------------+------------+
                      |
                      v
         +------------+------------+
         |  Storage / n8n Pipeline |
         +-------------------------+
```

---

## 11. Conclusioni

L'infrastruttura è progettata per essere **robusta, estensibile e facilmente mantenibile**, permettendo al progetto Image Presentation AI di evolversi da una soluzione locale ad un ecosistema completo di automazione clinica basato su AI.

Le prossime versioni prevedono l'integrazione diretta con API AI (Ollama, OpenAI, Hugging Face) e connettori a sistemi gestionali sanitari per una completa interoperabilità dei dati.

