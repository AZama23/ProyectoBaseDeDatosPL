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
- **Categóricos:** `Season`, `League`, `HomeTeam`, `AwayTeam`, `FT Result`, `HT Result`, `Referee`
- **Temporales:** `Date`, `Display_Order` 

## Objetivo del Proyecto
Se definieron 3 objetivos principales:

Caso 1. **Expandir la muestra**  
   Comparar los siete equipos de Premier League (primera división) con mayor cantidad de puntos acumulados y diferencia de goles acumulada a partir del primer dato que se tiene registrado en nuestra base (ya limpia y normalizada) con los equipos que ganaron la liga en ese lapso (Liverpool, Man City, Man Utd, Chelsea, Arsenal y Leicester).

Caso 2. **El árbitro también juega**  
   Observar patrones entre los árbitros con mayor y menor número de tarjetas y ver qué resultados se obtienen.

Caso 3. **Ciudad vs Campo**  
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

2. Colocar los archivos ENGLAND CSV.CSV y ENGLAND 2 CSV.CSV en un lugar accesible en tu sistema. Cambia sus nombres en tu sistema para que no tengan espacios.

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
6. Repite pasos 4 y 5 pero cambiando 'partido' a 'partido2' y el archivo ENGLAND.CSV a ENGLAND2.CSV

**NOTA:**
En computadoras Windows, se le debe invertir las \ de la ruta por / y agregar comillas simples a la ruta

##Análisis preliminar (Entrega.sql)

## Limpieza de Datos

- **Descripción:** Hicimos una limpieza inicial a los datos, la query de SQL de esta limpieza se encuentra en el repositorio bajo el nombre "limpieza.sql"
- **Objetivo:** Permitir que los datos sean legibles y manipulables dentro de la base sin perdidas de información.
- **Cambios Realizados:** Para esta limpieza inicial se identificaron casos de equipos y arbitros cuyo nombre causaba problemas, editamos los datos de forma de que la información quede estandarizada.
- **Disclaimer:** Esta Limpieza inicial tiene cómo objetivo dejar la base lista para trabajar, para ciertos usos de la base puede requerir una limpieza especifica para la funcionalidad requerida.

## Normalizacion
### ⚽ Base de Datos de Partidos de Fútbol – Esquema Normalizado (5 Tablas)

Este proyecto contiene una base de datos de partidos de fútbol (Premier League y Championship), que ha sido **normalizada hasta la 4NF**, resultando en un modelo de **5 tablas** para mejorar eficiencia, escalabilidad y limpieza de datos.

---

#### ✅ Objetivo de la Normalización

- Evitar duplicación de nombres de equipos, árbitros, temporadas y ligas.
- Facilitar análisis estadístico por equipo, temporada o liga.
- Preparar la base para integración con modelos predictivos y visualizaciones.

---

#### 🧱 Tablas del Modelo Final

##### 1. `partido`

Tabla principal con los datos de cada partido, incluyendo estadísticas completas y relaciones con otras entidades.

| Columna              | Tipo        | Descripción                            |
|----------------------|-------------|----------------------------------------|
| `id`       	       | `BIGSERIAL PK` | Identificador único del partido        |
| `fecha`              | `TIMESTAMP` | Fecha del partido                      |
| `home_team_id`       | `INT FK`    | Relación con equipo local              |
| `away_team_id`       | `INT FK`    | Relación con equipo visitante          |
| `liga_id`            | `INT FK`    | Relación con la liga                   |
| `temporada_id`       | `INT FK`    | Relación con la temporada              |
| `arbitro_id`         | `INT FK`    | Relación con el árbitro                |
| `full_time_home_goals`     | `SMALLINT` | Goles local                      |
| `full_time_away_goals`     | `SMALLINT` | Goles visitante                  |
| `full_time_result`         | `VARCHAR`  | Resultado final ('H', 'A', 'D')  |
| `half_time_home_goals`     | `SMALLINT` | Goles al descanso (local)        |
| `half_time_away_goals`     | `SMALLINT` | Goles al descanso (visitante)    |
| `half_time_result`         | `VARCHAR`  | Resultado al descanso            |
| `home_shots`, `away_shots` | `SMALLINT` | Tiros totales por equipo         |
| `home_shots_on_target`, `away_shots_on_target` | `SMALLINT` | Tiros al arco |
| `home_fouls`, `away_fouls` | `SMALLINT` | Faltas cometidas                 |
| `home_corners`, `away_corners` | `SMALLINT` | Tiros de esquina              |
| `home_yellow`, `away_yellow` | `SMALLINT` | Tarjetas amarillas             |
| `home_red`, `away_red` | `SMALLINT` | Tarjetas rojas                      |
| `display_order`      | `BIGINT`    | Orden visual del partido              |

