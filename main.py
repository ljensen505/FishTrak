"""
The main UI file for FishTrak o'Matic
Lucas Jensen
Jerrod Lepper
"""
import os
from flask import Flask, render_template, request, redirect
from sample_data import FISHERMEN, LURES, BODIES_OF_WATER, SPECIES, CAUGHT_FISH
from flask_mysqldb import MySQL
from dotenv import load_dotenv


# Comment the following line out when deploying to Heroku
load_dotenv()

HOST = os.getenv("HOST")
USERNAME = os.getenv("U_NAME")
PASSWORD = os.getenv("PASSWORD")
DB = os.getenv("DB")


app = Flask(__name__)

# database connection info
app.config["MYSQL_HOST"] = HOST
app.config["MYSQL_USER"] = USERNAME
app.config["MYSQL_PASSWORD"] = PASSWORD
app.config["MYSQL_DB"] = DB
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)


@app.route('/')
def home():
    """The route for the homepage"""
    return render_template('index.html', title='Homepage')


# FISHERMEN
@app.route('/fishermen', methods=['GET', 'POST'])
def fishermen():
    """The route for displaying all fishermen"""
    query = "SELECT * FROM Fisherman"
    cur = mysql.connection.cursor()
    cur.execute(query)
    people = cur.fetchall()

    if request.method == 'POST':
        # query to find the name
        name = request.form.get('search').lower()
        query = f"SELECT * FROM Fisherman"
        cur = mysql.connection.cursor()
        cur.execute(query)
        people = [person for person in cur.fetchall() if name in person['name'].lower()]
        return render_template('fishermen.html', title='Results', people=people, searching=True)

    return render_template('fishermen.html', title='Fishermen', people=people, searching=False)


@app.route('/fishermen/add', methods=['GET', 'POST'])
def add_fisherman():
    """add a fisherman to the db"""
    if request.method == 'POST':
        new_name = request.form.get('name')
        # query to add fisherman
        query = f"INSERT INTO Fisherman (name) VALUES (%s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (new_name,))
        mysql.connection.commit()

        return redirect('/fishermen')

    return render_template('add_fisherman.html', title='Add Fisherman')


@app.route('/fishermen/update:<_id>', methods=['GET', 'POST'])
def update_fisherman(_id):
    """
    updates a specified fisherman.
    This is a template and does not update anything.
    """
    # query for original fisherman attributes
    query = f"SELECT fisherman_id, name FROM Fisherman WHERE fisherman_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)
    person = cur.fetchall()[0]

    if request.method == 'POST':
        new_name = request.form.get('name')

        # update query
        query = f"UPDATE Fisherman SET Fisherman.name = %s WHERE fisherman_id={_id}"
        cur = mysql.connection.cursor()
        cur.execute(query, (new_name,))
        mysql.connection.commit()

        # redirect to all fishermen
        return redirect('/fishermen')

    return render_template('update_fisherman.html', title='Update Fisherman', person=person)


@app.route('/fishermen/delete:<_id>', methods=['GET', 'POST'])
def delete_fisherman(_id):
    """
    deletes a specified fisherman.
    """
    # query for fisherman using ID
    query = f"SELECT name FROM Fisherman WHERE fisherman_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)
    # If the angler no longer exists, redirect (probably a better way to refresh the anglers than this)
    try:
        person = cur.fetchall()[0]
    except IndexError:
        return redirect('/fishermen')
    name = person['name']

    # query to delete fisherman
    query = "DELETE FROM Fisherman WHERE fisherman_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (_id,))
    mysql.connection.commit()

    return render_template('delete_fisherman.html', title='Delete Fisherman', name=name)


# LURES
@app.route('/lures')
def lures():
    """
    Display dem lures
    """
    if request.method == "GET":
        query = "SELECT lure_id, name, weight, color,type FROM Lure"
        cur = mysql.connection.cursor()
        cur.execute(query)
        lures = cur.fetchall()

        return render_template('lures.html', title='Lures', lures=lures)


