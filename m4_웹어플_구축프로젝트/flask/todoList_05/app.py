from flask import Flask, request, jsonify, render_template, redirect, url_for
from flask_migrate import Migrate
from flask_wtf.csrf import CSRFProtect
from datetime import datetime
import pytz
from form import TaskForm
from models import db, Task


app = Flask(__name__)
app.config.from_pyfile("config.py")

# db와 앱을 연동
db.init_app(app)
migrate = Migrate(app, db)
csrf = CSRFProtect(app)



@app.route("/")
def index():
    form = TaskForm()
    csrf_token = form.csrf_token._value()
    return render_template("index.html", form=form, csrf_token=csrf_token)


@app.route("/tasks")
def tasks():
    tasks = Task.query.all()
    return jsonify(
        [
            {
                "id": task.id,
                "title": task.title,
                "contents": task.contents,
                "input_date": task.input_date.strftime("%Y-%m-%d"),
                "due_date": task.due_date.strftime("%Y-%m-%d"),
            }
            for task in tasks
        ]
    )


@app.route("/", methods=["POST"])
def add_task():
    form = TaskForm()
    if form.validate_on_submit():
        title = form.title.data
        contents = form.contents.data

        # 한국 시간으로 현재 날짜 설정
        kst = pytz.timezone("Asia/Seoul")
        input_date = datetime.now(kst).date()

        due_date = form.due_date.data

        new_task = Task(
            title=title, contents=contents, input_date=input_date, due_date=due_date
        )
        db.session.add(new_task)
        db.session.commit()
        return redirect(url_for("index"))
    csrf_token = form.csrf_token._value()
    return render_template("index.html", form=form, csrf_token=csrf_token)


@app.route("/edit/<int:task_id>", methods=["GET", "POST"])
def edit(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm(obj=task)
    if request.method == "POST" and form.validate_on_submit():
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data

        db.session.commit()
        return redirect(url_for("index"))
    csrf_token = form.csrf_token._value()
    return render_template(
        "edit_task.html",
        form=form,
        task_id=task.id,
        csrf_token=csrf_token,
        task_title=task.title,
        task_contents=task.contents,
        task_input_date=task.input_date.strftime("%Y-%m-%d"),
        task_due_date=task.due_date.strftime("%Y-%m-%d"),
    )


@app.route("/delete/<int:task_id>")
def delete_task(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for("index"))


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)
