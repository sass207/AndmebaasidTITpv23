CREATE DATABASE aleksandrtitpv23;
--OBJECT EXPLORER ON VAJA PIDEVALT UUENDADA KÄASITI

USE aleksandrtitpv23;
--TABELI LOOMINE

CREATE TABLE Opilane(
OpilaneID int Primary Key identity(1,1),
Eesnimi varchar(25),
Perenimi varchar(30) Unique,
Synicalaeg date,
Aadress TEXT,
Opilaskodu bit
);

--kasutamine seos tabelite vahel - JOIN
SELECT * FROM Opilane JOIN ryhm ON opilane.ryhmID=ryhm.ryhmID;
--TABELI KUSTUMINE

DROP table opetaja;
--ANDMETE LISAMINE TABELISSE

INSERT INTO Opilane(Eesnimi, Perenimi, Synicalaeg, Aadress, Opilaskodu)
VALUES ('Mark', 'Levin', '2000-12-5', 'Tallinn', 1),
('Andrei', 'Astora', '1897-3-6', 'DarkSouls', 0),
('Mati', 'Kask', '2005-11-2', 'Tartu', 0);

-- tabel Ruhm
CREATE TABLE ryhm(
ryhmID int not null primary key identity(1,1),
ryhm varchar(10) unique,
osakond varchar(20)
);
INSERT INTO ryhm(ryhm, osakond)
Values ('TiTpv24', 'IT'),('KRRpv23','Rätsepp');

Select * from ryhm;

-- lisame uus veerg RyhmID tabelisse opilane
ALTER TABLE Opilane ADD ryhmID int;

--lisame foreign key
ALTER TABLE Opilane ADD foreign key (ryhmID) references ryhm(ryhmID)

--foreign key kontroll
INSERT INTO Opilane(Eesnimi, Perenimi, Synicalaeg, Aadress, Opilaskodu, ryhmID)
VALUES ('Mark', 'MegaSigma', '2000-12-5', 'Tallinn', 1, 1)

--lihtsaim vaade
SELECT o.perenimi, r.ryhm, o.aadress FROM Opilane o JOIN ryhm r ON o.ryhmID=r.ryhmID;

--tabel hinne
CREATE TABLE hinne(
hinneID INT NOT NULL PRIMARY KEY Identity (1,1),
OpilaneID INT,
hinne int,
opiaine VARCHAR(20),
);

Select * from hinne;

ALTER TABLE hinne ADD foreign key (opilaneID) references Opilane(OpilaneID);

INSERT INTO hinne(OpilaneID, opiaine, hinne)
Values (5, 'Arvutivõrgud', 5 ),(9,'Linux', 3 );
select * from hinne;
SELECT o.Perenimi, h.hinne FROM Opilane o JOIN hinne h ON o.OpilaneID=h.OpilaneID;

CREATE TABLE opetaja(
OpetajaID INT NOT NULL PRIMARY KEY,
nimi varchar(20),
perenimi varchar(20) unique,
telefon varchar(50)
);

Select * from opetaja;

ALTER TABLE ryhm ADD OpetajaID int;
ALTER TABLE ryhm ADD foreign key (OpetajaID) references opetaja(OpetajaID)
INSERT INTO opetaja(nimi, perenimi, telefon)
VALUES ('Mikhail', 'Agapov', '12497'), ('Nikita', 'Podkopaev', '41774');

CREATE DATABASE kasutajatit;

USE kasutajatit;

CREATE TABLE kontroll2(
id int primary key identity(1,1),
test varchar(25));

INSERT INTO kontroll2(test)

VALUES('kontroll test');

SELECT * FROM kontroll;

SELECT * FROM kontroll2;

--loome kasutaja LOGIN kaudu
--määrame SQL käskuga opilane õigused
--luubamine
GRANT INSERT ON kontroll TO opilaneAleksandr;

GRANT DELETE ON kontroll2 TO opilaneAleksandr;

--keelamine
DENY UPDATE ON kontroll TO opilaneAleksandr;

DENY UPDATE ON kontroll2 TO opilaneAleksandr;

--kasutaja õiguste kontroll
SELECT * FROM kontroll;

SELECT * FROM kontroll2;

INSERT INTO kontroll(test)

VALUES('kontroll test');

DELETE FROM kontroll2;

UPDATE kontroll set test='uus kontrol';

-- ulesanne

CREATE DATABASE aleksandrlaused;

USE aleksandrlaused;

CREATE TABLE firma (
firmaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
firmanimi VARCHAR(50) unique,
aadress VARCHAR(50),
telefon VARCHAR(50)
);

CREATE TABLE praktikajuhendaja (
praktikajuhendajaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
eesnimi VARCHAR(50),
perekonnanimi VARCHAR(50),
synniaeg DATE,
telefon VARCHAR(50)
);

