"""
The main UI file for FishTrak o'Matic
Lucas Jensen
Jerrod Lepper
"""
from flask import Flask, render_template, request, redirect

from sample_data import FISHERMEN, LURES, BODIES_OF_WATER, SPECIES

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


# FISHERMEN
@app.route('/fishermen', methods=['GET', 'POST'])
def fishermen():
    """The route for displaying all fishermen"""
    return render_template('fishermen.html', title='Fishermen', people=FISHERMEN)


@app.route('/fishermen/add', methods=['GET', 'POST'])
def add_fisherman():
    """add a fisherman to the db"""
    if request.method == 'POST':
        print(f"You added {request.form['name']} to the db! (not really)")
        return redirect('/fishermen')
    return render_template('add_fisherman.html', title='Add Fisherman')


@app.route('/fishermen/update:<_id>', methods=['GET', 'POST'])
def update_fisherman(_id):
    """
    updates a specified fisherman.
    This is a template and does not update anything.
    """
    person = FISHERMEN[_id]

    if request.method == 'POST':
        return redirect('/fishermen')

    return render_template('update_fisherman.html', title='Update Fisherman', person=person)


@app.route('/fishermen/delete:<_id>', methods=['GET', 'POST'])
def delete_fisherman(_id):
    """
    deletes a specified fisherman.
    This is a template and does not delete anything.
    """
    person = FISHERMEN[_id]

    if request.method == 'POST':
        return redirect('/fishermen')

    return render_template('delete_fisherman.html', title='Delete Fisherman', person=person)


# LURES
@app.route('/lures', methods=['GET', 'POST'])
def lures():
    """The route for displaying all lures"""
    return render_template('lures.html', title='Lures', lures=LURES)


@app.route('/lures/update:<_id>', methods=['GET', 'POST'])
def update_lure(_id):
    """
    updates a specified lure
    This is a template and does not update anything
    """
    lure = LURES[_id]

    if request.method == 'POST':
        return redirect('/lures')

    return render_template('update_lure.html', title='Update Lure', lure=lure)


@app.route('/lures/delete:<_id>', methods=['GET', 'POST'])
def delete_lure(_id):
    """
    Deletes a specified lure
    This is a template and does not delete anything yet
    """
    lure = LURES[_id]

    if request.method == 'POST':
        return redirect('/lures')

    return render_template('delete_lure.html', title='Delete Lure', lure=lure)


@app.route('/lures/add', methods=['GET', 'POST'])
def add_lure():
    """add a lure to the db"""
    if request.method == 'POST':
        print(f"You added {request.form['name']} to the db! (not really)")
        return redirect('/lures')
    return render_template('add_lure.html', title='Add Lure')


# BODIES OF WATER
@app.route('/water_bodies', methods=['GET', 'POST'])
def water_bodies():
    """The route for displaying all lures"""
    return render_template('water_bodies.html', title='Bodies of Water', bodies = BODIES_OF_WATER)


@app.route('/water_bodies/update:<_id>', methods=['GET', 'POST'])
def update_body(_id):
    """
    updates a specified body of water
    This is a template and does not update anything
    """
    body = BODIES_OF_WATER[_id]

    if request.method == 'POST':
        return redirect('/water_bodies')

    return render_template('update_body.html', title='Update Body', body=body)


@app.route('/water_bodies/delete:<_id>', methods=['GET', 'POST'])
def delete_body(_id):
    """
    Deletes a specified body of water
    This is a template and does not delete anything yet
    """
    body = BODIES_OF_WATER[_id]

    if request.method == 'POST':
        return redirect('/water_bodies')

    return render_template('delete_body.html', title='Delete Body', body=body)


@app.route('/water_bodies/add', methods=['GET', 'POST'])
def add_body():
    """add a body of water to the db"""
    if request.method == 'POST':
        print(f"You added {request.form['name']} to the db! (not really)")
        return redirect('/water_bodies')
    return render_template('add_body.html', title='Add Body of Water')


def main():
    """
    the main function for running the UI
    """
    app.run(debug=True)


if __name__ == '__main__':
    main()
