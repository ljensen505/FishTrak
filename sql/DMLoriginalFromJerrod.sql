-- The INSERT ops

-- -----------------------------------------------------
-- Insert into Fisherman
-- -----------------------------------------------------
INSERT INTO Fisherman (angler)
VALUES (:name);

-- -----------------------------------------------------
-- Insert into Lure
-- -----------------------------------------------------
INSERT INTO Lure (lure_weight, lure_name, lure_color, lure_type)
VALUES (:weight,:name,:color,:type);

-- -----------------------------------------------------
-- Insert into Body_of_water
-- -----------------------------------------------------
INSERT INTO Body_of_water (is_freshwater, is_stocked, latitude, longitude, name)
VALUES (:is_freshwater, :is_stocked, :latitude, :longitude, :name);

-- -----------------------------------------------------
-- Insert into Species
-- -----------------------------------------------------
INSERT INTO Species (name, avg_weight, is_freshwater, description)
VALUES (:name, :avg_weight, :is_freshwater, :description);

-- -----------------------------------------------------
-- Insert into Caught_Fish
-- -----------------------------------------------------
INSERT INTO Caught_fish (species_id, body_of_water_id, lure_id, fisherman_id, specific_weight)
VALUES (:species_id, :body_of_water_id, :lure_id, :fisherman_id, :specific_weight)

--- The Update Ops

-- -----------------------------------------------------
-- Update Fisherman
-- -----------------------------------------------------
UPDATE Fisherman SET
new_name = :angler
WHERE name= :prev_name

-- -----------------------------------------------------
-- Update Lure
-- -----------------------------------------------------

UPDATE Lure SET
lure= :updated_lure
WHERE lure = :updated_lure AND lure_weight = :updated_lure_weight

-- -----------------------------------------------------
-- Update Body_of_water
-- -----------------------------------------------------

UPDATE Body_of_water SET
name: updated_body
WHERE name = :updated_body AND latititude = :updated_body_latitude AND longitude = :updated_body_longitude

-- -----------------------------------------------------
-- Update Species
-- -----------------------------------------------------

UPDATE Species SET
name= :updated_name
WHERE name = :updated_name AND descirption = :updated DESCRIPTION
-- -----------------------------------------------------
-- Update Caught_Fish
-- -----------------------------------------------------

UPDATE Caught_fish SET
fish_id= :updated_fish_id
WHERE fish_id = new_fish_params

---Delete ops

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