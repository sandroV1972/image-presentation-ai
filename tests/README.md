# Tests

Questa directory contiene i test automatizzati per Image Presentation AI.

## Struttura

```
tests/
├── __init__.py
├── test_main.py           # Test Flask app
├── test_classify.py       # Test classificazione
├── conftest.py           # Fixtures pytest
└── fixtures/             # File di test
    └── sample_images/
```

## Esecuzione Test

### Tutti i test
```bash
pytest tests/
```

### Test specifico
```bash
pytest tests/test_main.py
```

### Con coverage
```bash
pytest tests/ --cov=app --cov-report=html
```

### Watch mode
```bash
pytest-watch tests/
```

## Scrivere Test

Esempio test Flask:

```python
def test_index_page(client):
    """Test homepage loads correctly"""
    response = client.get('/')
    assert response.status_code == 200
    assert b'Upload' in response.data
```

Esempio test classificazione:

```python
def test_classify_image():
    """Test image classification"""
    from app.utils.classify import classify_image
    
    result = classify_image('tests/fixtures/sample.jpg')
    assert result in ['viso', 'intraorale', 'panoramica']
```

## Coverage

Target: >80% code coverage

Visualizza report:
```bash
open htmlcov/index.html
```