@app.route('/lures/update:<_id>', methods=['GET', 'POST'])
def update_lure(_id):
    """
    updates a specified lure
    """
    query = f"SELECT lure_id FROM Lure WHERE lure_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)
    lure = cur.fetchall()

    if request.method == 'POST':
        new_lure = request.form.get('name')
        weight = request.form.get('weight')
        color = request.form.get('color')
        type = request.form.get('type')

        # update that lure
        query = f"UPDATE Lure SET Lure.name = %s, Lure.weight = %s, Lure.color = %s, Lure.type = %s WHERE lure_id={_id}"
        cur = mysql.connection.cursor()
        cur.execute(query, (new_lure,weight,color,type))
        mysql.connection.commit()
        return redirect('/lures')

    return render_template('update_lure.html', title='Update Lure', lure=lure)


@app.route('/lures/delete:<_id>', methods=['GET', 'POST'])
def delete_lure(_id):
    """
    Deletes a specified lure
    """
    query = f"SELECT name FROM Lure WHERE lure_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)
    try:
        lure = cur.fetchall()
    except IndexError:
        return redirect('/lures')

    query = "DELETE FROM Lure WHERE lure_id = %s"
    cur = mysql.connection.cursor()
    cur.execute(query, (_id,))
    mysql.connection.commit()

    return render_template('delete_lure.html', title='Delete Lure', lure=lure)


@app.route('/lures/add', methods=['GET', 'POST'])
def add_lure():
    """add a lure to the db"""

    if request.method == 'POST':
        # This is ugly and I don't like it
        name = request.form.get('name')
        weight = request.form.get('weight')
        color = request.form.get('color')
        type = request.form.get('type')
        # query to add a lure
        query = f"INSERT INTO Lure (weight,name,color,type) VALUES (%s,%s,%s,%s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (weight,name,color,type))
        mysql.connection.commit()
        print(f"You added {request.form['name']} to the db! (For real)")
        return redirect('/lures')

    return render_template('add_lure.html', title='Add Lure')


# BODIES OF WATER
@app.route('/water_bodies')
def water_bodies():
    """The route for displaying all bodies of water"""
    query = "SELECT * FROM Body_of_water"
    cur = mysql.connection.cursor()
    cur.execute(query)
    bodies = cur.fetchall()

    return render_template('water_bodies.html', title='Bodies of Water', bodies=bodies, bool=bool)


@app.route('/water_bodies/update:<_id>', methods=['GET', 'POST'])
def update_body(_id):
    """
    updates a specified body of water
    """
    # query for body of water using ID
    query = f"SELECT * FROM Body_of_water WHERE body_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)
    body = cur.fetchall()[0]

    if request.method == 'POST':
        name = request.form.get('name')
        if request.form.get('is_freshwater') == 'on':
            is_freshwater = 1
        else:
            is_freshwater = 0
        if request.form.get('is_stocked') == 'on':
            is_stocked = 1
        else:
            is_stocked = 0
        latitude = request.form.get('latitude')
        longitude = request.form.get('longitude')

        # update query
        query = f"UPDATE Body_of_water SET Body_of_water.name = %s, Body_of_water.is_freshwater = %s, " \
                f"Body_of_water.is_stocked = %s, Body_of_water.latitude = %s, Body_of_water.longitude = %s " \
                f"WHERE body_id = {_id};"
        cur = mysql.connection.cursor()
        cur.execute(query, (name, is_freshwater, is_stocked, latitude, longitude))
        mysql.connection.commit()

        # redirect to all water bodies
        return redirect('/water_bodies')

    return render_template('update_body.html', title='Update Body', body=body)


@app.route('/water_bodies/delete:<_id>', methods=['GET', 'POST'])
def delete_body(_id):
    """
    Deletes a specified body of water
    """
    # query for original body of water attributes
    query = f"SELECT * FROM Body_of_water WHERE body_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)

    # if the body of water no longer exists, redirect
    try:
        body = cur.fetchall()[0]
    except IndexError:
        return redirect('/water_bodies')

    name = body['name']

    # query to delete body of water
    query = "DELETE FROM Body_of_water WHERE body_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (_id,))
    mysql.connection.commit()

    return render_template('delete_body.html', title='Delete Body', body=body)


@app.route('/water_bodies/add', methods=['GET', 'POST'])
def add_body():
    """add a body of water to the db"""
    if request.method == 'POST':
        # gather data from the form
        name = request.form.get('name')
        if 'is_freshwater' in request.form:
            is_freshwater = 1
        else:
            is_freshwater = 0
        if 'is_stocked' in request.form:
            is_stocked = 1
        else:
            is_stocked = 0
        latitude = request.form.get('latitude')
        longitude = request.form.get('longitude')

        # query to get insert new body of water
        query = f"INSERT INTO Body_of_water (name, is_freshwater, is_stocked, latitude, longitude) " \
                f"VALUES (%s, %s, %s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (name, is_freshwater, is_stocked, latitude, longitude))
        mysql.connection.commit()

        return redirect('/water_bodies')
    return render_template('add_body.html', title='Add Body of Water')