CREATE TABLE praktikabaas (
praktikabaasID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
firmaID INT,
praktikatingimused VARCHAR(50),
arvutiprogramm VARCHAR(50),
praktikajuhendajaID INT,
FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
FOREIGN KEY (praktikajuhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

INSERT INTO firma(firmanimi,aadress,telefon)
VALUES ('Reggi','rjowsey0@over-blog.com',6942412586),
('Verge','vmemory1@godaddy.com',2209490310),
('Adolphe','aharfleet2@cmu.edu',8052994571),
('Sidonnie','smaccart3@printfriendly.com',1676132892),
('Herta','hmaccallion4@storify.com',8954194771);

INSERT INTO praktikajuhendaja(eesnimi,perekonnanimi,synicalaeg,telefon)
VALUES ('Corbet','Tuminelli','1968-05-19',7118158246),
('Toby','Halbeard','1952-04-29',4568623075),
('Rozalie','Poizer','1980-01-26',9191991507),
('Thorn','Dumbleton','1951-03-18',9517001077),
('Sephira','Thayre','1954-09-16',7127249272);

INSERT INTO praktikabaas(firmaID,praktikatingimused,arvutiprogramm,praktikajuhendajaID)
VALUES (1,' 6 kuud, täistööajaga', 'Microsoft Excel', 1),
(2,' 3 kuud, osalise tööajaga', 'Adobe Photoshop', 2),
(3, '1-aastane kestus, täistööajaga', 'AutoCAD', 3),
(4, '6 kuud kestus, täistööajaga', 'Python', 4),
(5, '3 kuud, osalise tööajaga', 'JavaScript', 5);

SELECT * FROM firma
WHERE firmanimi LIKE '%a%'

SELECT *
FROM praktikabaas p
JOIN firma f ON f.firmaID = p.firmaID
ORDER BY f.firmanimi;

SELECT f.firmanimi, COUNT(p.praktikabaasID) AS firmadeKogus
FROM firma f
JOIN praktikabaas p ON f.firmaId = p.firmaID
GROUP BY f.firmanimi;

SELECT *
FROM praktikajuhendaja
WHERE Month(synicalaeg) IN (9,10,11);

SELECT MONTH(synicalaeg) AS Month, COUNT(*) AS JuhendajaKogemus
FROM praktikajuhendaja
GROUP BY MONTH(synicalaeg)
ORDER BY Month;

SELECT p.praktikajuhendajaID, j.eesnimi, j.perekonnanimi, COUNT(*) AS PraktikaKogemus
FROM praktikabaas p
JOIN praktikajuhendaja j ON p.praktikajuhendajaID = j.praktikajuhendajaID
GROUP BY p.praktikajuhendajaID, j.eesnimi, j.perekonnanimi
ORDER BY PraktikaKogemus DESC;

ALTER TABLE praktikajuhendaja
ADD palk DECIMAL(10, 2);

CREATE TABLE praktikabaaslogi (
ID INT PRIMARY KEY IDENTITY(1,1),
kasutaja VARCHAR(25),
aeg VARCHAR(25),
tegevus VARCHAR (25),
andmed VARCHAR (255)
);

CREATE TRIGGER praktikabaastrigger
ON praktikabaas
FOR INSERT
AS
INSERT INTO praktikabaaslogi(kasutaja, aeg, tegevus, andmed)
SELECT
SYSTEM_USER,
'praktikabaas on lisatud',
GETDATE(),
CONCAT(inserted.firmaID, ', ', inserted.praktikatingimused, ', ', inserted.arvutiprogramm, ', ', inserted.praktikajuhendajaID)
FROM inserted;

select * from praktikabaas;

--kontroll

INSERT INTO praktikabaas(firmaID, praktikatingimused, arvutiprogramm, praktikajuhendajaID)
VALUES (5,' 5 kuud, täistööajaga', 'unity', 5);

select * from praktikabaaslogi;

--uuendamine trigger

CREATE TRIGGER praktikabaasUuendamine
ON praktikabaas
FOR UPDATE
AS
INSERT INTO praktikabaaslogi(kasutaja, aeg, tegevus, andmed)
SELECT
SYSTEM_USER,
'praktikabaas on uuendatud',
GETDATE(),
CONCAT(
'vana praktikabaas info - ', deleted.firmaID, ', ', deleted.praktikatingimused, ', ', deleted.arvutiprogramm, ', ', deleted.praktikajuhendajaID,
', uus praktikabaas info - ', inserted.firmaID, ', ', inserted.praktikatingimused, ', ', inserted.arvutiprogramm, ', ', inserted.praktikajuhendajaID
)
FROM deleted INNER JOIN inserted
ON deleted.praktikabaasID=inserted.praktikabaasID;

--kontroll

update praktikabaas
set praktikatingimused = 'crazy', arvutiprogramm = 'vegas pro'
where praktikabaasID = 15;

select * from praktikabaaslogi;

CREATE TRIGGER trg_Check_Juhendaja_Synniaeg
ON praktikajuhendaja
INSTEAD OF INSERT
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE synniaeg > GETDATE())
BEGIN
RAISERROR('Sünniaeg ei tohi olla tulevikus.', 16, 1);
END
ELSE
BEGIN
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
SELECT eesnimi, perekonnanimi, synniaeg, telefon
FROM inserted;
END
END;

--kontroll

INSERT INTO praktikajuhendaja(eesnimi,perekonnanimi,synniaeg,telefon)
VALUES ('Corbet','Tuminelli','2025-03-19',7118158246);

deny select on praktikabaaslogi to sigma;
grant select on firma to sigma;
grant select, update on praktikabaas to sigma;
grant select on praktikajuhendaja to sigma;
