
DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;
CREATE USER normal_user;
CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars normal_user;
\i scripts/denormal_data.sql; 
