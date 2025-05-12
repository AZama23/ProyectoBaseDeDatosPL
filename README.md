# Proyecto Semestral - Bases de Datos

## Integrantes
- Tomás Boom Sánchez
- Elie Joseph Fayad El Haddad
- Lucas García Arredondo
- Elías Kably Mizrahi
- Diego Alonso Zamanillo Bárcena

## Descripción General
El set de datos elegido incluye los registros de todos los partidos jugados en la primera y segunda división inglesa desde la fundación de la Premier League (1993). En este set se incluyen los goles anotados tanto por el equipo local como el visitante, además de otra variedad de datos que varían desde el árbitro que ofició el partido hasta el número de corners ejecutados por equipo.

## Fuente de Datos
- Los datos fueron cargados a la plataforma de Kaggle por el usuario *Michael Panagopoulos*, quien da crédito a un analista de apuestas deportivas llamado *Joseph Buchdahl* como el autor de esta información.
- Enlace a la base de datos: [Kaggle Dataset](https://www.kaggle.com/datasets/panaaaaa/english-premier-league-and-championship-full-dataset)
- Última actualización: hace 8 días, con datos hasta el 16 de enero de este año.
  
## Contacto
- **Joseph Buchdahl**
  - X: [@12Xpert](https://x.com/12Xpert)
  - Web: [12xpert.co.uk](http://12xpert.co.uk/)


## Estructura de los Datos
- **Número de registros:** 12,154 partidos.
- **Número de atributos:** 25 columnas.
- **Principales atributos:**
  - `Date`: Fecha en la que se jugó el partido.
  - `Season`: Temporada en la que se jugó el partido.
  - `HomeTeam` / `AwayTeam`: Equipos local y visitante.
  - `FTH Goals` / `FTA Goals`: Goles finales del local y visitante.
  - `FT Result`: Resultado final del partido.
  - `HTH Goals` / `HTA Goals`: Goles del local y visitante al medio tiempo.
  - `HT Result`: Resultado al medio tiempo.
  - `Referee`: Árbitro que ofició el partido.
  - `H Shots` / `A Shots`: Tiros totales del local y visitante.
  - `H SOT` / `A SOT`: Tiros a puerta del local y visitante.
  - `H Fouls` / `A Fouls`: Faltas cometidas por el local y visitante.
  - `H Corners` / `A Corners`: Corners ejecutados por cada equipo.
  - `H Yellow` / `A Yellow`: Tarjetas amarillas recibidas por cada equipo.
  - `H Red` / `A Red`: Tarjetas rojas recibidas por cada equipo.
  - `Display_Order`: Orden numérico de los partidos.
  - `League`: Liga en la que se jugó el partido.

## Tipos de Datos
- **Numéricos:**
  - Goles (`FTH Goals`, `FTA Goals`, `HTH Goals`, `HTA Goals`)
  - Tiros (`H Shots`, `A Shots`, `H SOT`, `A SOT`)
  - Faltas y tarjetas (`H Fouls`, `A Fouls`, `H Yellow`, `A Yellow`, `H Red`, `A Red`)
- **Categóricos:** `Season`, `League`
- **Texto:** `HomeTeam`, `AwayTeam`, `FT Result`, `HT Result`, `Referee`
- **Temporales:** `Date`, `Display_Order` 

## Objetivo del Proyecto
Se definieron 3 objetivos principales:

1. **Expandir la muestra**  
   Comparar los siete equipos de Premier League (primera división) con mayor cantidad de puntos acumulados y diferencia de goles acumulada a partir del primer dato que se tiene registrado en nuestra base (ya limpia y normalizada) con los equipos que ganaron la liga en ese lapso (Liverpool, Man City, Man Utd, Chelsea, Arsenal y Leicester).

2. **El árbitro también juega**  
   Observar patrones entre los árbitros con mayor y menor número de tarjetas y ver qué resultados se obtienen.

3. **Ciudad vs Campo**  
   Ver la diferencia de puntos obtenidos por los equipos de Londres, Manchester y Liverpool, vs aquellos de ciudades más pequeñas.


## Consideraciones Éticas
1. **Evitar malinterpretaciones:** Se debe tener cuidado con la interpretación de los datos, especialmente en temas como favoritismo arbitral.
2. **Uso responsable:** La base de datos proviene de un analista de apuestas deportivas, pero el objetivo del proyecto es puramente investigativo.
3. **Respeto a los jugadores:** Aunque no se incluyan datos personales, debemos manejar la información con responsabilidad.
4. **Transparencia:** No modificar ni omitir información para vender una narrativa específica.

## Documento Original
El documento original del README se encuentra disponible en el siguiente enlace:
[Google Docs](https://docs.google.com/document/d/1ocWNt2jsjXCbEbQaHWimSCtk3GeR59I2_Rm1JIsG5bA/edit?usp=sharing)

# Guía para Descargar y Cargar la Base de Datos

## Cómo descargar la base de datos

1. Descargar la base de datos desde el siguiente enlace de Kaggle:  
   [Kaggle Dataset: English Premier League and Championship Full Dataset](https://www.kaggle.com/datasets/panaaaaa/english-premier-league-and-championship-full-dataset)

2. Colocar el archivo CSV en un lugar accesible en tu sistema.

## Instrucciones para cargar la base de datos en PostgreSQL

1. Abre la terminal y conéctate a PostgreSQL usando tu clave.

2. Crea una nueva base de datos:
   ```sql
   CREATE DATABASE *nombre*;
3. Conectarse a la base de datos recién creada:
   '\c nombre'
4. Elimina cualquier tabla existente llamada partido (si existe) y crea una nueva tabla con la siguiente estructura:
   ```sql
   DROP TABLE IF EXISTS partido;
	SET DateStyle TO 'European';
	CREATE TABLE partido (
  	"date" TIMESTAMP NOT NULL,
  	season VARCHAR(30) NOT NULL,
  	home_team VARCHAR(30) NOT NULL,
  	away_team VARCHAR(30) NOT NULL,
  	full_time_home_goals SMALLINT NOT NULL,
  	full_time_away_goals SMALLINT NOT NULL,
  	full_time_result VARCHAR(10) NOT NULL,
  	half_time_home_goals SMALLINT,
  	half_time_away_goals SMALLINT,
  	half_time_result VARCHAR(10),
  	referee VARCHAR(50),
  	home_shots SMALLINT,
  	away_shots SMALLINT,
  	home_shots_on_target SMALLINT,
  	away_shots_on_target SMALLINT,
  	home_fouls SMALLINT,
  	away_fouls SMALLINT,
  	home_corners SMALLINT,
  	away_corners SMALLINT,
  	home_yellow SMALLINT,
  	away_yellow SMALLINT,
  	home_red SMALLINT,
  	away_red SMALLINT,
  	display_order BIGINT NOT NULL,
  	league VARCHAR(30) NOT NULL
	);
5. Una vez creada la tabla, importa los datos del archivo CSV en la tabla partido con el siguiente comando:
   ```sql
   \copy partido("date", season, home_team, away_team, full_time_home_goals, full_time_away_goals, full_time_result, half_time_home_goals, half_time_away_goals, half_time_result, referee, 	home_shots, away_shots, home_shots_on_target, away_shots_on_target, home_fouls, away_fouls, home_corners, away_corners, home_yellow, away_yellow, home_red, away_red, display_order, 		league) 
	FROM ruta_al_archivo.csv 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',');

**NOTA:**
En computadoras Windows, se le debe invertir las \ de la ruta por / y agregar comillas simples a la ruta

## Limpieza de Datos

- **Descripción:** Hicimos una limpieza inicial a los datos, la query de SQL de esta limpieza se encuentra en el repositorio bajo el nombre "limpieza.sql"
- **Objetivo:** Permitir que los datos sean legibles y manipulables dentro de la base sin perdidas de información.
- **Cambios Realizados:** Para esta limpieza inicial se identificaron casos de equipos y arbitros cuyo nombre causaba problemas, editamos los datos de forma de que la información quede estandarizada.
- **Disclaimer:** Esta Limpieza inicial tiene cómo objetivo dejar la base lista para trabajar, para ciertos usos de la base puede requerir una limpieza especifica para la funcionalidad requerida.
