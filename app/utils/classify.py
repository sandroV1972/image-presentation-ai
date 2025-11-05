import cv2
import numpy as np

def classify_image(image_path):
    '''Esempio semplificato: classifica in base alla luminosità media'''
    img = cv2.imread(image_path)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    mean_intensity = np.mean(gray)
    if mean_intensity > 127:
        return "viso"
    else:
        return "intraorale"
