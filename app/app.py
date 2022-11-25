from flask import Flask, request
from socket import gethostname, gethostbyname
from datetime import datetime
from os import getenv, environ

app = Flask(__name__)


@app.route('/')
def hello():
    host_name = gethostname()
    return {'msg': 'Hello World!',
            'host_name': host_name,
            'ip_address': gethostbyname(host_name),
            'request-timestamp': datetime.now()
            }


@app.route('/login')
def login():
    username = request.args.get('user', '')
    password = request.args.get('password', '')
    if username == getenv('USER_NAME', 'user') and password == getenv('PASSWORD', 'pass'):
        return {'status': 'SUCCESS'}, 200
    else:
        return {'status': 'UN_AUTHORIZED'}, 401


@app.route('/env')
def get_env():
    return {key: value for key, value in environ.items()}


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='8000')
