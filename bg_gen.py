#!/usr/bin/env python3
"""
Generates a gray background of size 32x32 and saves it as bg.png

Requirements:
  Pillow library from pip: https://pypi.org/project/Pillow/

  pip install Pillow
"""

from PIL import Image

img = Image.new("RGB", (32, 32), color=(82, 82, 82))
img.save("bg.png")

