"""
The main UI file for FishTrak o'Matic
Lucas Jensen
Jerrod Lepper
"""
from flask import Flask, render_template, request, redirect

LUCAS = {
    'id': 1,
    'name': 'Lucas',
}
JERROD = {
    'id': 2,
    'name': 'Jerrod'
}
PEOPLE = [LUCAS, JERROD]

app = Flask(__name__)


@app.route('/')
def home():
    """The route for the homepage"""
    return render_template('index.html', title='Homepage')


@app.route('/fishermen', methods=['GET', 'POST'])
def fishermen():
    """The route for displaying all fishermen"""
    people = [LUCAS, JERROD]
    return render_template('fishermen.html', title='All Fishermen', people=people)


@app.route('/add_fisherman', methods=['GET', 'POST'])
def add_fisherman():
    """add a fisherman to the db"""
    if request.method == 'POST':
        print(f"You added {request.form['name']} to the db! (not really)")
    return render_template('add_fisherman.html', title='Add Fisherman')


@app.route('/fishermen/update:<_id>', methods=['GET', 'POST'])
def update_fisherman(_id):
    """
    updates a specified fisherman.
    This is a template and does not update anything.
    """
    people = [LUCAS, JERROD]
    target = None
    for person in people:
        if str(person['id']) == _id:
            target = person
            break

    if request.method == 'POST':
        return redirect('/fishermen')

    return render_template('update_fisherman.html', title='Update Fisherman', person=target)


@app.route('/fishermen/delete:<_id>', methods=['GET', 'POST'])
def delete_fisherman(_id):
    """
    deletes a specified fisherman.
    This is a template and does not delete anything.
    """
    people = [LUCAS, JERROD]
    target = None
    for person in people:
        if str(person['id']) == _id:
            target = person
            break

    if request.method == 'POST':
        return redirect('/fishermen')

    return render_template('delete_fisherman.html', title='Delete Fisherman', person=target)


def main():
    """
    the main function for running the UI
    """
    app.run(debug=True)


if __name__ == '__main__':
    main()
