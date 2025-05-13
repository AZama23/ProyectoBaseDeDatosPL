/* Todos los equipos y cuantos partidos han jugado
CHECAR BRIGHTON Y IPSWICH*/ 
WITH locales AS (
	SELECT DISTINCT home_team AS equipos, COUNT(*) AS locales
	FROM partido
	GROUP BY home_team)
SELECT DISTINCT locales.equipos, locales.locales, COUNT(*) AS visitantes
FROM partido, locales
WHERE equipos = away_team
GROUP BY locales.equipos, locales.locales, away_team;

/* Todos los arbitros */
SELECT DISTINCT referee
FROM partido;

/*Primera fecha */
SELECT "date", season
FROM partido
ORDER BY "date"
LIMIT 1;

/*Ultima fecha */
SELECT "date", season
FROM partido
ORDER BY "date" DESC
LIMIT 1;

/*Primera fecha sin nulls*/
WITH sin_nulls AS(
	SELECT * 
	FROM partido
	WHERE home_shots IS NOT NULL
		AND away_shots IS NOT NULL)
SELECT "date", season
FROM sin_nulls
ORDER BY "date" ASC
LIMIT 1;

/*Promedio de goles por temporada de local y de visitante */
SELECT season, AVG(full_time_home_goals) AS goles_prom_local, AVG(full_time_away_goals) AS goles_prom_visitante
FROM partido
GROUP BY season
ORDER BY season DESC;

/*Más faltas pierde el partido*/
SELECT home_fouls, away_fouls, full_time_result, CASE
	WHEN full_time_result='D' then 'No aplica'
	WHEN home_fouls=away_fouls then 'No aplica'
	WHEN home_fouls>away_fouls AND full_time_result='H' then 'No'
	WHEN home_fouls>away_fouls AND full_time_result='A' then 'Sí'
	WHEN home_fouls<away_fouls AND full_time_result='H' then 'Sí'
	WHEN home_fouls<away_fouls AND full_time_result='A' then 'No'
	END AS resultado
FROM partido;

/*Porcentaje de partidos ganados contra una roja*/
WITH partidos_con_roja AS(
	SELECT home_red, away_red, full_time_result
	FROM partido
	WHERE home_red>0 OR away_red>0),
resultados AS (
	SELECT home_red, away_red, full_time_result, 
		CASE
		WHEN home_red<away_red AND full_time_result='H' then 1
		WHEN home_red>away_red AND full_time_result='A' then 1
		ELSE 0
		END AS resultado
	FROM partidos_con_roja),
sumas AS (
SELECT SUM(resultado) AS suma, COUNT(resultado) AS cuenta
FROM resultados)
SELECT (suma*1.0)/cuenta *100 AS porcentaje
FROM sumas;

