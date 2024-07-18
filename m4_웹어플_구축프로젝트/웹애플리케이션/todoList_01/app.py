# 라이브서버 안쓰고 플라스크 서버에서 가동
from flask import Flask, render_template, redirect, url_for, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

app = Flask(__name__)
# 이건 나중에 config.py로 따로 빼서 관리하는게 좋음
#app.config.from_pyfile('config.py')
app.config['SECRET_KEY'] =  'b1910a39bb7ffb5c07ee96823aed828fe8656b4dcc460115'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///example.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Task는 테이블명(오라클처럼+)
class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)

class TaskForm(FlaskForm):
    # index.html에서 쓴 것을 똑같이 쓴다
    title = StringField('Title', validators=[DataRequired()])
    submit = SubmitField('Add Task')

# 빈칸과 안에 문자를 쓰고 db에 저장하는 것 생성
@app.route('/', methods=['GET', 'POST'])
def index():
    form = TaskForm()
    if form.validate_on_submit():
        new_task = Task(title=form.title.data)
        db.session.add(new_task)
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('index.html', form=form)

# json 타입으로 zip열로 만듬
@app.route('/tasks')
def tasks():
    tasks = Task.query.all()
    return jsonify([{'id' : task.id, 'title' : task.title} for task in tasks])

@app.route("/edit/<int:task_id>", methods=['GET', 'POST'])
def edit(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm()
    if form.validate_on_submit():
        task.title = form.title.data
        db.session.commit()
        return redirect(url_for('index'))
    form.title.data = task.title
    return render_template('edit_task.html', form=form, task_id = task_id, task_title=task.title)

@app.route("/delete/<int:task_id>")
def delete(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for('index'))


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)

