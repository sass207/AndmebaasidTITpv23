-- SQL kommentaar
-- Xampp
-- connect to
--(localdb)\mssqllocaldb
--Authentification:kasutajanimi root
--parool ei ole
CREATE DATABASE KoltsinTIT;
--Object Explorer on vaja pidevalt uuendada käsitsi!
USE KoltsinTIT;

DROP DATABASE KoltsinTIT;

--tabeli loomine
CREATE TABLE opilane1(
opilaneID int Primary Key AUTO_INCREMENT,
eesnimi varchar(25),
perenimi varchar(30) Unique,
synniaeg date,
aadress TEXT,
opilaskodu bit
);
SELECT * FROM opilane1;

--tabeli kustutamine
DROP table opilane1;

--andmete lisamine tabelisse
INSERT INTO opilane1(eesnimi, perenimi, synniaeg, aadress, opilaskodu)
VALUES ('Andrei', 'Ivanov', '2005-12-5', 'Tallinn', 1),
('Mati', 'Kask', '2003-12-5', 'Tallinn', 0),
('Peeter', 'Uus', '2000-10-5', 'Tallinn', 0);

CREATE TABLE ryhm(
ryhmID int not null primary key identity(1,1),
ryhm varchar(10) unique,
osakond varchar(20)
);
INSERT INTO ryhm(ryhm, osakond)
Values('TITpv24', 'IT'),('KRRpv23','Rätsepp');

Select * from ryhm;
--lisame uus veerg RyhmID tabelisse opilane
ALTER TABLE opilane1 ADD ryhmID int;

Select *  from opilane1;

--lisame foreign key veergule ryhmID mis on seotud
--tabeliga ryhm ja veerguga ryhmID
ALTER TABLE opilane1 
Add foreign key (ryhmID) references ryhm(ryhmID);

--foreign key kontroll
INSERT INTO opilane1
(eesnimi, perenimi, synniaeg, aadress, opilaskodu, ryhmID)
VALUES ('Andrei', 'Ivanovssss', '2005-12-5', 'Tallinn', 1, 3);

SELECT * FROM opilane1;
--kasutame seos tabelite vahel - JOIN
SELECT * FROM opilane1 JOIN ryhm
ON opilane1.ryhmID=ryhm.ryhmID;

SELECT opilane1.perenimi, ryhm.ryhm FROM opilane1 JOIN ryhm
ON opilane1.ryhmID=ryhm.ryhmID;

--lihtsaim vaade
SELECT o.perenimi, r.ryhm, o.aadress
FROM opilane1 o JOIN ryhm r
ON o.ryhmID=r.ryhmID;

CREATE TABLE hinne(
hinneID int primary key identity(1,1),
hinne int,
opilaneID int,
oppeaine varchar(50)
);

ALTER TABLE hinne
ADD foreign key (opilaneID) references opilane(opilaneID);

INSERT INTO hinne(opilaneID, oppeaine, hinne)
Values(7, 'andmebaasid', 3);

select * from hinne;

SELECT o.perenimi, h.hinne FROM opilane1 o JOIN hinne h ON o.opilaneID=h.opilaneID;
