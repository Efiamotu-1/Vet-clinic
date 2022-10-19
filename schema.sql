/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg INTEGER,
    species VARCHAR
);
