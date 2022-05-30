SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- -----------------------------------------------------
-- Schema Fish Trak O'matic
-- -----------------------------------------------------
DROP TABLE IF EXISTS Fisherman, Caught_fish, Lure, Species, Body_of_water, Species_has_body_of_water;

-- -----------------------------------------------------
-- The Fisherman table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fisherman (
  fisherman_id INT NOT NULL AUTO_INCREMENT UNIQUE,
  name VARCHAR(45) NOT NULL)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- The Caught_fish table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Caught_fish (
  caught_fish_id INT NOT Null AUTO_INCREMENT UNIQUE,
  species_id INT NOT NULL,
  body_of_water_id INT NOT NULL,
  lure_id INT,
  fisherman_id INT,
  specific_weight INT,
  PRIMARY KEY (caught_fish_id),
  FOREIGN KEY (species_id)
    REFERENCES Species (species_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (lure_id)
    REFERENCES Lure (lure_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (fisherman_id)
    REFERENCES Fisherman (fisherman_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- The Lure table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Lure (
    lure_id INT NOT NULL AUTO_INCREMENT UNIQUE,
    weight DEC(4, 2) NOT NULL,
    name VARCHAR(45) NOT NULL,
    color VARCHAR(45) NOT NULL,
    type VARCHAR(45) NOT NULL,
    PRIMARY KEY (lure_id)
)ENGINE = InnoDB;

-- -----------------------------------------------------
-- The Species table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Species (
    species_id INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(45) NOT NULL,
    avg_weight DEC(4,2) NOT NULL,
    is_freshwater TINYINT(1) NOT NULL,
    description VARCHAR(150),
    PRIMARY KEY (species_id)
)ENGINE = InnoDB;

-- -----------------------------------------------------
-- The Body_of_water table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Body_of_water (
    body_id INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(45) NOT NULL,
    is_freshwater TINYINT(1) NOT NULL,
    is_stocked TINYINT(1) NOT NULL,
    latitude DEC(8,6) NOT NULL,
    longitude DEC(9,6) NOT NULL,
    PRIMARY KEY (body_id)
)ENGINE = InnoDB;

-- -----------------------------------------------------
-- Intersection table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Species_has_body_of_water (
    species_id INT,
    body_of_water_id INT,
    FOREIGN KEY (species_id)
        REFERENCES Species (species_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (body_of_water_id)
        REFERENCES Body_of_water (body_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)ENGINE = InnoDB;

-- -----------------------------------------------------
-- Insert into Fisherman
-- -----------------------------------------------------
INSERT INTO Fisherman (name)
VALUES ("Hank"),
       ("Dale"),
       ("Bobbeh");

-- -----------------------------------------------------
-- Insert into Lure
-- -----------------------------------------------------
INSERT INTO Lure (weight, name, color, type)
VALUES (0.75, "KVD Red Eye Shad", "Chartreuse", "Lipless Crankbait"),
       (0.25, "Senko", "Purple", "Drop Shot"),
       (1.0, "Daredevil", "Yello/red", "Spoon");

-- -----------------------------------------------------
-- Insert into Body_of_water
-- -----------------------------------------------------
INSERT INTO Body_of_water (is_freshwater, is_stocked, latitude, longitude, name)
VALUES (1, 0, 42.405457, -85.414040, "Gull Lake"),
    (1, 0, 42.378229, -85.181098, "St. Mary's Lake"),
    (1, 1, 42.349159, 85.268510, "Kzoo River");

-- -----------------------------------------------------
-- Insert into Species
-- -----------------------------------------------------
INSERT INTO Species (name, avg_weight, is_freshwater, description)
VALUES ("Largemouth Bass", 5.0, 1, "A common target for sport fishers"),
       ("Bluegill", 1, 1, "Delicious fired up!"),
       ("Channel Cat", 17, 0, "A common night time target");

-- -----------------------------------------------------
-- Insert into Caught_fish
-- -----------------------------------------------------
INSERT INTO Caught_fish (species_id, body_of_water_id, lure_id, fisherman_id, specific_weight)
VALUES
       ((SELECT species_id FROM Species WHERE name = "Largemouth Bass"),
        (SELECT body_id FROM Body_of_water WHERE name = "Gull Lake"),
        NULL,
        (SELECT fisherman_id FROM Fisherman WHERE name = "Hank"),
        5),
       ((SELECT species_id FROM Species WHERE name = "Largemouth Bass"),
        (SELECT body_id FROM Body_of_water WHERE name = "Gull Lake"),
        (SELECT lure_id FROM Lure WHERE name = "Senko"),
        (SELECT fisherman_id FROM Fisherman WHERE name = "Hank"),
        4),
       ((SELECT species_id FROM Species WHERE name = "Largemouth Bass"),
        (SELECT body_id FROM Body_of_water WHERE name = "Gull Lake"),
        (SELECT lure_id FROM Lure WHERE name = "Daredevil"),
        (SELECT fisherman_id FROM Fisherman WHERE name = "Hank"),
        NULL),
       ((SELECT species_id FROM Species WHERE name = "Bluegill"),
        (SELECT body_id FROM Body_of_water WHERE name = "Gull Lake"),
        NULL,
        (SELECT fisherman_id FROM Fisherman WHERE name = "Hank"),
        1),
       ((SELECT species_id FROM Species WHERE name = "Channel Cat"),
        (SELECT body_id FROM Body_of_water WHERE name = "St. Mary's Lake"),
        (SELECT lure_id from Lure WHERE name = "KVD Red Eye Shad"),
        (SELECT fisherman_id FROM Fisherman WHERE name = "Hank"),
        20),
        ((SELECT species_id FROM Species WHERE name = "Channel Cat"),
        (SELECT body_id FROM Body_of_water WHERE name = "St. Mary's Lake"),
        (SELECT lure_id from Lure WHERE name = "Senko"),
        (SELECT fisherman_id FROM Fisherman WHERE name = "Dale"),
        12),
       ((SELECT species_id FROM Species WHERE name = "Channel Cat"),
        (SELECT body_id FROM Body_of_water WHERE name = "St. Mary's Lake"),
        (SELECT lure_id from Lure WHERE name = "KVD Red Eye Shad"),
        (SELECT fisherman_id FROM Fisherman WHERE name = "Dale"),
        NULL),
       ((SELECT species_id FROM Species WHERE name = "Channel Cat"),
        (SELECT body_id FROM Body_of_water WHERE name = "Kzoo River"),
        (SELECT lure_id from Lure WHERE name = "Senko"),
        (SELECT fisherman_id FROM Fisherman WHERE name = "Bobbeh"),
        16);


-- -----------------------------------------------------
-- Insert into Species_has_body_of_water
-- -----------------------------------------------------
INSERT INTO Species_has_body_of_water (species_id, body_of_water_id)
VALUES (
        (SELECT species_id FROM Species WHERE name="Largemouth Bass"),
        (SELECT body_id FROM Body_of_water WHERE name="St Mary's Lake")
       ),
       (
        (SELECT species_id FROM Species WHERE name="Largemouth Bass"),
        (SELECT body_id FROM Body_of_water WHERE name="Kzoo River")
       ),
       (
        (SELECT species_id FROM Species WHERE name="Bluegill"),
        (SELECT body_id FROM Body_of_water WHERE name="St. Mary's Lake")
       ),
       (
        (SELECT species_id FROM Species WHERE name="Bluegill"),
        (SELECT body_id FROM Body_of_water WHERE name="Kzoo River")
       ),
       (
        (SELECT species_id FROM Species WHERE name="Channel Cat"),
        (SELECT body_id FROM Body_of_water WHERE name="Gull Lake")
       ),
       (
        (SELECT species_id FROM Species WHERE name="Channel Cat"),
        (SELECT body_id FROM Body_of_water WHERE name="Kazoo River")
       ),
       (
        (SELECT species_id FROM Species WHERE name="Largemouth Bass"),
        (SELECT body_id FROM Body_of_water WHERE name="Gull Lake")
       );



SET FOREIGN_KEY_CHECKS=1;
COMMIT;