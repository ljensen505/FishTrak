"""
The main UI file for FishTrak o'Matic
Lucas Jensen
Jerrod Lepper
"""
from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def home():
    """The route for the homepage"""
    return render_template('index.html', title='Homepage')


@app.route('/fishermen')
def fishermen():
    """The route for displaying all fishermen"""
    return render_template('fishermen.html', title='All Fishermen')


@app.route('/add_fisherman')
def add_fisherman():
    """add a fisherman to the db"""
    return render_template('add_fisherman.html', title='Add Fisherman')


def main():
    """
    the main function for running the UI
    """
    app.run(debug=True)


if __name__ == '__main__':
    main()
