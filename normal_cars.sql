\c normal_cars normal_user;

DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS make;
DROP TABLE IF EXISTS model;
-- DROP TABLE IF EXISTS model_year;


CREATE TABLE IF NOT EXISTS make
(
  id serial PRIMARY KEY,
  code character varying(125) NOT NULL,
  title character varying(125) NOT NULL
);

CREATE TABLE IF NOT EXISTS model
(
  id serial PRIMARY KEY,
  code character varying(125) NOT NULL,
  title character varying(125) NOT NULL
);

-- CREATE TABLE IF NOT EXISTS model_year
-- (
--   model_id integer NOT NULL REFERENCES model (id),
--   year integer NOT NULL,
--   PRIMARY KEY (model_id, year)
  
-- );

CREATE TABLE IF NOT EXISTS cars
(
  make_id integer NOT NULL REFERENCES make (id),
  model_id integer NOT NULL REFERENCES model (id),
  year integer NOT NULL
);

INSERT INTO make (code,title)
SELECT DISTINCT make_code, make_title
FROM car_models;

INSERT INTO model (code,title)
SELECT DISTINCT model_code, model_title
FROM car_models;

-- INSERT INTO model_year (code,title)
-- SELECT DISTINCT model_code, model_title
-- FROM car_models;

INSERT INTO cars (make_id, model_id, year)
SELECT make.id, model.id, year
FROM car_models
INNER JOIN make ON car_models.make_title = make.title AND car_models.make_code = make.code
INNER JOIN model ON car_models.model_title = model.title AND car_models.model_code = model.code;
     

-- INSERT INTO cars (make_id, model_id, year)
-- SELECT make_id, id AS model_id, year
-- FROM ( SELECT model_title, model_code, id AS make_id, year
--        FROM car_models
--        INNER JOIN make ON car_models.make_title = make.title AND car_models.make_code = make.code) AS make_join
-- INNER JOIN model ON make_join.model_title = model.title AND make_join.model_code = model.code;
     
SELECT title
FROM make;

SELECT DISTINCT model.title
FROM cars
INNER JOIN make ON cars.make_id = make.id
INNER JOIN model ON cars.model_id = model.id
WHERE make.code='VOLKS';

SELECT DISTINCT make.code AS make_code, model.code AS model_code, model.title AS model_title, year 
FROM cars
INNER JOIN make ON cars.make_id = make.id
INNER JOIN model ON cars.model_id = model.id
WHERE make.code='LAM';

SELECT DISTINCT * 
FROM cars
INNER JOIN make ON cars.make_id = make.id
INNER JOIN model ON cars.model_id = model.id
WHERE year BETWEEN 2010 AND 2015;
