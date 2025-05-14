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
  
## Estructura de los Datos
- **Número de registros:** 23504 partidos.
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
Se definieron 5 objetivos principales:

Caso 1. **Expandir la muestra**  
- Comparar los siete equipos de Premier League (primera división) con mayor cantidad de puntos acumulados y diferencia de goles acumulada a partir del primer dato que se tiene registrado en nuestra base con los equipos que ganaron la liga en ese lapso.

Caso 2. **Ratings**
- Considerar si los equipos que mejor atacan y defienden son los que mejores resultados obtienen. Esto con el objetivo de ver si *los datos respaldan lo que el ojo ve*.

Caso 3. **Home Field Advantage** 
- Obtener el promedio de puntos por partido de local y de visitante, para ver si hay alguna diferencia entre ser local en una gran ciudad y no serlo.

Caso 4. **Expected Win**
- Hacer un análisis para comparar los equipos que "juegan bien" (basado en tiros, tiros a puerta y tiros de esquina) contra los equipos que realmente ganan.

Caso 5. **Impuesto de visita**  
- Considerar si los equipos que juegan de visita sufren de un "impuesto de visita", es decir, si son castigados con más tarjetas amarillas que los equipos locales.


## Consideraciones Éticas
1. **Evitar malinterpretaciones:** Se debe tener cuidado con la interpretación de los datos, especialmente en temas como favoritismo arbitral.
2. **Uso responsable:** La base de datos proviene de un analista de apuestas deportivas, pero el objetivo del proyecto es puramente investigativo.
3. **Respeto a los jugadores:** Aunque no se incluyan datos personales, debemos manejar la información con responsabilidad.
4. **Transparencia:** No modificar ni omitir información para vender una narrativa específica.

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
4. Elimina cualquier tabla existente llamada partido (si existe) y crea una nueva tabla con la siguiente estructura o `\i DescargarProyecto.sql` en la terminal:
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
   \copy partido("date", season, home_team, away_team, full_time_home_goals, full_time_away_goals, full_time_result, half_time_home_goals, half_time_away_goals, half_time_result, referee, home_shots, away_shots, home_shots_on_target, away_shots_on_target, home_fouls, away_fouls, home_corners, away_corners, home_yellow, away_yellow, home_red, away_red, display_order, league) FROM ruta_al_archivo_ENGLAND_CSV.csv WITH (FORMAT CSV, HEADER true, DELIMITER ',');
6. Repite pasos 4 y 5 pero cambiando 'partido' a 'partido2' y el archivo ENGLAND.CSV a ENGLAND2.CSV

**NOTA:**
En computadoras Windows, se le debe invertir las \ de la ruta por / y agregar comillas simples a la ruta

## Análisis Preliminar

### Exploración inicial

Para entender cómo se estructuraba nuestra base de datos, realizamos diferentes consultas y navegamos a través de los datos, identificando valores nulos, formatos inconsistentes y registros erróneos. Estas consultas están documentadas en el archivo `AnalisisPreliminar.sql`.

### Hallazgos

- **Nombres inconsistentes de equipos:** Algunos equipos aparecen registrados con nombres distintos en distintas temporadas (por ejemplo, "Ipswich" y "Ipswich Town").
- **Formato de nombres de árbitros:** Los árbitros antes de la temporada 2002/03 están escritos en un formato distinto, con nombres abreviados o inconsistentes.
- **Estadísticas nulas en partidos antiguos:** Los partidos anteriores al año 2000 no incluyen información estadística (goles, tiros, corners, etc.).
- **Partido cancelado:** Un partido registrado en la base tiene todos sus campos estadísticos nulos porque fue cancelado.
- **Temporada nula:** La championship no tiene árbitros registrados en la temporada 2012/13


## Limpieza de Datos
Correr `limpieza.sql` para limpiar lo siguiente que hicimos:

