-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy
-- - Movie data includes the movie title, year released, MPAA rating,
--   and director
-- - A movie has a single director
-- - A person can be the director of and/or play a role in a movie
-- - Everything you need to do in this assignment is marked with TODO!

-- Rubric
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
--   (10 points)
-- - Insertion of "Batman" sample data into tables (5 points)
-- - Selection of data, so that something similar to the following sample
--   "report" can be achieved (5 points)

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Christopher Nolan
-- The Dark Knight        2008           PG-13  Christopher Nolan
-- The Dark Knight Rises  2012           PG-13  Christopher Nolan

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Characters;
DROP TABLE IF EXISTS Persons;

-- Create new tables, according to your domain model
-- TODO!
CREATE TABLE Movies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  Movie_Title TEXT,
  Year_Released TEXT,
  MPAA_Rating TEXT,
  Persons_id TEXT
);

CREATE TABLE Characters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  Names TEXT, 
  Movies_Id TEXT,
  Persons_Id TEXT
);

CREATE TABLE Persons (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  First_name TEXT,
  Last_name TEXT
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!
INSERT INTO Movies 
  (Movie_Title, Year_Released, MPAA_Rating, Persons_id) 
VALUES 
  ("Batman Begins", "2005", "PG-13", 1);

INSERT INTO Movies 
  (Movie_Title, Year_Released, MPAA_Rating, Persons_id) 
VALUES 
  ("The Dark Knight", "2008", "PG-13", 1);

INSERT INTO Movies 
  (Movie_Title, Year_Released, MPAA_Rating, Persons_id) 
VALUES 
  ("The Dark Knight Rises", "2012", "PG-13", 1);

INSERT INTO Characters 
  (Names, Movies_Id, Persons_id) 
VALUES 
  ("Bruce Wayne", 1, 2),
  ("Bruce Wayne", 2, 2),
  ("Bruce Wayne", 3, 2),
  ("Joker", 2, 8),  
  ("Harvey Dent", 2, 9),
  ("Alfred", 1, 3),
  ("Alfred", 2, 3),
  ("Ra's Al Ghul", 1, 4),
  ("Rachel Dawes", 1, 5),
  ("Rachel Dawes", 2, 6),
  ("Commissioner Gordon", 1, 7),
  ("Commissioner Gordon", 3, 7),
  ("Bane", 3, 10),
  ("John Blake", 3, 11),
  ("Selina Kyle", 3, 12);


INSERT INTO Persons 
  (First_name, Last_name)
VALUES 
  ("Christopher", "Nolan"),
  ("Christian", "Bale"),
  ("Michael", "Caine"),
  ("Liam", "Neeson"),
  ("Katie", "Holmes"),
  ("Maggie", "Gyllenhaal"),
  ("Gary", "Oldman"),
  ("Heath", "Ledger"),
  ("Aaron", "Eckhart"),
  ("Tom", "Hardy"),
  ("Joseph", "Gordon-Levitt"),
  ("Anne", "Hathaway");


-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
-- TODO!
SELECT Movies.Movie_Title, Movies.Year_Released, Movies.MPAA_Rating, Persons.First_name, Persons.Last_name
FROM Movies INNER JOIN Persons ON Persons.id = Movies.Persons_id;

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""

-- The SQL statement for the cast output
-- TODO!

SELECT Movies.Movie_Title, Persons.First_name, Persons.last_name, Characters.Names
FROM Characters INNER JOIN Movies ON Characters.Movies_id = Movies.id
INNER JOIN Persons ON Characters.Persons_id = Persons.id 
ORDER BY Movies.Movie_Title;
