/* Database schema to keep the structure of entire database.. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg INTEGER,
    species VARCHAR
);

CREATE TABLE owners (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    full_name VARCHAR,
    age INTEGER
);

CREATE TABLE species (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

CREATE TABLE vets (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR,
    age INTEGER,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    species_id INTEGER REFERENCES species(id),
    vet_id INTEGER REFERENCES vets(id)
);

CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    date_of_visit DATE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);


CREATE INDEX animal_index ON visits(animal_id);
CREATE INDEX vet_index ON visits(vet_id);
CREATE INDEX ON owners ((lower(email)))



