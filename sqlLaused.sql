-- SQL Server Management Stuudio
-- Login

-- (localdb)\MSSQLLocalDB

--Authentification: Windows Auth - Admini Õigused LocalHostis

--Authentification: SQL Server Auth - Varem Loodud Kasutajad

--New Query

CREATE DATABASE KoltsinTITpv23;
--OBJECT EXPLORER ON VAJA PIDEVALT UUENDADA KÄASITI

USE KoltsinTITpv23;
--TABELI LOOMINE

CREATE TABLE opilanes(
opilaneID int Primary Key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) Unique,
synicalaeg date,
aadress TEXT,
opilaskodu bit
);
SELECT * FROM opilanes;
--TABELI KUSTUMINE

DROP table opilanes;
--ANDMETE LISAMINE TABELISSE

INSERT INTO opilanes(eesnimi, perenimi, synicalaeg, aadress, opilaskodu)
VALUES ('Mark', 'Levin', '2000-12-5', 'Tallinn', 1),
('Andrei', 'Astora', '897-3-6', 'DarkSouls', 0),
('Mati', 'Kask', '2005-11-2', 'Tartu', 0);
