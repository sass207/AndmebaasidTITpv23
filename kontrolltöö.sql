CREATE DATABASE aleksandrtöö;
USE DATABASE aleksandrtöö;

CREATE TABLE isik(
id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
sugu char(1),
sunnikuupaev DATETIME,
aadress varchar(100),
email varchar(50),
);

insert into isik (eesnimi,perenimi,sugu,sunnikuupaev,aadress,email) values ('aleksandr', 'koltsin', 1, 1923-1-2, 'kellamae', 'sigmanavia69');

CREATE TABLE oppeaine(
id int primary key identity(1,1),
nimi varchar(100),
vastutav_opetaja int,
aine_keslus varchar(50),
foreign key (vastutav_opetaja) references isik(id),
);

insert into oppeaine(nimi,vastutav_opetaja, aine_keslus) values ('aleksandr', 1, 'bfg');

CREATE TABLE oppimine(
id int primary key identity(1,1),
isiku_id int,
oppeaine_id int,
hinne int
foreign key (isiku_id) references isik(id),
foreign key (oppeaine_id) references oppeaine(id),
);

insert into oppimine(isiku_id, oppeaine_id, hinne) values (1, 2, 5);

CREATE TABLE logi(
id int primary key identity(1,1),
kasutaja varchar(50),
kuupaev DATETIME,
sisestatudandmed text,
);

CREATE TRIGGER update_logi
ON oppimine
FOR UPDATE
AS
INSERT INTO logi (kasutaja, kuupaev, sisestatudandmed)
SELECT
    SYSTEM_USER,
    GETDATE(),
    CONCAT(
        'vana oppimine info - ', deleted.isiku_id, ', ', deleted.oppeaine_id, ', ', deleted.hinne,
        ', uus oppimine info - ', inserted.isiku_id, ', ', inserted.oppeaine_id, ', ', inserted.hinne
    )
FROM deleted
INNER JOIN inserted ON deleted.id = inserted.id;

select * from isik;
select * from oppeaine;
select * from oppimine;

update oppimine set hinne = 6;

select * from logi;

CREATE TRIGGER oppimineLisamine
ON oppimine
FOR INSERT
AS
INSERT INTO logi(kasutaja, kuupaev, sisestatudandmed)
SELECT
SYSTEM_USER,
GETDATE(),
CONCAT(inserted.isiku_id, ', ' ,inserted.oppeaine_id, ', ' ,inserted.hinne)
FROM inserted;

insert into oppimine(isiku_id, oppeaine_id, hinne) values (1, 2, 3);

GRANT CREATE TABLE TO aleksandr;
GRANT SELECT, INSERT ON SCHEMA::dbo TO aleksandr;
GRANT CONTROL ON SCHEMA::dbo TO aleksandr;
DENY DELETE, UPDATE ON SCHEMA::dbo TO aleksandr;

revoke alter on schema::dbo to aleksandr;

BEGIN TRANSACTION;

select * from isik;

insert into isik (eesnimi, perenimi, sugu, sunnikuupaev, aadress,email) values ('aleksandr', 'koltsin', 2, 2025, 'lasnamae', 'sigma');

save transaction savepoint;
delete from isik where id = 2;

rollback transaction savepoint;
commit transaction;

SELECT 
    dp.name AS aleksandr, 
    perm.permission_name, 
    perm.state_desc
FROM sys.database_principals dp
JOIN sys.database_permissions perm
    ON dp.principal_id = perm.grantee_principal_id
WHERE dp.name = 'aleksandr';
