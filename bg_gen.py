#!/usr/bin/env python3

from PIL import Image

img = Image.new("RGB", (32, 32), color=(82, 82, 82))
img.save("bg.png")

