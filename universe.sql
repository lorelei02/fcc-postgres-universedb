camper: /project$ psql --username=freecodecamp --dbname=postgres
Border style is 2.
Pager usage is off.
psql (12.17 (Ubuntu 12.17-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

postgres=> \c universe
connection to server at "127.0.0.1", port 5432 failed: FATAL:  database "universe" does not exist
Previous connection kept
postgres=> \c universe;
connection to server at "127.0.0.1", port 5432 failed: FATAL:  database "universe" does not exist
Previous connection kept
postgres=> CREATE DATABASE universe;
CREATE DATABASE
postgres=> \c universe
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
You are now connected to database "universe" as user "freecodecamp".
universe=> CREATE TABLE galaxy (galaxy_id SERIAL PRIMARY KEY NOT NULL, speed INT, description TEXT);
CREATE TABLE
universe=> CREATE TABLE star(star_id PRIMARY KEY SERIAL NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, CONSTRAINT fk_galaxy FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id));
ERROR:  syntax error at or near "PRIMARY"
LINE 1: CREATE TABLE star(star_id PRIMARY KEY SERIAL NOT NULL, radiu...
                                  ^
universe=> CREATE TABLE star(star_id SERIAL PRIMARY KEY  NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, CONSTRAINT fk_galaxy
FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id));
ERROR:  column "galaxy_id" referenced in foreign key constraint does not exist
universe=> CREATE TABLE star(star_id SERIAL PRIMARY KEY  NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, galaxy_id INT CONSTRA
INT fk_galaxy FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id));
ERROR:  syntax error at or near "FOREIGN"
LINE 1: ...255) NOT NULL, galaxy_id INT CONSTRAINT fk_galaxy FOREIGN KE...
                                                             ^
universe=> CREATE TABLE star(star_id SERIAL PRIMARY KEY  NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, galaxy_id INT CONSTRAINT, fk_galaxy FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id));
ERROR:  syntax error at or near ","
LINE 1: ...me VARCHAR(255) NOT NULL, galaxy_id INT CONSTRAINT, fk_galax...
                                                             ^
universe=> CREATE TABLE star(star_id SERIAL PRIMARY KEY  NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, galaxy_id INT CONSTR
ERROR:  syntax error at or near "CONSTR"CES galaxy(galaxy_id));
LINE 1: ...T NULL, name VARCHAR(255) NOT NULL, galaxy_id INT CONSTR fk_...
                                                             ^
universe=> CREATE TABLE star(star_id SERIAL PRIMARY KEY  NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, galaxy_id INT, CONSTRAINT fk_galaxy FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id));
CREATE TABLE
universe=> \d galaxy
                                   Table "public.galaxy"
+-------------+---------+-----------+----------+-------------------------------------------+
|   Column    |  Type   | Collation | Nullable |                  Default                  |
+-------------+---------+-----------+----------+-------------------------------------------+
| galaxy_id   | integer |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| speed       | integer |           |          |                                           |
| description | text    |           |          |                                           |
+-------------+---------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
Referenced by:
    TABLE "star" CONSTRAINT "fk_galaxy" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> \d star
                                         Table "public.star"
+-----------+------------------------+-----------+----------+---------------------------------------+
|  Column   |          Type          | Collation | Nullable |                Default                |
+-----------+------------------------+-----------+----------+---------------------------------------+
| star_id   | integer                |           | not null | nextval('star_star_id_seq'::regclass) |
| radius    | integer                |           | not null |                                       |
| color     | character varying(255) |           | not null |                                       |
| name      | character varying(255) |           | not null |                                       |
| galaxy_id | integer                |           |          |                                       |
+-----------+------------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
Foreign-key constraints:
    "fk_galaxy" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> ALTER TABLE galaxy ADD COLUMN name VARCHAR(255) NOT NULL;
ALTER TABLE
universe=> \d galaxy
                                           Table "public.galaxy"
