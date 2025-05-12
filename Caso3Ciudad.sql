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
-- Se crea una consulta para los datos promedio de los equipos analizados--
SELECT
  'PROMEDIO GENERAL',
  ROUND(AVG(promedio_local), 2),
  ROUND(AVG(promedio_visitante), 2),
  ROUND(AVG(diferencia), 2)
FROM resultados_equipo;