# SPECIES
@app.route('/species')
def species():
    """The route for displaying all fish species"""
    query = "SELECT * FROM Species"
    cur = mysql.connection.cursor()
    cur.execute(query)
    species = cur.fetchall()

    return render_template('species.html', title='Species', species=species)


@app.route('/species/update:<_id>', methods=['GET', 'POST'])
def update_species(_id):
    """
    updates a specified fish species
    This is a template and does not update anything
    """
    fish = SPECIES[_id]

    if request.method == 'POST':
        return redirect('/species')

    return render_template('update_species.html', title='Update Species', fish=fish)


@app.route('/species/delete:<_id>', methods=['GET', 'POST'])
def delete_species(_id):
    """
    Deletes a specified fish species
    This is a template and does not delete anything yet
    """
    # query for original species attributes
    query = f"SELECT * FROM Species WHERE species_id={_id}"
    cur = mysql.connection.cursor()
    cur.execute(query)

    # if the species no longer exists, redirect
    try:
        fish = cur.fetchall()[0]
    except IndexError:
        return redirect('/water_bodies')

    name = fish['name']

    # query to delete a species
    query = "DELETE FROM Species WHERE species_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (_id,))
    mysql.connection.commit()

    return render_template('delete_species.html', title='Delete Species', fish=fish)


@app.route('/species/add', methods=['GET', 'POST'])
def add_species():
    """add a species to the db"""
    if request.method == 'POST':
        # gather data from the form
        name = request.form.get('name')
        avg_weight = request.form.get('avg_weight')
        if 'is_freshwater' in request.form:
            is_freshwater = 1
        else:
            is_freshwater = 0
        description = request.form.get('description')

        # query to insert into Species
        query = f"INSERT INTO Species (name, avg_weight, is_freshwater, description) " \
                f"VALUES (%s, %s, %s, %s);"
        cur = mysql.connection.cursor()
        cur.execute(query, (name, avg_weight, is_freshwater, description))
        mysql.connection.commit()

        return redirect('/species')

    return render_template('add_species.html', title='Add Species')


# CAUGHT_FISH
@app.route('/caught_fish')
def caught_fish():
    """The route for displaying all caught fish"""
    print(SPECIES[str(CAUGHT_FISH['1']['species_id'])]['name'])
    # print(SPECIES[CAUGHT_FISH['1']['species_id']])
    return render_template('caught_fish.html', title='Caught Fish', fishes=CAUGHT_FISH, species=SPECIES,
                           bodies=BODIES_OF_WATER, lures=LURES, fishermen=FISHERMEN, str=str)


@app.route('/caught_fish/add', methods=['GET', 'POST'])
def add_fish():
    """adds a caught fish to the db"""
    if request.method == 'POST':
        print(f"You added a fish to the db! (not really)")
        return redirect('/caught_fish')
    return render_template('add_fish.html', title='Add Fish', species=SPECIES, bodies=BODIES_OF_WATER, lures=LURES,
                           fishermen=FISHERMEN)


@app.route('/caught_fish/update:<_id>', methods=['GET', 'POST'])
def update_fish(_id):
    """
    updates a specified caught fish
    This is a template and does not update anything
    """
    # TODO: this html file for this route needs some additional logic to handle default values for lure and caught_by
    fish = CAUGHT_FISH[_id]

    if request.method == 'POST':
        return redirect('/caught_fish')

    return render_template('/update_fish.html', title='Update Fish', species=SPECIES, bodies=BODIES_OF_WATER,
                           lures=LURES, fishermen=FISHERMEN, curr_fish=fish, str=str)


@app.route('/caught_fish/delete:<_id>', methods=['GET', 'POST'])
def delete_fish(_id):
    """
    Deletes a specified caught_fish
    This is a template and does not delete anything yet
    """
    fish = CAUGHT_FISH[_id]

    if request.method == 'POST':
        return redirect('/caught_fish')

    return render_template('delete_fish.html', title='Delete Fish', fish=fish, species=SPECIES, str=str)


if __name__ == "__main__":
    app.run(debug=True)