+-------------+------------------------+-----------+----------+-------------------------------------------+
|   Column    |          Type          | Collation | Nullable |                  Default                  |
+-------------+------------------------+-----------+----------+-------------------------------------------+
| galaxy_id   | integer                |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| speed       | integer                |           |          |                                           |
| description | text                   |           |          |                                           |
| name        | character varying(255) |           | not null |                                           |
+-------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
Referenced by:
    TABLE "star" CONSTRAINT "fk_galaxy" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> CREATE TABLE planet(planet_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, amount_of_people NUMERIC, time_travel boolean DEFAULT(0) NOT NULL, star_id INT NOT NULL, CONSTRAINT fk_star FOREIGN KEY(star_id) REFERENCES star(star_id));
ERROR:  column "time_travel" is of type boolean but default expression is of type integer
HINT:  You will need to rewrite or cast the expression.
universe=> CREATE TABLE planet(planet_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, amount_of_people NUMERIC, time_travel boolean DEFAULT(false) NOT NULL, st
ar_id INT NOT NULL, CONSTRAINT fk_star FOREIGN KEY(star_id) REFERENCES star(star_id));
CREATE TABLE
universe=> \d planet
                                             Table "public.planet"
+------------------+------------------------+-----------+----------+-------------------------------------------+
|      Column      |          Type          | Collation | Nullable |                  Default                  |
+------------------+------------------------+-----------+----------+-------------------------------------------+
| planet_id        | integer                |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name             | character varying(255) |           | not null |                                           |
| amount_of_people | numeric                |           |          |                                           |
| time_travel      | boolean                |           | not null | false                                     |
| star_id          | integer                |           | not null |                                           |
+------------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
Foreign-key constraints:
    "fk_star" FOREIGN KEY (star_id) REFERENCES star(star_id)

