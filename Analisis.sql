--CASO 1
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

------------------------------------------------------
-- CASO 2
WITH partidos AS (
  SELECT 
    p.*, 
    e1.nombre AS home_team,
    e2.nombre AS away_team
  FROM partido p
  JOIN equipo e1 ON p.home_team_id = e1.id
  JOIN equipo e2 ON p.away_team_id = e2.id
),
locales AS (
  SELECT 
    home_team AS team,
    AVG(full_time_home_goals) AS avg_goals_scored,
    AVG(home_shots) AS avg_shots,
    AVG(home_shots_on_target) AS avg_shots_on_target,
    AVG(home_corners) AS avg_corners,
    AVG(full_time_away_goals) AS avg_goals_conceded,
    AVG(away_shots) AS avg_shots_against,
    AVG(away_shots_on_target) AS avg_shots_on_target_against,
    AVG(away_corners) AS avg_corners_against
  FROM partidos
  GROUP BY home_team
),
visitantes AS (
  SELECT 
    away_team AS team,
    AVG(full_time_away_goals) AS avg_goals_scored_away,
    AVG(away_shots) AS avg_shots_away,
    AVG(away_shots_on_target) AS avg_shots_on_target_away,
    AVG(away_corners) AS avg_corners_away,
    AVG(full_time_home_goals) AS avg_goals_conceded_away,
    AVG(home_shots) AS avg_shots_against_away,
    AVG(home_shots_on_target) AS avg_shots_on_target_against_away,
    AVG(home_corners) AS avg_corners_against_away
  FROM partidos
  GROUP BY away_team
)

SELECT 
  l.team,

  (l.avg_goals_scored + v.avg_goals_scored_away) / 2 AS avg_goals_scored_total,
  (l.avg_shots + v.avg_shots_away) / 2 AS avg_shots_total,
  (l.avg_shots_on_target + v.avg_shots_on_target_away) / 2 AS avg_shots_on_target_total,
  (l.avg_corners + v.avg_corners_away) / 2 AS avg_corners_total,

  (l.avg_goals_conceded + v.avg_goals_conceded_away) / 2 AS avg_goals_conceded_total,
  (l.avg_shots_against + v.avg_shots_against_away) / 2 AS avg_shots_against_total,
  (l.avg_shots_on_target_against + v.avg_shots_on_target_against_away) / 2 AS avg_shots_on_target_against_total,
  (l.avg_corners_against + v.avg_corners_against_away) / 2 AS avg_corners_against_total,

  (
    ((l.avg_goals_scored + v.avg_goals_scored_away) / 2) * 3 +
    ((l.avg_shots_on_target + v.avg_shots_on_target_away) / 2) * 2 +
    ((l.avg_shots + v.avg_shots_away) / 2) +
    ((l.avg_corners + v.avg_corners_away) / 2)
  ) AS attack_index,

  (
    10 - (
      ((l.avg_goals_conceded + v.avg_goals_conceded_away) / 2) * 3 +
      ((l.avg_shots_on_target_against + v.avg_shots_on_target_against_away) / 2) * 2 +
      ((l.avg_shots_against + v.avg_shots_against_away) / 2) +
      ((l.avg_corners_against + v.avg_corners_against_away) / 2)
    )
  ) AS defense_index

FROM locales l
JOIN visitantes v ON l.team = v.team
ORDER BY attack_index DESC;

------------------------------------------------------
-- CASO 3
-- Ciudades
-- Caso de equipos en las principales ciudades de Inglaterra (Londres, Manchester y Liverpool)--
--Hago una CTE donde se agregan a un "grupo" aquellos equipos que queremos estudiar--
WITH
equipos_ciudad AS (
  SELECT id AS equipo_id, nombre
  FROM equipo
  WHERE nombre IN (
    'Arsenal', 'Brentford', 'Chelsea', 'Crystal Palace',
    'Fulham', 'Tottenham', 'West Ham',
    'Liverpool', 'Everton', 'Man United', 'Man City'
  )
),

