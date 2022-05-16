# FishTrak o'Matic
FishTrack o'Matic is currently underdevelopment. It is being built by Jerrod Lepper and Lucas Jensen.
To start the app, just run main.py and go to http://127.0.0.1:5000


TODO:

Implement Client side for an actual user:

-- Arrange tables to reflect what one user would see (just there fish and attributes)

-- A profile page, detailing pertinent information (might inlcude pciture, location, fish count, species count)
-- Maybe fish count could be represented with rendering n fish [icons in a row](https://en.wikipedia.org/wiki/Victory_marking), where n is how many fish the fisherman has caught?

-- Oauth and login servicing 

Implement map functionality

-- Add some kind of map API to support an embedded map. Could detail where certain species have been caught, where lakes are, ETC

Add constaints to add routes

-- Create bounds for weights and other int types to limit the amounts that can be input by a user (Limit to fish weight, no negative weights for example)

-- Create types for int inputs like weight for a fish (Ounce, lb, etc)

-- ~~Eliminate redundant data entry (can add the same species twice)~~
-- Add show an error message to user when trying to add redundant data. Need flash or modal (or similar)

-- Add statisitcial calculations where needed (for example, calculate average weight of a species using all caught fish of that species)

-- Use DECRIBE query's to dynamically update the database 

-- Add citations, mainly the cs340 provided flask instructions and sample BSG app

-- Add clarity to lure type selection

-- refactor update pages to use same template, if possible

-- consolidate Update render parameters

~~-- fix navbar highlighting for update~~

-- ~~install bootstrap 5 icons: https://icons.getbootstrap.com/#install~~