universe=> CREATE TABLE moon(moon_id SERIAL PRIMARY NOT NULL, name VARCHAR(255) NOT NULL, name_code VARCHAR(255) UNIQUE, has_water boolean NOT NULL, planet_id INT NOT NULL, CONSTRAINT fk_planet FOREIGN KEY(planet_id) REFERENCES planet(planet_id));
ERROR:  syntax error at or near "NOT"
LINE 1: CREATE TABLE moon(moon_id SERIAL PRIMARY NOT NULL, name VARC...
                                                 ^
universe=> CREATE TABLE moon(moon_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, name_code VARCHAR(255) UNIQUE, has_water boolean NOT NULL, planet_id INT NOT
NULL,
CREATE TABLE
universe=> \d moon
                                         Table "public.moon"
+-----------+------------------------+-----------+----------+---------------------------------------+
|  Column   |          Type          | Collation | Nullable |                Default                |
+-----------+------------------------+-----------+----------+---------------------------------------+
| moon_id   | integer                |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name      | character varying(255) |           | not null |                                       |
| name_code | character varying(255) |           |          |                                       |
| has_water | boolean                |           | not null |                                       |
| planet_id | integer                |           | not null |                                       |
+-----------+------------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_code_key" UNIQUE CONSTRAINT, btree (name_code)
Foreign-key constraints:
    "fk_planet" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> ALTER TABLE moon DROP COLUMN name_code;
ALTER TABLE
universe=> ALTER TABLE moon ADD COLUMN name_code VARCHAR(255) UNIQUE NOT NULL;
ALTER TABLE
universe=> \d moon
                                         Table "public.moon"
+-----------+------------------------+-----------+----------+---------------------------------------+
|  Column   |          Type          | Collation | Nullable |                Default                |
+-----------+------------------------+-----------+----------+---------------------------------------+
| moon_id   | integer                |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name      | character varying(255) |           | not null |                                       |
| has_water | boolean                |           | not null |                                       |
| planet_id | integer                |           | not null |                                       |
| name_code | character varying(255) |           | not null |                                       |
+-----------+------------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_code_key" UNIQUE CONSTRAINT, btree (name_code)
Foreign-key constraints:
    "fk_planet" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> CREATE TABLE blackhole(blackhole_id SERIAL PRIMARY KEY NOT NULL, gravity INT, galaxy_id INT, wormhole BOOLEAN DEFAULT(false) NOT NULL);
CREATE TABLE
universe=> \d 
                        List of relations
+--------+----------------------------+----------+--------------+
| Schema |            Name            |   Type   |    Owner     |
+--------+----------------------------+----------+--------------+
| public | blackhole                  | table    | freecodecamp |
| public | blackhole_blackhole_id_seq | sequence | freecodecamp |
| public | galaxy                     | table    | freecodecamp |
| public | galaxy_galaxy_id_seq       | sequence | freecodecamp |
| public | moon                       | table    | freecodecamp |
| public | moon_moon_id_seq           | sequence | freecodecamp |
| public | planet                     | table    | freecodecamp |
| public | planet_planet_id_seq       | sequence | freecodecamp |
| public | star                       | table    | freecodecamp |
| public | star_star_id_seq           | sequence | freecodecamp |
+--------+----------------------------+----------+--------------+
(10 rows)

universe=> \d galaxy
                                           Table "public.galaxy"
+-------------+------------------------+-----------+----------+-------------------------------------------+
|   Column    |          Type          | Collation | Nullable |                  Default                  |
+-------------+------------------------+-----------+----------+-------------------------------------------+
| galaxy_id   | integer                |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| speed       | integer                |           |          |                                           |
| description | text                   |           |          |                                           |
| name        | character varying(255) |           | not null |                                           |
+-------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
Referenced by:
    TABLE "star" CONSTRAINT "fk_galaxy" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> INSERT INTO galaxy(name) VALUES ('zooby');
INSERT 0 1
universe=> SELECT * FROM galaxyl
universe-> SELECT * FROM galaxy;
ERROR:  syntax error at or near "SELECT"
LINE 2: SELECT * FROM galaxy;
        ^
universe=> SELECT * FROM galaxy;
+-----------+-------+-------------+-------+
| galaxy_id | speed | description | name  |
+-----------+-------+-------------+-------+
|         1 |       |             | zooby |
+-----------+-------+-------------+-------+
(1 row)

universe=> INSERT INTO galaxy(name) VALUES ('louis');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES ('armour');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES ('zoe');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES ('mcgonigle');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES ('suuai');
INSERT 0 1
universe=> SELECT * FROM galaxy;
+-----------+-------+-------------+-----------+
| galaxy_id | speed | description |   name    |
+-----------+-------+-------------+-----------+
|         1 |       |             | zooby     |
|         2 |       |             | louis     |
|         3 |       |             | armour    |
|         4 |       |             | zoe       |
|         5 |       |             | mcgonigle |
|         6 |       |             | suuai     |
+-----------+-------+-------------+-----------+
(6 rows)

universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(123453123, 'red', 'beatlejuice', 1);
INSERT 0 1
universe=> SELECT * FROM star
universe-> SELECT * FROM star;
ERROR:  syntax error at or near "SELECT"
LINE 2: SELECT * FROM star;
        ^
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(123453123, 'red', 'millan', 1);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(123453123, 'red', 'bell', 1);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(123453123, 'red', 'laaw', 1);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(123453123, 'orange', 'lissa', 1);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(123453123, 'yellow', 'dobson', 1);
INSERT 0 1
universe=> SELECT * FROM star;
+---------+-----------+--------+-------------+-----------+
| star_id |  radius   | color  |    name     | galaxy_id |
+---------+-----------+--------+-------------+-----------+
|       1 | 123453123 | red    | beatlejuice |         1 |
|       2 | 123453123 | red    | millan      |         1 |
|       3 | 123453123 | red    | bell        |         1 |
|       4 | 123453123 | red    | laaw        |         1 |
|       5 | 123453123 | orange | lissa       |         1 |
|       6 | 123453123 | yellow | dobson      |         1 |
+---------+-----------+--------+-------------+-----------+
(6 rows)

universe=> \d planet
                                             Table "public.planet"
+------------------+------------------------+-----------+----------+-------------------------------------------+
|      Column      |          Type          | Collation | Nullable |                  Default                  |
+------------------+------------------------+-----------+----------+-------------------------------------------+
| planet_id        | integer                |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name             | character varying(255) |           | not null |                                           |
| amount_of_people | numeric                |           |          |                                           |
| time_travel      | boolean                |           | not null | false                                     |
| star_id          | integer                |           | not null |                                           |
+------------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
Foreign-key constraints:
    "fk_star" FOREIGN KEY (star_id) REFERENCES star(star_id)
Referenced by:
    TABLE "moon" CONSTRAINT "fk_planet" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> INSERT INTO planet(name, star_id) VALUES('earth' 1);
ERROR:  syntax error at or near "1"
LINE 1: INSERT INTO planet(name, star_id) VALUES('earth' 1);
                                                         ^
universe=> INSERT INTO planet(name, star_id) VALUES('earth', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('neptune', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('mars', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('uranus', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('venus', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('saturn', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('pluto', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('jupitar', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('waflle', 2);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('tracer', 2);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('winston', 3);
INSERT 0 1
universe=> SELECT * FROM planet
universe-> SELECT * FROM planet;
ERROR:  syntax error at or near "SELECT"
LINE 2: SELECT * FROM planet;
        ^
universe=> 
SELECT * FROM planet;
universe=> 
universe=> SELECT * FROM planet;
+-----------+---------+------------------+-------------+---------+
| planet_id |  name   | amount_of_people | time_travel | star_id |
+-----------+---------+------------------+-------------+---------+
|         1 | earth   |                  | f           |       1 |
|         2 | neptune |                  | f           |       1 |
|         3 | mars    |                  | f           |       1 |
|         4 | uranus  |                  | f           |       1 |
|         5 | venus   |                  | f           |       1 |
|         6 | saturn  |                  | f           |       1 |
|         7 | pluto   |                  | f           |       1 |
|         8 | jupitar |                  | f           |       1 |
|         9 | waflle  |                  | f           |       2 |
|        10 | tracer  |                  | f           |       2 |
|        11 | winston |                  | f           |       3 |
+-----------+---------+------------------+-------------+---------+
(11 rows)

universe=> INSERT INTO planet(name, star_id) VALUES('roadhog', 3);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('reinhardt', 3);
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES(
universe(> 
universe(> INSERT INTO planet(name, star_id) VALUES('reinhardt', 3);
universe(> INSERT INTO planet(name, star_id) VALUES('reinhardt', 3);
universe(> SELECT * FROM planet;
universe(> clear
universe(> --help
universe(> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon1', true, 2, 'moon1');
universe(> );
ERROR:  syntax error at or near "INTO"
LINE 2: INSERT INTO planet(name, star_id) VALUES('reinhardt', 3);
               ^
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon1', true, 2, 'moon1');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'moon2');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon3', true, 4, 'moon3');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon4');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon5');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon6');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon7');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon8');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon9');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon10');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon11');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon12');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon13');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon14');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon15');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon16');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon17');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon18');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon19');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon4', true, 5, 'moon20');
INSERT 0 1
universe=> ALTER TABLE galaxy ADD COLUMN rotation_speed INT NOT NULL DEFAULT(100000);
ALTER TABLE
universe=> SELECT * FROM galaxy
universe-> ;
+-----------+-------+-------------+-----------+----------------+
| galaxy_id | speed | description |   name    | rotation_speed |
+-----------+-------+-------------+-----------+----------------+
|         1 |       |             | zooby     |         100000 |
|         2 |       |             | louis     |         100000 |
|         3 |       |             | armour    |         100000 |
|         4 |       |             | zoe       |         100000 |
|         5 |       |             | mcgonigle |         100000 |
|         6 |       |             | suuai     |         100000 |
+-----------+-------+-------------+-----------+----------------+
(6 rows)

universe=> 
