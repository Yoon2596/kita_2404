from flask import Flask, request, jsonify, render_template, redirect, url_for
from flask_migrate import Migrate
from flask_wtf.csrf import CSRFProtect
from datetime import datetime
import pytz
# from form import TaskForm
# from models import db, Task


app = Flask(__name__)

@app.route('/')
def index():
    # csrf_token = form.csrf_token._value()
    # return render_template("index.html", form=form, csrf_token=csrf_token)
    return render_template('index.html')


# app = Flask(__name__)
# app.config.from_pyfile("config.py")

# # db와 앱을 연동
# db.init_app(app)
# migrate = Migrate(app, db)
# csrf = CSRFProtect(app)

if __name__ == '__main__':
    app.run(debug=True)