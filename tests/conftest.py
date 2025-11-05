"""
Configurazione pytest e fixtures condivise
"""
import pytest
import sys
import os

# Aggiungi la directory app al path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))


@pytest.fixture
def app():
    """Fixture Flask app per testing"""
    from app.main import app as flask_app
    
    flask_app.config.update({
        'TESTING': True,
        'UPLOAD_FOLDER': 'tests/fixtures/uploads',
        'OUTPUT_FOLDER': 'tests/fixtures/output',
    })
    
    yield flask_app


@pytest.fixture
def client(app):
    """Fixture Flask test client"""
    return app.test_client()


@pytest.fixture
def runner(app):
    """Fixture Flask CLI runner"""
    return app.test_cli_runner()


@pytest.fixture
def sample_image_path():
    """Path to sample test image"""
    return os.path.join(os.path.dirname(__file__), 'fixtures', 'sample.jpg')
