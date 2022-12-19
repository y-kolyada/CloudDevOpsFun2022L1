from flask import Flask, render_template
import random
import os

app = Flask(__name__)

images = [
  "0.png",
  "1.png",
  "2.png",
  "3.png",
  "3.png",
  "4.png",
  "5.png",
  "6.png",
  "7.png",
  "8.png",
  "9.png"
]

@app.route("/")
def index():
  img = random.choice(images)
  img_path = os.path.join('static', img)
  return render_template("index.html", html_img=img_path)

if __name__ == "__main__":
  app.run(host="0.0.0.0", port=5000, debug=False)
