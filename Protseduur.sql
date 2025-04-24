CREATE DATABASE AleksandrTITpv23;

USE AleksandrTITpv23;

CREATE TABLE linnad(
linnID int PRIMARY KEY identity(1,1),
linnNimi varchar(30) unique,
elanikeArv int not null,
maakond varchar(25)
);

--Protseduur, mis lisab (INSERT)tabelisse andmed ja kohe näitab (SELECT) tabeli
CREATE PROCEDURE lisaLinn
@linnNimi varchar(30),
@elanikeArv int,
@maakond varchar(25)
AS
BEGIN
INSERT INTO linnad(linnNimi, elanikeArv, maakond)
VALUES (@linnNimi, @elanikeArv, @maakond);
SELECT * FROM linnad;
END;

--kutse
EXEC lisaLinn 'Keila', 1000, 'Keila';

--protseduuri kustutamine
DROP Procedure lisaLinn;

--protseduur, mis kustutab tabelist linnID järgi
CREATE PROCEDURE kustutaLinn
@id int
AS
BEGIN
SELECT * FROM linnad;
DELETE FROM linnad WHERE linnId=@id;
SELECT * FROM linnad;
END

--kutse
EXEC kustutaLinn 4;

--protseduur mis uuendab tabeli ja suurendab elanike arv 10%
CREATE PROCEDURE uuendaLinn
@arv decimal(5,2)
AS
BEGIN
SELECT * FROM linnad;
UPDATE linnad SET elanikeArv=elanikeArv*@arv;
SELECT * FROM linnad;
END

--kutse
EXEC uuendaLinn 0.05;
DROP PROCEDURE uuendaLinn;
UPDATE linnad SET elanikeArv=200000 WHERE linnID=2;
SELECT * FROM linnad;

CREATE PROCEDURE keskmineArv
AS
BEGIN
SELECT AVG(elanikeArv) AS 'Keskmine elanikeArv'
FROM linnad;

SELECT CAST(AVG(elanikeArv) AS decimal(7,2)) AS 'Keskmine elanikeArv' FROM linnad;
END

EXEC keskmineArv;

--ainult 1 taht
BEGIN
SELECT filmNimetus, pikkus
FROM film
WHERE filmNimetus LIKE CONCAT(taht, '%');
END

--ADD
BEGIN
set @sqltegevus=concat('ALTER TABLE ', 
tabelinimi, ' ADD COLUMN ' , veerunimi, ' ', tyyp);
PREPARE STMT FROM @sqltegevus;
EXECUTE STMT;
END

--DROP
BEGIN
set @sqltegevus=concat('ALTER TABLE ', 
tabelinimi, ' DROP COLUMN ' , veerunimi);
PREPARE STMT FROM @sqltegevus;
EXECUTE STMT;
END


--GET
BEGIN
DECLARE today TIMESTAMP DEFAULT CURRENT_DATE;
    SELECT today, filmnimetus, pikkus
    FROM film
    WHERE pikkus < pikkus_val;
END


--GET BY TYPE
BEGIN
SELECT f.filmNimetus, t.filmtype
FROM film f
INNER JOIN filmtype t ON f.filmtypeID=t.filmTypeID
AND t.filmtype= type;
END
