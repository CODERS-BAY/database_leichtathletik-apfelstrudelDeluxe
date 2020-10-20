-- Schrittweise Erstellung der Tabellen nach dem ER-Diagramm
------------------------------------------------------------

CREATE TABLE austragungsort (
    austragungsort_id int NOT NULL AUTO_INCREMENT,
    stadt varchar(50),
    strasze_nummer varchar(50),
    plz int(10),
    land varchar(50),
    primary key (austragungsort_id)
)

DELETE FROM austragungsort;

DROP TABLE austragungsort;

-- nachträglichen Entfernen von NOT NULL:
ALTER TABLE austragungsort MODIFY austragungsort_id int(3);

CREATE TABLE veranstaltung (
    veranstaltung_id int(6) NOT NULL AUTO_INCREMENT,
    austragungs_zeit datetime,
    disziplin varchar(100),
    austragungsort_id int(3) NOT NULL,
    primary key (veranstaltung_id),
    foreign key (austragungsort_id) REFERENCES austragungsort(austragungsort_id)
)

ALTER TABLE veranstaltung MODIFY austragungs_zeit datetime DEFAULT '2000-01-01 00:00:00';

show table status;

CREATE TABLE ereignis (
    ereignis_id int(6) NOT NULL AUTO_INCREMENT,
    rang int(6),
    ergebniswert varchar(50),
    veranstaltungs_id int(6) NOT NULL,
    teilnehmernummer int(6),
    primary key (ereignis_id),
    foreign key (veranstaltungs_id) REFERENCES veranstaltung(veranstaltung_id)
)

CREATE TABLE athlet (
    teilnehmernummer int(6) NOT NULL AUTO_INCREMENT,
    name varchar(100),
    nation varchar(50),
    primary key (teilnehmernummer)
)

-- Nachdem die Tabelle "athlet" erstellt ist gebe ich einen weiteren Fremdschlüssel bei "ereignis" dazu.
ALTER TABLE ereignis
    add foreign key (teilnehmernummer) REFERENCES athlet(teilnehmernummer);

CREATE TABLE helfer (
    helfer_id int(6) NOT NULL AUTO_INCREMENT,
    helfer_name varchar(50),
    rolle varchar(50),
    helfer_veranstaltung_id int(6) NOT NULL,
    primary key (helfer_id)
)

ALTER TABLE veranstaltung ADD helfer_veranstaltung_id int(6) NOT NULL;

ALTER TABLE austragungsort ADD name_austragungsort varchar(50);

CREATE TABLE helfer_veranstaltung (
    helfer_veranstaltung_id int(6) NOT NULL AUTO_INCREMENT,
    helfer_id int(6) NOT NULL,
    veranstaltung_id int(6) NOT NULL,
    primary key (helfer_veranstaltung_id),
    foreign key (helfer_id) REFERENCES helfer(helfer_id),
    foreign key (veranstaltung_id) REFERENCES veranstaltung(veranstaltung_id)
)

ALTER TABLE helfer
    add foreign key (helfer_veranstaltung_id) REFERENCES helfer_veranstaltung(helfer_veranstaltung_id);

ALTER TABLE veranstaltung
    add foreign key (helfer_veranstaltung_id) REFERENCES helfer_veranstaltung(helfer_veranstaltung_id);


-- Befüllen der TAbellen mit Testdaten
--------------------------------------

INSERT INTO austragungsort2 (stadt, strasze_nummer, plz, land, name_austragungsort)

VALUES ('Moskau', 'Luzhniki 1', 58965, 'Russland', 'Luzhniki-Stadion'),
       ('St. Petersburg', 'Vodka 50', 77413, 'Russland', 'Sankt-Petersburg-Stadion'),
       ('Sotschi', 'Kalika Straße 9', 68965, 'Russland', 'Fisht-Stadion'),
       ('Kasan', 'Kasan Straße 9', 36411, 'Russland', 'Kasan-Arena');

INSERT INTO athlet (name, nation)
VALUES ('Christian Coleman', 'USA'),
       ('Justin Gatlin', 'USA'),
       ('Akani Simbine', 'RSA'),
       ('Andre De Grasse', 'CAN'),
       ('Shelly-Ann Fraser-Pryce', 'JAM'),
       ('Dina Asher-Smith', 'GBR'),
       ('Marie-Josée Ta Lou', 'CIV'),
       ('Elaine Thompson', 'JAM');

ALTER TABLE austragungsort MODIFY column austragungsort_id int NOT NULL AUTO_INCREMENT;

CREATE TABLE austragungsort2 (
    austragungsort_id int NOT NULL AUTO_INCREMENT,
    stadt varchar(50),
    strasze_nummer varchar(50),
    plz int(10),
    land varchar(50),
    primary key (austragungsort_id)
)


--  offen

