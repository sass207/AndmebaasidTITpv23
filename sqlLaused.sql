CREATE DATABASE KoltsinTIT;

USE KoltsinTIT;

CREATE TABLE opilanes(
opilaneID int Primary Key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) Unique,
synniaeg date,
aadress TEXT,
opilaskodu bit
);
SELECT * FROM opilanes;

DROP table opilanes;

INSERT INTO opilanes(eesnimi, perenimi, synniaeg, aadress, opilaskodu)
VALUES ('Ilja', 'Gershkevitch', '2005-03-15', 'Tallinn', 1),
('Jaramir', 'Gutsuljak', '2005-03-15', 'Tallinn', 1),
('Aleksandr', 'Koltsin', '2005-03-15', 'Maardu', 1)
