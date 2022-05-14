

-- The INSERT ops

-- -----------------------------------------------------
-- Insert into Fisherman
-- -----------------------------------------------------
INSERT INTO Fisherman (name)
VALUES ("Tobi"),
       ("Basil"),
       ("Carol");

-- -----------------------------------------------------
-- Insert into Lure
-- -----------------------------------------------------
INSERT INTO Lure (weight, name, color, type)
VALUES (1.0, "worm", "brown", "natural"),
       (1.2, "KVD Blue Eye Shad", "Orange", "Lipless Crankbait"),
       (0.35, "Senko 2.0", "Green", "Drop Shot");

-- -----------------------------------------------------
-- Insert into Body_of_water
-- -----------------------------------------------------
INSERT INTO Body_of_water (name, is_freshwater, is_stocked, latitude, longitude)
VALUES ("Dune Lake", 1, 1, 12.2, -15.32),
       ("Columbia River", 1, 0, 65.2, -56.245),
       ("Pacific Ocean", 0, 0, 0, 0);

-- -----------------------------------------------------
-- Insert into Species
-- -----------------------------------------------------
INSERT INTO Species (name, avg_weight, is_freshwater, description)
VALUES ("Trout", 3.2, 1, "Trout are found everywhere."),
       ("Salmon", 15.2, 1, "Seasonal. Found in rivers throughout Oregon."),
       ("Tuna", 56.0, 0, "A staple of the sea.");

-- -----------------------------------------------------
-- Insert into Species_has_body_of_water
-- -----------------------------------------------------
INSERT INTO Species_has_body_of_water (species_id, body_of_water_id)
VALUES ((SELECT species_id FROM Species WHERE name="Trout"),
        (SELECT body_id FROM Body_of_water WHERE name="Dune Lake")
       ),
        ((SELECT species_id FROM Species WHERE name="Tuna"),
        (SELECT body_id FROM Body_of_water WHERE name="Pacific Ocean")
       ),
        ((SELECT species_id FROM Species WHERE name="Salmon"),
        (SELECT body_id FROM Body_of_water WHERE name="Columbia River")
       );

-- -----------------------------------------------------
-- Insert into Caught_Fish
-- -----------------------------------------------------
INSERT INTO Caught_fish (species_id, body_of_water_id, lure_id, fisherman_id, specific_weight)
VALUES ((SELECT species_id FROM Species WHERE name = "Trout"),
        (SELECT body_id FROM Body_of_water WHERE name = "Dune Lake"),
        NULL,
        (SELECT fisherman_id FROM Fisherman WHERE name = "Tobi"),
        5),
        ((SELECT species_id FROM Species WHERE name = "Salmon"),
        (SELECT body_id FROM Body_of_water WHERE name = "Columbia River"),
        NULL,
        (SELECT fisherman_id FROM Fisherman WHERE name = "Basil"),
        5);


# --- The Update Ops

-- -----------------------------------------------------
-- Update Fisherman
-- -----------------------------------------------------
new_name = request.form.get('name')

UPDATE Fisherman SET Fisherman.name = %s WHERE fisherman_id={_id}

-- -----------------------------------------------------
-- Update Lure
-- -----------------------------------------------------
new_lure = request.form.get('name')
weight = request.form.get('weight')
color = request.form.get('color')
type = request.form.get('type')
        
UPDATE Lure SET Lure.name = %s, Lure.weight = %s, Lure.color = %s, Lure.type = %s WHERE lure_id={_id}

-- -----------------------------------------------------
-- Update Body_of_water
-- -----------------------------------------------------
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

UPDATE Body_of_water SET Body_of_water.name = %s, Body_of_water.is_freshwater = %s, \
                f"Body_of_water.is_stocked = %s, Body_of_water.latitude = %s, Body_of_water.longitude = %s  \
                f"WHERE body_id = {_id};"

-- -----------------------------------------------------
-- Update Species
-- -----------------------------------------------------
name = request.form.get('name')
        avg_weight = request.form.get('avg_weight')
        if 'is_freshwater' in request.form:
            is_freshwater = 1
        else:
            is_freshwater = 0
        description = request.form.get('description')
        
UPDATE Species SET Species.name = %s, Species.avg_weight = %s, Species.description = %s, Species.is_freshwater = %s  \
                WHERE species_id = {_id}
 -- -----------------------------------------------------
-- Update Caught_Fish
-- -----------------------------------------------------
UPDATE Caught_fish
SET caught_fish_id = 99
WHERE species_id = (
    SELECT species_id FROM Species WHERE name = "Ahi"
        );


-- Delete Ops

-- -----------------------------------------------------
-- Delete Fisherman
-- -----------------------------------------------------
DELETE FROM Fisherman WHERE id=:angler_id

-- -----------------------------------------------------
-- Delete Lure
-- -----------------------------------------------------

DELETE FROM Lure WHERE id: = lure_id

-- -----------------------------------------------------
-- Delete Body_of_water
-- -----------------------------------------------------

DELETE FROM Body_of_water WHERE id: = body_id:
-- -----------------------------------------------------
-- Delete Species
-- -----------------------------------------------------

DELETE FROM Species WHERE id=:species_id
-- -----------------------------------------------------
-- Delete Caught_Fish
-- -----------------------------------------------------

DELETE FROM Caught_Fish WHERE id=:fish_id

---Select ops

-- -----------------------------------------------------
-- Select Fisherman
-- -----------------------------------------------------

SELECT * FROM Fisherman

-- -----------------------------------------------------
-- Select Lure
-- -----------------------------------------------------
attributes = {
        'id': 'lure_id',
        'name': 'name',
        'weight': 'weight',
        'color': 'color',
        'type': 'type'
    }
    
SELECT lure_id, name, weight, color,type FROM Lure
-- -----------------------------------------------------
-- Select Body_of_water
-- -----------------------------------------------------
attributes = {
        'id': 'body_id',
        'name': 'name',
        'freshwater?': 'is_freshwater',
        'stocked?': 'is_stocked',
        'location': ('latitude', 'longitude')
    }
    
SELECT * FROM Body_of_water
-- -----------------------------------------------------
-- Select Species
-- -----------------------------------------------------

SELECT * FROM Species
-- -----------------------------------------------------
-- Select Caught_Fish
-- -----------------------------------------------------

SELECT * FROM Caught_Fish

-- -----------------------------------------------------
-- Search for a Fisherman 
-- -----------------------------------------------------

 attributes = {
        'id': 'fisherman_id',
        'name': 'name'
    }
    
param = request.form.get('search').lower()
        query = f"SELECT * FROM Fisherman"
        cur = mysql.connection.cursor()
        cur.execute(query)
        people = [person for person in cur.fetchall() if param in person['name'].lower()]
        
        
-- -----------------------------------------------------
-- Insert into the MM table Species_has_body_of_water
-- -----------------------------------------------------

INSERT INTO Species_has_body_of_water (species_id, body_of_water_id)" \
            "VALUES (%s, %s)