- **Unificación de tablas:** Se unieron las tablas `partido` y `partido2` en una sola tabla consolidada para aplicar limpieza de forma uniforme.
- **Unificación de nombres de equipos:** Se estandarizaron nombres distintos que representaban al mismo equipo, por ejemplo, "Manchester United" → "Man United".
- **Filtrado de temporadas antiguas:** Se eliminaron todos los partidos anteriores a la temporada **2002/03**, ya que no contenían información estadística confiable.
- **Eliminación de temporada específica:** Se eliminó la temporada **2012/13** de la **segunda división** (`league = 'English Second'`), ya que no tiene información suficiente para el análisis principal.
- **Normalización de árbitros:** Se transformaron los nombres de árbitros al formato `'N Apellido'` en lugar de `'Nombre Apellido'`, por ejemplo: `'Darren England'` → `'D England'`.
- **Limpieza de espacios:** Se eliminaron espacios en blanco al inicio o fin de los nombres de árbitros.
- **Eliminación de partido cancelado:** Se borró el registro de un partido que no fue disputado y contenía todos los valores nulos.
- **Restricciones de integridad:** Se aplicó `SET NOT NULL` a todas las columnas de la tabla `partido`, dado que ya se había limpiado toda la información incompleta.

## Normalizacion

Este proyecto contiene una base de datos de partidos de fútbol (Premier League y Championship), que ha sido **normalizada hasta la 4NF**, resultando en un modelo de **5 tablas** para mejorar eficiencia, escalabilidad y limpieza de datos.

---

#### Objetivo de la Normalización

- Evitar duplicación de nombres de equipos, árbitros, temporadas y ligas.
- Facilitar análisis estadístico por equipo, temporada o liga.
- Preparar la base para integración con modelos predictivos y visualizaciones.

---
#### Dependencias Funcionales

- **equipo**: `id → nombre`
- **arbitro**: `id → nombre`
- **liga**: `id → nombre`
- **temporada**: `id → temp`
- **partido**:
  - `id → home_team_id, away_team_id, arbitro_id, temporada_id, liga_id, estadísticas`
  - (Regla de unicidad): `(home_team_id, away_team_id, temporada_id, liga_id, date) → id`

#### Dependencias Multivaluadas

- No existen dependencias multivaluadas en el modelo actual.

---
#### Tablas del Modelo Final

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

--> Esta tabla contiene **una fila por partido** e incluye todas las estadísticas del equipo local y visitante.

---

##### 2. `equipo`

| Columna        | Tipo           | Descripción                    |
|----------------|----------------|--------------------------------|
| `id`           | `BIGSERIAL PK` | Identificador del equipo       |
| `nombre`| `VARCHAR`      | Nombre único del equipo        |

---

##### 3. `liga`

| Columna       | Tipo           | Descripción                   |
|---------------|----------------|-------------------------------|
| `id`          | `BIGSERIAL PK` | Identificador de la liga      |
| `nombre` | `VARCHAR`      | Nombre único de la liga       |

---

##### 4. `temporada`

| Columna         | Tipo           | Descripción                      |
|-----------------|----------------|----------------------------------|
| `id`  	  | `BIGSERIAL PK` | Identificador de la temporada    |
| `temp` | `VARCHAR`   | Ej. "2024/25", "2023/24"         |

---

##### 5. `arbitro`

| Columna         | Tipo           | Descripción                    |
|-----------------|----------------|--------------------------------|
| `id`    	  | `BIGSERIAL PK` | Identificador del árbitro      |
| `nombre`| `VARCHAR`      | Nombre limpio y único          |

---

#### Diagrama ERD

