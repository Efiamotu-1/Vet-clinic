/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true; 
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Transactions*/

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleted_animals;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT deleted_animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Aggregates

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*JOIN Queries*/
SELECT * FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';
SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT * FROM owners FULL OUTER JOIN animals ON owners.id = animals.owner_id;
SELECT species.name, COUNT(*) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name AS "Animal name", full_name AS "Owner", species.name AS "Specie name"  FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species
ON animals.species_id = species.id WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT * FROM  animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Jennifer Orwell' AND escape_attempts = 0;
SELECT full_name, COUNT(*) FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT(owner_id) DESC LIMIT 1;

-- Many to Many queries
SELECT animals.name AS "Animal Name", vets.name AS "Vet Name", date_of_visit FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id  
INNER JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT vets.name AS "Vet Name", COUNT(*) FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id  
INNER JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name; 

SELECT * FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON specializations.species_id = species.id;  

SELECT animals.name AS "Animal Name", vets.name AS "Vet Name" FROM visits 
INNER JOIN animals ON visits.animal_id = animals.id 
INNER JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' GROUP BY animals.name, vets.name;

SELECT animals.name, COUNT(*) FROM visits
INNER JOIN animals ON visits.animal_id = animals.id 
GROUP BY animals.name ORDER BY COUNT(*) DESC;

SELECT vets.name AS "Vet Name", animals.name AS "Animal Name", date_of_visit FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit LIMIT 1;

SELECT  animals.name AS "Animal Name", vets.name AS "Vet Name", date_of_visit FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
ORDER BY date_of_visit LIMIT 1;

SELECT vets.name AS "Vet Name", COUNT(*) FROM visits
FULL OUTER JOIN Vets ON visits.vet_id = vets.id 
FULL OUTER JOIN specializations ON specializations.vet_id = Vets.id
FULL OUTER JOIN species ON specializations.species_id = species.id
WHERE specializations.species_id IS NULL OR specializations.species_id != species.id 
GROUP BY vets.name;

SELECT vets.name AS "Vet Name", species.name AS "Species", COUNT(*) FROM visits
INNER JOIN Vets ON visits.vet_id = vets.id 
INNER JOIN animals
ON visits.animal_id = animals.id
INNER JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name,species.name
LIMIT 1;
