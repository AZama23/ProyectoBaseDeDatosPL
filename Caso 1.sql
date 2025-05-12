CREATE TABLE puntaje_equipo(
	equipo VARCHAR(25),
	puntos SMALLINT,
	fecha TIMESTAMP
);

INSERT INTO puntaje_equipo(equipo, puntos, fecha)
SELECT equipo.nombre,
	   3,
	   partido.date
FROM partido
JOIN equipo ON equipo.id = partido.home_team_id
WHERE full_time_home_goals > full_time_away_goals AND
	  liga_id = 1;

INSERT INTO puntaje_equipo(equipo, puntos, fecha)
SELECT equipo.nombre,
	   1,
	   partido.date
FROM partido
JOIN equipo ON equipo.id = partido.home_team_id
WHERE full_time_home_goals = full_time_away_goals AND
	  liga_id = 1;

INSERT INTO puntaje_equipo(equipo, puntos, fecha)
SELECT equipo.nombre,
	   3,
	   partido.date
FROM partido
JOIN equipo ON equipo.id = partido.away_team_id
WHERE full_time_away_goals > full_time_home_goals AND
	  liga_id = 1;

INSERT INTO puntaje_equipo(equipo, puntos, fecha)
SELECT equipo.nombre,
	   1,
	   partido.date
FROM partido
JOIN equipo ON equipo.id = partido.away_team_id
WHERE full_time_away_goals = full_time_home_goals AND
	  liga_id = 1;

SELECT equipo, SUM(puntos) AS total_puntos
FROM puntaje_equipo
GROUP BY equipo
ORDER BY total_puntos DESC
LIMIT 7;

CREATE TABLE diferencia_goles_equipo(
	equipo VARCHAR(25),
	diferencia SMALLINT
);

INSERT INTO diferencia_goles_equipo(equipo, diferencia)
SELECT equipo.nombre,
	   full_time_home_goals - full_time_away_goals
FROM partido
JOIN equipo ON equipo.id = partido.home_team_id
WHERE liga_id = 1;

INSERT INTO diferencia_goles_equipo(equipo, diferencia)
SELECT equipo.nombre,
	   full_time_away_goals - full_time_home_goals
FROM partido
JOIN equipo ON equipo.id = partido.away_team_id
WHERE liga_id = 1;

SELECT equipo, SUM(diferencia)
FROM diferencia_goles_equipo
GROUP BY equipo
ORDER BY sum DESC
LIMIT 7;