-- Obtengo la información de los equipos de ciudad en partidos de local--
local_datos AS (
  SELECT
    ec.nombre AS equipo,
    COUNT(*) AS partidos_local,
    SUM(CASE
        WHEN p.full_time_result = 'H' THEN 3
        WHEN p.full_time_result = 'D' THEN 1
        ELSE 0
    END) AS puntos_locales
  FROM partido p
  JOIN equipos_ciudad ec ON p.home_team_id = ec.equipo_id
  WHERE p.liga_id = 1
  GROUP BY ec.nombre
),

-- Obtengo la información de los equipos de ciudad en partidos de visita--
visitante_datos AS (
  SELECT
    ec.nombre AS equipo,
    COUNT(*) AS partidos_visitante,
    SUM(CASE
        WHEN p.full_time_result = 'A' THEN 3
        WHEN p.full_time_result = 'D' THEN 1
        ELSE 0
    END) AS puntos_visitante
  FROM partido p
  JOIN equipos_ciudad ec ON p.away_team_id = ec.equipo_id
  WHERE p.liga_id = 1
  GROUP BY ec.nombre
),

-- Se crea el resultado, incluyendo nombre del equipo, promedio de puntos por juego de local y visitante y la diferencia entre local y visitante--
resultados_equipo AS (
  SELECT
    l.equipo,
    ROUND(l.puntos_locales::decimal / l.partidos_local, 2) AS promedio_local,
    ROUND(v.puntos_visitante::decimal / v.partidos_visitante, 2) AS promedio_visitante,
    ROUND(
      (l.puntos_locales::decimal / l.partidos_local) -
      (v.puntos_visitante::decimal / v.partidos_visitante), 2
    ) AS diferencia
  FROM local_datos l
  JOIN visitante_datos v ON l.equipo = v.equipo
)

--Se imprime--
SELECT * FROM resultados_equipo
--Se une para sacar el promedio general de estos equipos--
UNION ALL
--Se crea una consulta para los datos promedio de los equipos analizados--
SELECT
  'PROMEDIO GENERAL',
  ROUND(AVG(promedio_local), 2),
  ROUND(AVG(promedio_visitante), 2),
  ROUND(AVG(diferencia), 2)
FROM resultados_equipo;

-- Caso 3.1
-- Caso de equipos que NO ESTÁN en las principales ciudades de Inglaterra (Londres, Manchester y Liverpool)--
--Hago una CTE donde se agregan a un "grupo" aquellos equipos que queremos estudiar--
WITH
equipos_no_ciudad AS (
  SELECT id AS equipo_id, nombre
  FROM equipo
  WHERE nombre IN (
    'Aston Villa', 'Bournemouth', 'Brighton', 'Ipswich',
    'Leicester', 'Newcastle', 'Nott''m Forest', 'Southampton', 'Wolves'
  )
),

-- Obtengo la información de los equipos de ciudad en partidos de local--
local_datos AS (
  SELECT
    ec.nombre AS equipo,
    COUNT(*) AS partidos_local,
    SUM(CASE
        WHEN p.full_time_result = 'H' THEN 3
        WHEN p.full_time_result = 'D' THEN 1
        ELSE 0
    END) AS puntos_locales
  FROM partido p
  JOIN equipos_no_ciudad ec ON p.home_team_id = ec.equipo_id
  WHERE p.liga_id = 1
  GROUP BY ec.nombre
),

-- Obtengo la información de los equipos de ciudad en partidos de visita--
visitante_datos AS (
  SELECT
    ec.nombre AS equipo,
    COUNT(*) AS partidos_visitante,
    SUM(CASE
        WHEN p.full_time_result = 'A' THEN 3
        WHEN p.full_time_result = 'D' THEN 1
        ELSE 0
    END) AS puntos_visitante
  FROM partido p
  JOIN equipos_no_ciudad ec ON p.away_team_id = ec.equipo_id
  WHERE p.liga_id = 1
  GROUP BY ec.nombre
),