ERD: 
![Diagrama ER de base de datos (pata de gallo)](https://github.com/user-attachments/assets/60699ccf-e7b6-4e26-944a-cc0ebd1dee84)



## Análisis de datos: Caso 1

- **Descripción:** Se calcularon los **siete equipos con más puntos acumulados** y **mejor diferencia de goles** a lo largo de 23 temporadas de la Premier League, utilizando los datos disponibles desde el primer partido registrado en nuestra base de datos.
- **Objetivo:** El objetivo fue identificar si estos equipos, medidos por rendimiento sostenido, coinciden con los **equipos que realmente ganaron la liga** en ese periodo.  La comparación se realizó con los campeones oficiales: **Liverpool, Manchester City, Manchester United, Chelsea, Arsenal y Leicester City**, contrastando el rendimiento estadístico con los resultados históricos.
- **Consulta SQL:** La consulta se encuentra en el documento Analisis.sql en este repositorio. Se crearon tablas para registrar los puntos y la diferencia de goles obtenidos por cada equipo en cada partido, y posteriormente se ejecutó una consulta para obtener los siete equipos con la mayor cantidad de puntos y diferencia de goles acumulada.
- **Resultados:** ![output (1)](https://github.com/user-attachments/assets/b7e1b808-487d-49b3-ba82-668474a4488d)

- **Por títulos**, los siete equipos que líderan son:
  *Manchester United (13 títulos), Manchester City (8), Chelsea (5), Arsenal (3), Liverpool (2) y Leicester City/Blackburn Rovers (1)*.
- **Por puntos**, los siete equipos con mejor rendimiento fueron:  
  *Manchester United (1702 puntos), Chelsea (1684), Arsenal (1662), Liverpool (1638), Manchester City (1621), Tottenham (1421) y Everton (1207)*.
- **Por diferencia de goles**, el ranking fue liderado por:  
  *Manchester City (+788), Chelsea (+750), Arsenal (+746), Liverpool (+740), Manchester United (+701), Tottenham (+354) y Everton (+24)*.
- **Analisis según los datos acumulados:** Este análisis muestra que, si bien algunos equipos como **Tottenham** y **Everton** se mantienen regularmente competitivos, no lograron coronarse campeones, mientras que equipos como **Blackburn** o **Leicester** fueron campeones en una única ocasión sin figurar entre los de mejor rendimiento acumulado.  
La conclusión es que el **rendimiento sostenido a lo largo del tiempo no siempre se traduce en títulos**, aunque sí refleja consistencia en la élite del fútbol inglés.

## Análisis de datos: Caso 2

- **Descripción:** Se calcularon **ratings ofensivos y defensivos** por equipo utilizando datos cómo tiros, tiros a puerta y corners.
- **Objetivo:** El objetivo fue ver si aquellos equipos que esperarías sean quienes mejor juegan son los que mejor atacan y los que mejor defienden, es decir, si **los datos respaldan lo que el ojo ve.**
- **Consulta SQL:** La consulta se encuentra en el documento Analisis.sql, en este se define un indice dónde se le asigna diferentes pesos a diferentes acciones y se calcula un valor de que tan bien defiende y ataca un equipo.
- **Resultados:** ![download](https://github.com/user-attachments/assets/57d8d1b6-d79d-452c-baf3-38f628fef1a4)
- **Analisis:** Aunque en general, los equipos están bastante parejos, encontrandose la gran mayoría en la misma área de la gráfica, si destacan algunos de los equipos que en el caso anterior vimos que se diferencian del resto, por lo tanto, podemos determinar que efectivamente **aquellos equipos que en percepción mejor juegan, se observan igualmente con datos entre los mejores**.

## Análisis de datos: Caso 3

- **Descripción:** Creamos tablas dónde se obtiene el **promedio de puntos por partido de local y de visitante**, además de la diferencia de estas. Separamos estos datos entre 2 bloques, equipos de ciudades grandes de Inglaterra (Londres, Manchester y Liverpool) y el resto de equipos **actualmente en la primera división iglesa**.
- **Objetivo:** Analizar si hay alguna diferencia entre ser Local en una gran ciudad y no serlo, para ver si se puede **explicar porqué 11 de 20 equipos de la competición se dividen en solo 3 ciudades**.
- **Consulta SQL:** Las consultas se encuentran en el archivo Analisis.sql, en estas consultas lo que se hace es obtener los datos tanto de local cómo de visitante de cierto grupo de equipos y regresa una tabla que incluye los nombres de los equipos y sus respectivos puntos en casa, de visita y la diferencia.
- **Resultados:** ![output (3)](https://github.com/user-attachments/assets/23c5d8d7-4fde-454e-bf39-6c063e70dbd7) ![final_visualizacion_puntos_tabla](https://github.com/user-attachments/assets/c607090c-597e-4386-8308-c8ed7f7367cf)
- **Analisis:** Se observa una **mejor diferencia de puntos y promedio de local en los equipos de ciudad respecto a el resto de la liga**, pero se debe considerar que los llamados "Big Six" se encuentran en este grupo, por lo cual es posible que tengan mejores resultados por jugar en una ciudad grande o simplemente porque son mejores, por lo cual, **se encontró evidencia de que aquellos equipos que juegan en estas ciudades si obtienen mejores resultados en general**, más **no estamos seguros si la zona en la que juegan es el causante de este resultado**.
- **Casos anomalos:** Algunos resultados que resaltan son el del **Ipswich**, pues es el único con diferencia negativa, consideramos que esto se debe a que solo llevan 1 temporada en premier, por lo que el resultado es algo impreciso. En cuanto al **Newcastle**, aunque no se encuentra en una ciudad, se encuentra muy alejado al norte del país y cuenta con el estadio más grande fuera de los equipos de ciudades grandes, por lo cual hace sentido que sus numeros sean más similares a estos equipos que con los de su grupo. Finalmente, el **Crystal Palace**, está en un caso similar pero invertdo al newcastle, pues al contar con un estadio pequeño y alejado de los centros turisticos de londres, se puede explicar que sus numeros sean más similares a los del resto de equipos que con los equipos de ciudad grande. 

## Análisis de datos: Caso 4

- **Descripción:** Se calcula la **diferencia entre las victorias REALES obtenidas y las victorias ESPERADAS** calculadas mediante el uso de datos como tiros, tiros a puerta y corners.
- **Objetivo:** El objetivo es revelar si hay equipos que **obtenido resultados que superan lo que deberían haber conseguido**.
- **Consulta SQL:** La consulta se encuentra en el documento Analisis.sql, en este se define un indice dónde se le calcula mediante comparación entre local y visitante quien "jugo mejor".
- **Resultados:** ![download](https://github.com/user-attachments/assets/e18f5c40-8a9d-40ce-808a-4aab16716cf7)
- **Analisis:** Aqui podemos explicar muchos resultados de casos anteriores, por ejemplo, vemos que el mayor favorecido ha sido el Manchester United, explicando cómo a pesar de no tener tanta ventaja en puntos totales históricos, tiene 5 titulos más que el segundo lugar.

## Análisis de datos: caso 5
- **Descripción:** Se calcula el promedio de tarjetas amarillas recibidas por cada equipo, separando su comportamiento como local y como visitante. El análisis permite comparar si los equipos son más o menos sancionados según su condición de juego.
- **Objetivo:** Identificar si existen equipos con un estilo de juego más agresivo o que reciben más sanciones dependiendo de si juegan en casa o fuera. También se pueden observar posibles desequilibrios arbitrales o estrategias defensivas intensas.
- **Consulta SQL:** La consulta se encuentra en el archivo Analisis.sql, en esta se define el promedio de amarillas del local y visitante para compararlas posteriormente.
- **Resultados:**![image](https://github.com/user-attachments/assets/6734b8c5-d79b-45f2-9008-1e8bfc9e7d59)
- **Análisis:** Equipos como Portsmouth, Sunderland y MK Dons son los que más tarjetas amarillas acumulan en total (local + visitante), lo que podría reflejar un estilo de juego físico o de alta presión. Crewe, Colchester y Doncaster son los equipos más disciplinados en promedio, con menos de 1 tarjeta amarilla por partido en ambos contextos. Algunos equipos presentan diferencias notables entre su comportamiento como local y visitante, como Scunthorpe o Peterboro, lo cual puede estar relacionado con factores como el entorno, el árbitro o la estrategia empleada. Pero en general, todos los equipos tienen tarjetas amarillas cuando son visitantes, esto podría representar algún sesgo en el campo propio ya sea por la afición, el arbitro o el juego más agresivo. 



