"""
Test per il modulo di classificazione
"""
import pytest
import os


def test_classify_module_exists():
    """Test che il modulo classify esista"""
    try:
        from app.utils import classify
        assert classify is not None
    except ImportError:
        pytest.skip("Modulo classify non ancora implementato")


# Aggiungi test per classify_image quando implementato
# def test_classify_image(sample_image_path):
#     """Test classificazione immagine"""
#     from app.utils.classify import classify_image
#     result = classify_image(sample_image_path)
#     assert result in ['viso', 'intraorale', 'panoramica', 'altro']
