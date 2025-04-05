# app.py
from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash
import MySQLdb.cursors
import re
from datetime import datetime
from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'  # 请修改为安全的密钥
# db = SQLAlchemy(app)
# MySQL配置
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'      # 修改为你的MySQL用户名
app.config['MYSQL_PASSWORD'] = 'root'  # 修改为你的MySQL密码
app.config['MYSQL_DB'] = 'linear_algebra'

mysql = MySQL(app)

# 首页
@app.route('/')
def index():
    return render_template('index.html')

# 用户注册
@app.route('/register', methods=['GET','POST'])
def register():
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
        account = cursor.fetchone()
        if account:
            flash('Account already exists!')
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            flash('Invalid email address!')
        elif not re.match(r'[A-Za-z0-9]+', username):
            flash('Username must contain only characters and numbers!')
        elif not username or not password or not email:
            flash('Please fill out the form!')
        else:
            hashed_password = generate_password_hash(password)
            cursor.execute('INSERT INTO users (username, email, password) VALUES (%s, %s, %s)', 
                           (username, email, hashed_password))
            mysql.connection.commit()
            flash('You have successfully registered!')
            return redirect(url_for('login'))
    return render_template('register.html')

# 用户登录
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
        account = cursor.fetchone()
        if account and check_password_hash(account['password'], password):
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            flash('Logged in successfully!')
            return redirect(url_for('index'))
        else:
            flash('Incorrect username/password!')
    return render_template('login.html')

# 用户登出
@app.route('/logout')
def logout():
    session.clear()
    flash('Logged out successfully!')
    return redirect(url_for('index'))

# 列出所有线性代数知识点
@app.route('/knowledge')
def knowledge():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM knowledge ORDER BY created_at DESC')
    topics = cursor.fetchall()
    return render_template('knowledge.html', topics=topics)

# 知识点详情页
@app.route('/knowledge/<int:knowledge_id>')
def knowledge_detail(knowledge_id):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM knowledge WHERE id = %s', (knowledge_id,))
    topic = cursor.fetchone()
    if not topic:
        flash('Knowledge topic not found!')
        return redirect(url_for('knowledge'))
    
    # 查询该知识点的评论（最新的在前）
    cursor.execute('''
        SELECT c.comment, c.created_at, u.username 
        FROM comments c 
        JOIN users u ON c.user_id = u.id 
        WHERE c.knowledge_id = %s 
        ORDER BY c.created_at DESC
    ''', (knowledge_id,))
    comments = cursor.fetchall()
    
    # 查询评分（点赞点踩的总和）
    cursor.execute('SELECT IFNULL(SUM(rating), 0) AS total_rating FROM ratings WHERE knowledge_id = %s', (knowledge_id,))
    rating_info = cursor.fetchone()

    return render_template('knowledge_detail.html', topic=topic, comments=comments, total_rating=rating_info['total_rating'])


# 上传新的知识点（需要登录）

@app.route('/upload', methods=['GET', 'POST'])
def upload():
    if 'loggedin' not in session:
        flash('Please log in to upload knowledge points.')
        return redirect(url_for('login'))
    if request.method == 'POST' and 'title' in request.form and 'content' in request.form:
        title = request.form['title']
        content = request.form['content']
        cursor = mysql.connection.cursor()
        # 将当前用户的 session['id'] 存入 user_id 字段
        cursor.execute('INSERT INTO knowledge (title, content, user_id, created_at) VALUES (%s, %s, %s, %s)', 
                       (title, content, session['id'], datetime.now()))
        mysql.connection.commit()
        flash('Knowledge point uploaded successfully!')
        return redirect(url_for('knowledge'))
    return render_template('upload.html')

@app.route('/notifications')
def notifications():
    if 'loggedin' not in session:
        flash("Please log in to view notifications.")
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM notifications WHERE user_id = %s ORDER BY created_at DESC", (session['id'],))
    notifs = cursor.fetchall()
    return render_template('notifications.html', notifications=notifs)

@app.route('/notification/read/<int:notification_id>')
def read_notification(notification_id):
    if 'loggedin' not in session:
        flash("Please log in.")
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("UPDATE notifications SET is_read = 1 WHERE id = %s", (notification_id,))
    mysql.connection.commit()
    return redirect(url_for('notifications'))


# 讨论区：列出主题帖（parent_id为空表示主题帖）
@app.route('/discussion')
def discussion():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('''
        SELECT p.id, p.title, p.content, p.created_at, u.username
        FROM posts p JOIN users u ON p.user_id = u.id
        WHERE p.parent_id IS NULL
        ORDER BY p.created_at DESC
    ''')
    posts = cursor.fetchall()
    return render_template('discussion.html', posts=posts)

