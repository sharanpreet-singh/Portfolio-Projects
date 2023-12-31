--Creating the Sources Relation
CREATE TABLE Source
(
source_name VARCHAR(30), 
source_website VARCHAR(100),
source_id NUMBER(10),

PRIMARY KEY (source_id)
);

--Creating the Vaccines Relation
CREATE TABLE Vaccines
(
vaccines VARCHAR(30),
vaccine_id NUMBER(10),

PRIMARY KEY (vaccine_id)
);
--Creating the Countries Relation
CREATE TABLE Countries
(
location VARCHAR(20),
iso_code VARCHAR(10),

PRIMARY KEY (location)
);

--Creating the FourCountries Relation
CREATE TABLE FourCountries
(
location VARCHAR(20),
date NUMERIC(10),
vaccine_id NUMBER(10),
source_id NUMBER(10),

FOREIGN KEY (vaccine_id) REFERENCES Vaccines (vaccine_id)
FOREIGN KEY (source_id) REFERENCES Source (source_id)
FOREIGN KEY (location) REFERENCES Countries (location)

PRIMARY KEY (location, date, vaccine_id, source_id)
);

--Creating the StateVaccinations Relation
CREATE TABLE StateVaccinations 
(
location VARCHAR(20),
date DATE(10),
state VARCHAR(20),
total_vaccinations NUMBER(10),
total_distributed NUMBER(10),
people_vaccinated NUMBER(10),
people_fully_vaccinated NUMBER(10),
daily_vaccinations_raw NUMBER(10),
daily_vaccinations NUMBER(10),
share_doses_used NUMBER(10),
total_boosters NUMBER(10),

FOREIGN KEY (location) REFERENCES Countries(location)
PRIMARY KEY (location, date, state)
);

--Creating the Locations Relation
CREATE TABLE Locations
(
location VARCHAR(20),
iso_code VARCHAR(10),
vaccine_id NUMBER(10),
last_observation_date DATE(10),
source_id NUMBER(10), 

FOREIGN KEY (vaccine_id) REFERENCES Vaccines (vaccine_id)
FOREIGN KEY (source_id) REFERENCES Source (source_id)
FOREIGN KEY (location) REFERENCES Countries(location)

PRIMARY KEY (location, iso_code, vaccine_id, last_observation_date)
);

--Creating the Vaccinations Relation
CREATE TABLE Vaccinations
(
location VARCHAR(20),
iso_code VARCHAR(10),
date NUMERIC(10),
total_vaccinations NUMBER(10),
people_vaccinated NUMBER(10),
people_fully_vaccinated NUMBER(10),
total_boosters NUMBER(10),
daily_vaccinations_raw NUMBER(10),
daily_vaccinations NUMBER(10),
daily_people_vaccinated NUMBER(10),

FOREIGN KEY (location) REFERENCES Countries (location)
PRIMARY KEY (location, iso_code, date) 
);

--Creating the VaccinationsByManufacturer Relation
CREATE TABLE VaccinationsByManufacturer
(
location VARCHAR(20),
date DATE(10),
vaccine_id NUMBER(10),
total_vaccinations NUMBER(10),

FOREIGN KEY (vaccine_id) REFERENCES Vaccines(vaccine_id)
FOREIGN KEY (location) REFERENCES Countries (location)

PRIMARY KEY (location, date, vaccine_id)
);

--Creating the VaccinationsByAgeGroup Relation
CREATE TABLE VaccinationsByAgeGroup
(
location VARCHAR(20),
date DATE(10),
age_group NUMBER(100),
people_vaccinated_per_hundred NUMBER(10),
people_fully_vaccinated_per_hundred NUMBER(10),
people_with_booster_per_hundred NUMBER(10),

FOREIGN KEY (location) REFERENCES Countries (location)
PRIMARY KEY (location, date,age_group) 
);