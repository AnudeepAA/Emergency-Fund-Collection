from flask import Flask, render_template, request, redirect, url_for, flash
import secrets
from werkzeug.security import check_password_hash, generate_password_hash
from cs50 import SQL
import traceback
import logging

# Initialize the Flask app
app = Flask(__name__)
app.secret_key = secrets.token_hex(32)

# Set up the database
db = SQL("sqlite:///database.db")

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        message = request.form['message']
        
        # Process the form submission here
        # For example, you could save the message to the database or send an email

        flash('Your message has been sent successfully.')
        return redirect(url_for('contact'))
    
    return render_template('contact.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    error = None
    data = db.execute("SELECT * FROM users")
    check_data = {"usernames": [], "mails": [], "id_nos": []}
    for row in data:
        check_data["usernames"].append(row["username"])
        check_data["mails"].append(row["mail"])
        check_data["id_nos"].append(row["id_no"])

    if request.method == 'POST':
        username = request.form['username']
        id_no = request.form['id_no']
        email = request.form['email']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        mobile = request.form['mobile']
        designation = request.form['designation']
        confirm_password = request.form['confirm_password']

        if username in check_data["usernames"]:
            error = "Username already exists"
        elif password != confirm_password:
            error = "Passwords do not match"
        elif email in check_data["mails"]:
            error = "Email already exists"
        elif id_no in check_data["id_nos"]:
            error = "ID Number already exists"
        else:
            try:
                hashed_password = generate_password_hash(password)
                db.execute("INSERT INTO users (username, id_no, first_name, last_name, designation, mobile, mail, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                           username, id_no, first_name, last_name, designation, mobile, email, hashed_password)
                flash('You have successfully signed up!')
                return redirect(url_for('login'))
            except Exception as e:
                logging.error(traceback.format_exc())
                error = "An error occurred. Please try again."

    return render_template('signup.html', error=error)

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        user = db.execute("SELECT * FROM users WHERE username = ?", username)
        if user:
            user = user[0]
            if check_password_hash(user['password'], password):
                flash('You have successfully logged in!')
                return redirect(url_for('home'))
            else:
                error = "Invalid password"
        else:
            error = "Username not found"

    return render_template('login.html', error=error)

@app.route('/web-design')
def web_design():
    return render_template('web_design.html')

@app.route('/seo')
def seo():
    return render_template('seo.html')

@app.route('/consulting')
def consulting():
    return render_template('consulting.html')

@app.route('/forgot-password', methods=['GET', 'POST'])
def forgot_password():
    if request.method == 'POST':
        email = request.form['email']
        # Process password reset here
        flash('A password reset link has been sent to your email address.')
        return redirect(url_for('forgot_password'))
    
    return render_template('forgot_password.html')

@app.route('/privacy-policy')
def privacy_policy():
    return render_template('privacy_policy.html')

if __name__ == '__main__':
    app.run(debug=True)