INSERT INTO veranstaltung (austragungs_zeit, disziplin)
VALUES ('2019-09-28 10:00:00', '100 m Männer'),
       ('2019-09-28 11:00:00', '100 m Frauen'),
       ('2019-09-29 10:30:00', '200 m Männer'),
       ('2019-09-29 12:00:00', '200 m Frauen'),
       ('2019-09-30 10:00:00', '3.000 m Hindernis Männer'),
       ('2019-09-30 14:00:00', '3.000 m Hindernis Frauen');



INSERT INTO ereignis (rang, ergebniswert, veranstaltungs_id, teilnehmernummer)



-- DATETIME - format: YYYY-MM-DD HH:MM:SS

-- 2. Versuch am 2.10.2020
-- -----------------------------
-- -----------------------------

DROP database leichtathletikwm;

CREATE TABLE IF NOT EXISTS arena (arena_id INT NOT NULL AUTO_INCREMENT, address VARCHAR(50), city VARCHAR(25), PRIMARY KEY(arena_id));
CREATE TABLE IF NOT EXISTS helper (helper_id INT NOT NULL AUTO_INCREMENT , name VARCHAR(25), function VARCHAR(20), PRIMARY KEY (helper_id));
CREATE TABLE IF NOT EXISTS athlet (athlet_id INT NOT NULL AUTO_INCREMENT, name VARCHAR(25), nation VARCHAR(3), PRIMARY KEY (athlet_id));
CREATE TABLE IF NOT EXISTS competition (competition_id INT NOT NULL AUTO_INCREMENT, athlet_id INT NOT NULL, result INT, PRIMARY KEY(competition_id), FOREIGN KEY (athlet_id) REFERENCES athlet(athlet_id));
CREATE TABLE IF NOT EXISTS event (event_id INT NOT NULL AUTO_INCREMENT, time DATETIME, event_name VARCHAR(20), arena_id INT NOT NULL, competition_id INT NOT NUll, helper_event_id INT,
    PRIMARY KEY(event_id),
    FOREIGN KEY (competition_id) REFERENCES competition(competition_id),
    FOREIGN KEY (arena_id) REFERENCES arena(arena_id));
CREATE TABLE IF NOT EXISTS helpers_event (helper_event_id INT NOT NULL AUTO_INCREMENT, helper_id INT, event_id INT,
    PRIMARY KEY (helper_event_id), FOREIGN KEY (helper_id)REFERENCES helper(helper_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id));
INSERT INTO arena (address, city) values ('Froschberg 16', 'Linz');
INSERT INTO helper (name, function) VALUES ('Wolfgang Reinthaler', 'Schiedsrichter');
INSERT INTO athlet (name, nation) VALUES ('Dagmar Graf', 'AUT');
INSERT INTO competition (athlet_id, result) VALUES (1, 1);
INSERT INTO event (time, event_name, arena_id, competition_id, helper_event_id) VALUES ('2020-09-01 10:00:00', 'Siebenkampf', 1, 2, 1);
INSERT INTO helpers_event (helper_id, event_id) VALUES (2, 3);
INSERT INTO athlet(name, nation) VALUES ('Hildegard Schwarz', 'GER');
INSERT INTO athlet(name, nation) VALUES ('Manuela Compan', 'ITA');
INSERT INTO event (time, event_name, arena_id, competition_id, helper_event_id) VALUES ('2020-09-02 11:00:00', 'Weitspringen', 1, 2, 1);


-- Mitschrift vom 2.10.2020
-- -----------------------------
-- -----------------------------

use diary;
create table athlet (
    athlet_id int NOT NULL AUTO_INCREMENT,
    athlet_name varchar(30) NOT NULL,
    birth_date DATE DEFAULT '1990-01-01' COMMENT 'This is the date where the athlet is born',
    CHECK (birth_date<='2004-01-01'),
    PRIMARY KEY (athlet_id)
    );
create table result (
    result_id int NOT NULL AUTO_INCREMENT,
    result int DEFAULT 100,
    athlet_id int NOT NULL,
    PRIMARY KEY (result_id)
);
/* ALTER TABLE result ADD; #...
ALTER TABLE result MODIFY
ALTER TABLE DROP;
ALTER TABLE RENAME */
DROP TABLE result;
ALTER TABLE result ADD FOREIGN KEY (athlet_id) REFERENCES athlet(athlet_id) ON DELETE CASCADE ON UPDATE CASCADE;
# CONSTRAINT
ALTER TABLE result ADD CONSTRAINT my_constraint FOREIGN KEY (athlet_id) REFERENCES athlet(athlet_id);
# DELETE FOREIGN KEY
ALTER TABLE result DROP FOREIGN KEY result_ibfk_1;
ALTER TABLE result MODIFY COLUMN result_id varchar(20) NOT NULL;
SHOW CREATE TABLE athlet;
INSERT INTO athlet (athlet_name, birth_date) VALUES ('Peppi', '2001-01-01');
SELECT * from athlet;
INSERT INTO result (athlet_id) VALUES (6);
UPDATE athlet SET athlet_id = 8 WHERE athlet_id=6;
DELETE FROM athlet WHERE athlet_id = 5;