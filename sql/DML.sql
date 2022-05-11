# TODO: Jerrod take over from approx. line 107
# I may have messed this whole thing up by using actual data. I'm including the original DML file
# in this same directory as DMLoriginalFromJerrod.sql

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
UPDATE Fisherman
SET name = "Lucas" WHERE name = "Tobi";

-- -----------------------------------------------------
-- Update Lure
-- -----------------------------------------------------
UPDATE Lure
SET name = "Nightcrawler"
WHERE name = "worm" AND type = "natural";

-- -----------------------------------------------------
-- Update Body_of_water
-- -----------------------------------------------------
UPDATE Body_of_water
SET name = "Pacific"
WHERE name = "Pacific Ocean" AND latitude = 0 AND longitude = 0;

-- -----------------------------------------------------
-- Update Species
-- -----------------------------------------------------
UPDATE Species
SET name = "Ahi"
WHERE name = "Tuna" AND is_freshwater = 0;

-- -----------------------------------------------------
-- Update Caught_Fish
-- -----------------------------------------------------
UPDATE Caught_fish
SET caught_fish_id = 99
WHERE species_id = (
    SELECT species_id FROM Species WHERE name = "Ahi"
        );


# --- Delete ops
# TODO: Jerrod take over here
# TODO: We need to include functional delete and select queries.
# From Rubric: 1) DML.SQL file has SELECT, INSERT, UPDATE and DELETE queries to meet CS340 Project Guide, 2) JOINs used to make FKs user friendly 3) Variables for back-end code encapsulated by some special characters 4) All queries would run if replaced with actual data. - Excellent quality

-- -----------------------------------------------------
-- Delete Fisherman
-- -----------------------------------------------------
DELETE FROM Fisherman WHERE name=:delete_angler

-- -----------------------------------------------------
-- Delete Lure
-- -----------------------------------------------------

DELETE FROM Lure WHERE lure=:delete_lure AND lure_weight=:delete_lure_weight AND lure_color=:delete_lure_color

-- -----------------------------------------------------
-- Delete Body_of_water
-- -----------------------------------------------------

DELETE FROM Body_of_water WHERE name=:delete_body AND latitude=:delete_lat AND longitude=:delete_long
-- -----------------------------------------------------
-- Delete Species
-- -----------------------------------------------------

DELETE FROM Species WHERE name=:delete_species
-- -----------------------------------------------------
-- Delete Caught_Fish
-- -----------------------------------------------------

DELETE FROM Caught_Fish WHERE fish_id=:delete_fish_id

---Select ops

-- -----------------------------------------------------
-- Select Fisherman
-- -----------------------------------------------------

SELECT * FROM Fisherman

-- -----------------------------------------------------
-- Select Lure
-- -----------------------------------------------------

SELECT * FROM Lure
-- -----------------------------------------------------
-- Select Body_of_water
-- -----------------------------------------------------

SELECT * FROM Body_of_water
-- -----------------------------------------------------
-- Select Species
-- -----------------------------------------------------

SELECT * FROM Species
-- -----------------------------------------------------
-- Select Caught_Fish
-- -----------------------------------------------------

SELECT * FROM Caught_Fish