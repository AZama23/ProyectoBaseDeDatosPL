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
Todavía no se ha definido un objetivo específico, pero algunas ideas incluyen:
- Explicar conductas seguidas por equipos que posteriormente fueron exitosos.
- Analizar la influencia de factores como el árbitro o el recorrido hasta el partido.
- Comparar casos específicos contra el promedio histórico para identificar tendencias.

## Consideraciones Éticas
1. **Evitar malinterpretaciones:** Se debe tener cuidado con la interpretación de los datos, especialmente en temas como favoritismo arbitral.
2. **Uso responsable:** La base de datos proviene de un analista de apuestas deportivas, pero el objetivo del proyecto es puramente investigativo.
3. **Respeto a los jugadores:** Aunque no se incluyan datos personales, debemos manejar la información con responsabilidad.
4. **Transparencia:** No modificar ni omitir información para vender una narrativa específica.

## Documento Original
El documento original del README se encuentra disponible en el siguiente enlace:
[Google Docs](https://docs.google.com/document/d/1ocWNt2jsjXCbEbQaHWimSCtk3GeR59I2_Rm1JIsG5bA/edit?usp=sharing)