> ⚠️ Esta tabla contiene **una fila por partido** e incluye todas las estadísticas del equipo local y visitante.

---

##### 2. `equipo`

| Columna        | Tipo           | Descripción                    |
|----------------|----------------|--------------------------------|
| `id`           | `BIGSERIAL PK` | Identificador del equipo       |
| `nombre_equipo`| `VARCHAR`      | Nombre único del equipo        |

---

##### 3. `liga`

| Columna       | Tipo           | Descripción                   |
|---------------|----------------|-------------------------------|
| `id`          | `BIGSERIAL PK` | Identificador de la liga      |
| `nombre_liga` | `VARCHAR`      | Nombre único de la liga       |

---

##### 4. `temporada`

| Columna         | Tipo           | Descripción                      |
|-----------------|----------------|----------------------------------|
| `id`  	  | `BIGSERIAL PK` | Identificador de la temporada    |
| `nombre_temporada` | `VARCHAR`   | Ej. "2024/25", "2023/24"         |

---

##### 5. `arbitro`

| Columna         | Tipo           | Descripción                    |
|-----------------|----------------|--------------------------------|
| `id`    	  | `BIGSERIAL PK` | Identificador del árbitro      |
| `nombre_arbitro`| `VARCHAR`      | Nombre limpio y único          |

---

#### 🖼️ Diagrama ER

Puedes insertar tu imagen del diagrama ER aquí (ajusta la ruta):





## Análisis de datos: Caso 1

