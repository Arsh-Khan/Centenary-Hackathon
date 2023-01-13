import qrcode
import os

details = input("enter the name")
# details = "Arsh khan"
img = qrcode.make(details)
img.save("qr_name.png","PNG")
os.system("open qr_name.png")