-- Se crea el resultado, incluyendo nombre del equipo, promedio de puntos por juego de local y visitante y la diferencia entre local y visitante--
resultados_equipo AS (
  SELECT
    l.equipo,
    ROUND(l.puntos_locales::decimal / l.partidos_local, 2) AS promedio_local,
    ROUND(v.puntos_visitante::decimal / v.partidos_visitante, 2) AS promedio_visitante,
    ROUND(
      (l.puntos_locales::decimal / l.partidos_local) -
      (v.puntos_visitante::decimal / v.partidos_visitante), 2
    ) AS diferencia
  FROM local_datos l
  JOIN visitante_datos v ON l.equipo = v.equipo
)

--Se imprime--
SELECT * FROM resultados_equipo
--Se une para sacar el promedio general de estos equipos--
UNION ALL
-- Se crea una consulta para los datos promedio de los equipos analizados--
SELECT
  'PROMEDIO GENERAL',
  ROUND(AVG(promedio_local), 2),
  ROUND(AVG(promedio_visitante), 2),
  ROUND(AVG(diferencia), 2)
FROM resultados_equipo;

------------------------------------------------------
-- CASO 4
WITH parts AS (
  SELECT 
    p.*, 
    e1.nombre AS home_team,
    e2.nombre AS away_team
  FROM partido p
  JOIN equipo e1 ON p.home_team_id = e1.id
  JOIN equipo e2 ON p.away_team_id = e2.id
),
partidos AS (
  SELECT 
    date,
    home_team AS team,
    away_team AS opponent,
    full_time_home_goals AS goals_for,
    full_time_away_goals AS goals_against,
    home_shots AS shots,
    home_shots_on_target AS shots_on_target,
    home_corners AS corners,
    CASE 
      WHEN full_time_result = 'H' THEN 1
      WHEN full_time_result = 'D' THEN 0.5
      ELSE 0
    END AS won,
    CASE 
      WHEN home_shots_on_target > away_shots_on_target AND home_corners > away_corners THEN 0.9  
      WHEN home_shots > away_shots THEN 0.8  
      WHEN home_shots_on_target > away_shots_on_target THEN 0.7  
      ELSE 0.5  
    END AS expected_win
  FROM parts

  UNION ALL

  SELECT 
    date,
    away_team AS team,
    home_team AS opponent,
    full_time_away_goals AS goals_for,
    full_time_home_goals AS goals_against,
    away_shots AS shots,
    away_shots_on_target AS shots_on_target,
    away_corners AS corners,
    CASE 
      WHEN full_time_result = 'A' THEN 1
      WHEN full_time_result = 'D' THEN 0.5
      ELSE 0
    END AS won,
    CASE 
      WHEN away_shots_on_target > home_shots_on_target AND away_corners > home_corners THEN 0.8  
      WHEN away_shots > home_shots THEN 0.7  
      WHEN away_shots_on_target > home_shots_on_target THEN 0.6  
      ELSE 0.0  
    END AS expected_win
  FROM parts
)

SELECT 
  team,
  COUNT(*) AS matches,
  ROUND(SUM(won), 2) AS real_points,
  ROUND(SUM(expected_win), 2) AS expected_points,
  ROUND(SUM(won) - SUM(expected_win), 2) AS overperformance
FROM partidos
GROUP BY team
ORDER BY overperformance DESC;

------------------------------------------------------
-- CASO 5
WITH partidos AS (
  SELECT 
    p.*, 
    e1.nombre AS home_team,
    e2.nombre AS away_team
  FROM partido p
  JOIN equipo e1 ON p.home_team_id = e1.id
  JOIN equipo e2 ON p.away_team_id = e2.id
)
SELECT 
	COALESCE(home_team, away_team) AS equipo,
	AVG(home_yellow) AS promedio_amarillas_local,
	AVG(away_yellow) AS promedio_amarillas_visitante,
    COALESCE(AVG(home_yellow), 0) + COALESCE(AVG(away_yellow), 0) AS total
FROM (
   	SELECT home_team, NULL AS away_team, home_yellow, NULL AS away_yellow
    FROM partidos
    UNION ALL
    SELECT NULL AS home_team, away_team, NULL AS home_yellow, away_yellow
    FROM partidos
) sub
GROUP BY equipo
ORDER BY total ASC;