# 创建新帖子
@app.route('/post', methods=['GET', 'POST'])
def post():
    if 'loggedin' not in session:
        flash('Please log in to post a discussion.')
        return redirect(url_for('login'))
    if request.method == 'POST' and 'title' in request.form and 'content' in request.form:
        title = request.form['title']
        content = request.form['content']
        cursor = mysql.connection.cursor()
        cursor.execute('INSERT INTO posts (user_id, title, content, created_at) VALUES (%s, %s, %s, %s)',
                       (session['id'], title, content, datetime.now()))
        mysql.connection.commit()
        flash('Post created successfully!')
        return redirect(url_for('discussion'))
    return render_template('post.html')

# 回复帖子
@app.route('/reply/<int:post_id>', methods=['GET', 'POST'])
def reply(post_id):
    if 'loggedin' not in session:
        flash('Please log in to reply.')
        return redirect(url_for('login'))
    if request.method == 'POST' and 'content' in request.form:
        content = request.form['content']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('INSERT INTO posts (user_id, content, parent_id, created_at) VALUES (%s, %s, %s, %s)',
                       (session['id'], content, post_id, datetime.now()))
        mysql.connection.commit()
        flash('Reply posted successfully!')
        # 查询原帖作者
        cursor.execute("SELECT user_id FROM posts WHERE id = %s", (post_id,))
        original_post = cursor.fetchone()
        if original_post and original_post['user_id'] != session['id']:
            notification_msg = f"{session['username']} replied to your post."
            cursor.execute("INSERT INTO notifications (user_id, message, created_at) VALUES (%s, %s, %s)",
                           (original_post['user_id'], notification_msg, datetime.now()))
            mysql.connection.commit()
        return redirect(url_for('discussion'))
    return render_template('reply.html', post_id=post_id)

# 搜索知识点功能
@app.route('/search', methods=['GET'])
def search():
    query = request.args.get('query')
    if query:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        sql = "SELECT * FROM knowledge WHERE title LIKE %s OR content LIKE %s ORDER BY created_at DESC"
        search_param = f"%{query}%"
        cursor.execute(sql, (search_param, search_param))
        results = cursor.fetchall()
        return render_template('search.html', query=query, results=results)
    else:
        flash('Please enter a search term.')
        return redirect(url_for('knowledge'))

# 用户个人中心，显示用户信息，并允许更新邮箱
@app.route('/profile', methods=['GET', 'POST'])
def profile():
    if 'loggedin' not in session:
        flash('Please log in to view your profile.')
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    if request.method == 'POST':
        new_email = request.form.get('email')
        if not new_email or not re.match(r'[^@]+@[^@]+\.[^@]+', new_email):
            flash('Invalid email address!')
        else:
            cursor.execute('UPDATE users SET email = %s WHERE id = %s', (new_email, session['id']))
            mysql.connection.commit()
            flash('Profile updated successfully!')
    cursor.execute('SELECT username, email, created_at FROM users WHERE id = %s', (session['id'],))
    user_info = cursor.fetchone()
    return render_template('profile.html', user=user_info)

@app.route('/knowledge/<int:knowledge_id>/comment', methods=['POST'])
def comment(knowledge_id):
    if 'loggedin' not in session:
        flash('Please log in to comment.')
        return redirect(url_for('login'))
    comment_text = request.form.get('comment')
    if not comment_text:
        flash('Comment cannot be empty.')
        return redirect(url_for('knowledge_detail', knowledge_id=knowledge_id))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    # 插入评论
    cursor.execute('INSERT INTO comments (knowledge_id, user_id, comment, created_at) VALUES (%s, %s, %s, %s)',
                   (knowledge_id, session['id'], comment_text, datetime.now()))
    mysql.connection.commit()
    flash('Comment posted successfully!')

    # 查询该知识点的上传者
    cursor.execute("SELECT user_id FROM knowledge WHERE id = %s", (knowledge_id,))
    owner = cursor.fetchone()
    # 如果上传者存在且不是当前评论者，则生成通知
    if owner and owner['user_id'] != session['id']:
        notification_msg = f"{session['username']} commented on your knowledge point."
        cursor.execute("INSERT INTO notifications (user_id, message, created_at) VALUES (%s, %s, %s)",
                       (owner['user_id'], notification_msg, datetime.now()))
        mysql.connection.commit()
    return redirect(url_for('knowledge_detail', knowledge_id=knowledge_id))

