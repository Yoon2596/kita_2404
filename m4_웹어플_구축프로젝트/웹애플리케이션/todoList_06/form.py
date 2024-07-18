from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, TextAreaField, DateField, SubmitField
from wtforms.validators import DataRequired, Length

# class TaskForm(FlaskForm):
#     title = StringField("제목", validators=[DataRequired(), Length(max=100)])
#     contents = TextAreaField("내용", validators=[DataRequired()])
#     # due_date = DateField("마감일", format="%Y-%m-%d", validators=[DataRequired()])
#     due_date = DateField("마감일", validators=[DataRequired()])
#     submit = SubmitField('Add Task')

# class LoginForm(FlaskForm):
#     username = StringField('Username', validators=[DataRequired()])
#     password = PasswordField('Password', validators=[DataRequired()])
#     submit = SubmitField('Login')

# class RegistrationForm(FlaskForm):
#     username = StringField('Username', validators=[DataRequired(), Length(min=4, max=24)])
#     password = PasswordField('Password', validators=[DataRequired(), Length(min=6)])
#     is_admin = BooleanField('Is Admin')
#     submit = SubmitField('Register')

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, TextAreaField, DateField
from wtforms.validators import DataRequired


class TaskForm(FlaskForm):
    title = StringField("Title", validators=[DataRequired()])
    contents = TextAreaField("Contents", validators=[DataRequired()])
    due_date = DateField("Due Date", validators=[DataRequired()])


class LoginForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])


class RegistrationForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])