- **Descripción:** Se calcularon los **siete equipos con más puntos acumulados** y **mejor diferencia de goles** a lo largo de 23 temporadas de la Premier League, utilizando los datos disponibles desde el primer partido registrado en nuestra base de datos.
- **Objetivo:** El objetivo fue identificar si estos equipos, medidos por rendimiento sostenido, coinciden con los **equipos que realmente ganaron la liga** en ese periodo.  La comparación se realizó con los campeones oficiales: **Liverpool, Manchester City, Manchester United, Chelsea, Arsenal y Leicester City**, contrastando el rendimiento estadístico con los resultados históricos.
- **Consulta SQL:** La consulta se encuentra en el documento Caso 1.sql en este repositorio. Se crearon tablas para registrar los puntos y la diferencia de goles obtenidos por cada equipo en cada partido, y posteriormente se ejecutó una consulta para obtener los siete equipos con la mayor cantidad de puntos y diferencia de goles acumulada.
- **Resultados:**![PHOTO-2025-05-12-09-25-24](https://github.com/user-attachments/assets/d8562ce9-ce0f-4512-bf51-3354b94ac5da) ![PHOTO-2025-05-12-09-25-10](https://github.com/user-attachments/assets/61a562b1-0e50-4c6b-80d3-4280636fd5cb) ![PHOTO-2025-05-12-09-24-50](https://github.com/user-attachments/assets/b632b8bc-0fdc-49af-b24c-d463520e6f1f)
- **Analisis:** Según los datos acumulados:
- **Por títulos**, los siete equipos que líderan son:
  *Manchester United (13 títulos), Manchester City (8), Chelsea (5), Arsenal (3), Liverpool (2) y Leicester City/Blackburn Rovers (1)*.
- **Por puntos**, los siete equipos con mejor rendimiento fueron:  
  *Manchester United (1702 puntos), Chelsea (1684), Arsenal (1662), Liverpool (1638), Manchester City (1621), Tottenham (1421) y Everton (1207)*.
- **Por diferencia de goles**, el ranking fue liderado por:  
  *Manchester City (+788), Chelsea (+750), Arsenal (+746), Liverpool (+740), Manchester United (+701), Tottenham (+354) y Everton (+24)*.
Este análisis muestra que, si bien algunos equipos como **Tottenham** y **Everton** se mantienen regularmente competitivos, no lograron coronarse campeones, mientras que equipos como **Blackburn** o **Leicester** fueron campeones en una única ocasión sin figurar entre los de mejor rendimiento acumulado.  
La conclusión es que el **rendimiento sostenido a lo largo del tiempo no siempre se traduce en títulos**, aunque sí refleja consistencia en la élite del fútbol inglés.

## Análisis de datos: Caso 3

- **Descripción:** Creamos tablas dónde se obtiene el **promedio de puntos por partido de local y de visitante**, además de la diferencia de estas. Separamos estos datos entre 2 bloques, equipos de ciudades grandes de Inglaterra (Londres, Manchester y Liverpool) y el resto de equipos **actualmente en la primera división iglesa**.
- **Objetivo:** Analizar si hay alguna diferencia entre ser Local en una gran ciudad y no serlo, para ver si se puede **explicar porqué 11 de 20 equipos de la competición se dividen en solo 3 ciudades**.
- **Consulta SQL:** La primer consulta se encuentra en el documento **Caso3Ciudad.sql** en este repositorio, este incluye la consulta de los 11 equipos en grandes ciudades de londres. La segunda consulta se encuentra en el documento **Caso3NoCiudad.sql** en este repositorio, este incluye la consulta del resto de equipos.
- **Resultados:** ![tabla_ciudad_colores](https://github.com/user-attachments/assets/055187ac-b7c8-40fc-a874-93c7fd566a21) ![tabla_nociudad_colores](https://github.com/user-attachments/assets/4bfc1335-47e6-497d-b374-0fc3e24ade09) ![grafica_zama_combinada_final (1)](https://github.com/user-attachments/assets/b46cd346-da8e-45be-9c3a-84ccfe38ea5c) ![graficas_ciudad_vs_nociudad_horizontal](https://github.com/user-attachments/assets/73cdeab9-ade0-40ac-947a-30ebbc571d48) ![tabla_estadios_premier_2024_25_colores_completa](https://github.com/user-attachments/assets/02664c45-3cf1-42b9-99cc-105b360a9558)
- **Analisis:** Se observa una **mejor diferencia de puntos y promedio de local en los equipos de ciudad respecto a el resto de la liga**, pero se debe considerar que los llamados "Big Six" se encuentran en este grupo, por lo cual es posible que tengan mejores resultados por jugar en una ciudad grande o simplemente porque son mejores, por lo cual se encontró evidencia de que aquellos equipos que juegan en estas ciudades si obtienen mejores resultados en general, más no estamos seguros si la zona en la que juegan es el causante de este resultado.
- - **Casos anomalos:** Algunos resultados que resaltan son el del **Ipswich**, pues es el único con diferencia negativa, consideramos que esto se debe a que solo llevan 1 temporada en premier, por lo que el resultado es algo impreciso. En cuanto al **Newcastle**, aunque no se encuentra en una ciudad, se encuentra muy alejado al norte del país y cuenta con el estadio más grande fuera de los equipos de ciudades grandes, por lo cual hace sentido que sus numeros sean más similares a estos equipos que con los de su grupo. Finalmente, el **Crystal Palace**, está en un caso similar pero invertdo al newcastle, pues al contar con un estadio pequeño y alejado de los centros turisticos de londres, se puede explicar que sus numeros sean más similares a los del resto de equipos que con los equipos de ciudad grande. 






