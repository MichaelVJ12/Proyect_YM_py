import os
from flask import Flask, url_for, render_template

ym_site = Flask(__name__)

ym_site.secret_key="chocolate"

@ym_site.route('/')
@ym_site.route('/index')
@ym_site.route('/main')
def start():
	return render_template('Sites/index.html')

@ym_site.route('/tienda')
def tienda():
	return render_template('Sites/store.html')

if __name__=='__main__':
	ym_site.run(host="127.0.0.1", port = 5000, debug=True)