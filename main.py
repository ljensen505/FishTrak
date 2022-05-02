"""
The main UI file for FishTrak o'Matic
Lucas Jensen
Jerrod Lepper
"""
from flask import Flask, render_template, request

app = Flask(__name__)


@app.route('/')
def home():
    """The route for the homepage"""
    return render_template('index.html', title='Homepage')


@app.route('/fishermen')
def fishermen():
    """The route for displaying all fishermen"""
    people = ['Fake Jerrod', 'Fake Lucas']
    return render_template('fishermen.html', title='All Fishermen', people=people)


@app.route('/add_fisherman', methods=['GET', 'POST'])
def add_fisherman():
    """add a fisherman to the db"""
    if request.method == 'POST':
        print(f"You added {request.form['name']} to the db! (not really)")
    return render_template('add_fisherman.html', title='Add Fisherman')


@app.route('/fishermen/<name>', methods=['GET', 'POST'])
def update_fisherman(name):
    """updates a specified fisherman"""
    return render_template('update_fisherman.html', title='Update Fisherman', name=name)



def main():
    """
    the main function for running the UI
    """
    app.run(debug=True)


if __name__ == '__main__':
    main()