@app.route('/knowledge/<int:knowledge_id>/rate')
def rate(knowledge_id):
    if 'loggedin' not in session:
        flash('Please log in to rate.')
        return redirect(url_for('login'))
    try:
        rating = int(request.args.get('rating'))
    except (TypeError, ValueError):
        flash('Invalid rating value.')
        return redirect(url_for('knowledge_detail', knowledge_id=knowledge_id))
    if rating not in (1, -1):
        flash('Rating must be 1 (like) or -1 (dislike).')
        return redirect(url_for('knowledge_detail', knowledge_id=knowledge_id))
    
    cursor = mysql.connection.cursor()
    # 检查用户是否已经对该知识点评分
    cursor.execute('SELECT * FROM ratings WHERE knowledge_id = %s AND user_id = %s', (knowledge_id, session['id']))
    existing = cursor.fetchone()
    if existing:
        # 如果已评分，则更新评分
        cursor.execute('UPDATE ratings SET rating = %s, created_at = %s WHERE id = %s',
                       (rating, datetime.now(), existing[0]))
    else:
        cursor.execute('INSERT INTO ratings (knowledge_id, user_id, rating, created_at) VALUES (%s, %s, %s, %s)',
                       (knowledge_id, session['id'], rating, datetime.now()))
    mysql.connection.commit()
    flash('Thank you for your feedback!')
    return redirect(url_for('knowledge_detail', knowledge_id=knowledge_id))

@app.route('/messages')
def messages():
    if 'loggedin' not in session:
        flash('Please log in to view your messages.')
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("""
        SELECT m.*, u.username AS sender_name 
        FROM messages m JOIN users u ON m.sender_id = u.id 
        WHERE m.receiver_id = %s 
        ORDER BY m.created_at DESC
    """, (session['id'],))
    msgs = cursor.fetchall()
    return render_template('messages.html', messages=msgs)

@app.route('/message/send', methods=['GET', 'POST'])
def send_message():
    if 'loggedin' not in session:
        flash('Please log in to send messages.')
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    if request.method == 'POST':
        receiver_username = request.form.get('receiver')
        message_text = request.form.get('message')
        # 查找收信人
        cursor.execute("SELECT id FROM users WHERE username = %s", (receiver_username,))
        receiver = cursor.fetchone()
        if not receiver:
            flash("Receiver not found.")
        else:
            cursor.execute("""
                INSERT INTO messages (sender_id, receiver_id, message, created_at) 
                VALUES (%s, %s, %s, %s)
            """, (session['id'], receiver['id'], message_text, datetime.now()))
            mysql.connection.commit()
            flash("Message sent successfully!")
            # 创建通知给收信人
            notification_msg = f"You have a new message from {session['username']}."
            cursor.execute("""
                INSERT INTO notifications (user_id, message, created_at) 
                VALUES (%s, %s, %s)
            """, (receiver['id'], notification_msg, datetime.now()))
            mysql.connection.commit()
            return redirect(url_for('messages'))
    return render_template('send_message.html')

@app.route('/knowledge/<int:knowledge_id>/favorite')
def favorite(knowledge_id):
    if 'loggedin' not in session:
        flash("Please log in to add favorites.")
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM favorites WHERE user_id = %s AND knowledge_id = %s", (session['id'], knowledge_id))
    fav = cursor.fetchone()
    if fav:
        # 已收藏，则取消收藏
        cursor.execute("DELETE FROM favorites WHERE id = %s", (fav['id'],))
        flash("Removed from favorites.")
    else:
        # 添加收藏
        cursor.execute("INSERT INTO favorites (user_id, knowledge_id, created_at) VALUES (%s, %s, %s)", (session['id'], knowledge_id, datetime.now()))
        flash("Added to favorites.")
    mysql.connection.commit()
    return redirect(url_for('knowledge_detail', knowledge_id=knowledge_id))

@app.route('/favorites')
def favorites():
    if 'loggedin' not in session:
        flash("Please log in to view your favorites.")
        return redirect(url_for('login'))
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("""
        SELECT k.*, f.created_at AS favorite_time 
        FROM favorites f JOIN knowledge k ON f.knowledge_id = k.id 
        WHERE f.user_id = %s 
        ORDER BY f.created_at DESC
    """, (session['id'],))
    favs = cursor.fetchall()
    return render_template('favorites.html', favorites=favs)


if __name__ == '__main__':
    app.run(debug=True)
