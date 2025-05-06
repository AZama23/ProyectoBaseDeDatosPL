/* Juntar las dos tablas de partidos */
INSERT INTO partido
SELECT * FROM partido2;

/* partido.id */
ALTER TABLE partido ADD COLUMN id BIGSERIAL NOT NULL PRIMARY KEY;

/* poblar equipo */
DROP TABLE IF EXISTS equipo;
CREATE TABLE equipo(
	id BIGSERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

INSERT INTO equipo (nombre)
SELECT DISTINCT home_team
FROM partido;

/* home_team_id */
ALTER TABLE partido ADD COLUMN home_team_id BIGINT CONSTRAINT fk_home_id REFERENCES equipo (id) ON DELETE SET NULL;

UPDATE partido 
SET home_team_id = (
	SELECT id
	FROM equipo
	WHERE equipo.nombre=partido.home_team
);
ALTER TABLE partido ALTER COLUMN home_team_id SET NOT NULL;
/* away_team_id */
ALTER TABLE partido ADD COLUMN away_team_id BIGINT CONSTRAINT fk_away_id REFERENCES equipo (id) ON DELETE SET NULL;

UPDATE partido 
SET away_team_id = (
	SELECT id
	FROM equipo
	WHERE equipo.nombre=partido.away_team
);
ALTER TABLE partido ALTER COLUMN away_team_id SET NOT NULL;

/* TABLA ARBITRO y arbitro_id*/
DROP TABLE arbitro;
CREATE TABLE arbitro(
	id BIGSERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

ALTER TABLE partido ADD COLUMN arbitro_id BIGINT CONSTRAINT fk_arbitro REFERENCES arbitro (id) ON DELETE SET NULL;

INSERT INTO arbitro (nombre)
SELECT DISTINCT referee
FROM partido;

UPDATE partido
SET arbitro_id = (
	SELECT id
	FROM arbitro
	WHERE arbitro.nombre=partido.referee
);

ALTER TABLE partido ALTER COLUMN arbitro_id SET NOT NULL;

/* TABLA temporada*/

CREATE TABLE temporada(
	id BIGSERIAL PRIMARY KEY,
	temp VARCHAR(15) NOT NULL
);
INSERT INTO temporada (temp)
SELECT DISTINCT season
FROM partido
ORDER BY season DESC;

ALTER TABLE partido ADD COLUMN temporada_id BIGINT CONSTRAINT fk_temporada REFERENCES temporada (id) ON DELETE CASCADE;

UPDATE partido
SET temporada_id = (
	SELECT id
	FROM temporada
	WHERE temporada."temp"=partido.season
);
ALTER TABLE partido ALTER COLUMN temporada_id SET NOT NULL;

/* liga */
CREATE TABLE liga(
	id BIGSERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);
INSERT INTO liga (nombre)
SELECT DISTINCT league
FROM partido
ORDER BY league DESC;

ALTER TABLE partido ADD COLUMN liga_id BIGINT CONSTRAINT fk_liga REFERENCES liga (id) ON DELETE SET NULL;
UPDATE partido
SET liga_id = (
	SELECT id
	FROM liga
	WHERE liga.nombre=partido.league
);
ALTER TABLE partido ALTER COLUMN liga_id SET NOT NULL;

/* borrar columnas de partido */
ALTER TABLE partido DROP COLUMN home_team;
ALTER TABLE partido DROP COLUMN away_team;
ALTER TABLE partido DROP COLUMN season;
ALTER TABLE partido DROP COLUMN league;
ALTER TABLE partido DROP COLUMN referee;
