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
