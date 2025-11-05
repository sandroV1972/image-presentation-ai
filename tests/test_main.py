"""
Test per il modulo principale Flask
"""
import pytest


def test_app_exists(app):
    """Test che l'app Flask esista"""
    assert app is not None


def test_app_is_testing(app):
    """Test che l'app sia in modalità testing"""
    assert app.config['TESTING'] is True


def test_index_route(client):
    """Test homepage carica correttamente"""
    response = client.get('/')
    assert response.status_code == 200


def test_upload_route_get(client):
    """Test che la route upload accetti GET"""
    response = client.get('/upload')
    # Potrebbe essere 200 o redirect a /
    assert response.status_code in [200, 302]


# Aggiungi più test qui quando implementi le funzionalità
