import flask

app = flask.Flask(__name__)

testhgj
@app.route('/')
def homepage() -> str:
    return flask.render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug='true')
