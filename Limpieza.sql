-- ipswich
update partido set home_team = 'Ipswich' where home_team = 'Ipswich Town';
update partido set away_team = 'Ipswich' where away_team = 'Ipswich Town';

-- brighton
update partido set home_team = 'Brighton' where home_team = 'Brighton & Hove Albion';
update partido set away_team = 'Brighton' where away_team = 'Brighton & Hove Albion';

-- árbitros
DELETE FROM partido
WHERE "date" < '2002-08-15';
DELETE FROM partido
WHERE season = '2012/13' and league='English Second';

UPDATE partido
SET referee = TRIM(REPLACE(REPLACE(referee, CHR(160), ''), CHR(9), ''));
UPDATE partido 
SET referee = INITCAP(TRIM(REPLACE(REPLACE(referee, CHR(160), ''), CHR(9), '')));

UPDATE partido SET referee = 'D England' WHERE referee = 'Darren England';
UPDATE partido SET referee = 'A Madley' WHERE referee = 'Andy Madley';
UPDATE partido SET referee = 'S Bennett' WHERE referee = 'St Bennett';
UPDATE partido SET referee = 'G Barber' WHERE referee = 'Graham Barber';
UPDATE partido SET referee = 'M Atkinson' WHERE referee = 'Mn Atkinson';
UPDATE partido SET referee = 'J Brooks' WHERE referee = 'J jBrooks';
UPDATE partido SET referee = 'J Brooks' WHERE referee = 'J JBrooks';
UPDATE partido SET referee = 'A Marriner' WHERE referee = 'A Mariner';
UPDATE partido SET referee = 'A Woolmer' WHERE referee = 'A Wolmer';
UPDATE partido SET referee = 'D Gallagher' WHERE referee = 'D Gallagh';
UPDATE partido SET referee = 'D Gallagher' WHERE referee = 'D Gallaghe';
UPDATE partido SET referee = 'G Salisbury' WHERE referee = 'G Sailsbury';
UPDATE partido SET referee = 'J Linington' WHERE referee = 'J Linnington';
UPDATE partido SET referee = 'J Gillett' WHERE referee = 'Jj Gillett';
UPDATE partido SET referee = 'M Heywood' WHERE referee = 'M Haywood';
UPDATE partido SET referee = 'P Tierney' WHERE referee = 'P Teirney';
UPDATE partido SET referee = 'R Olivier' WHERE referee = 'R Oliver';
UPDATE partido SET referee = 'S Attwell' WHERE referee = 'S Atwell';

--Partido no jugado
DELETE FROM partido
WHERE home_team='Bolton' AND away_team='Brentford' AND "date"='2019-04-27';


-- SET NOT NULL cada columna
ALTER TABLE partido ALTER COLUMN "date" SET NOT NULL;
ALTER TABLE partido ALTER COLUMN season SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_team SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_team SET NOT NULL;
ALTER TABLE partido ALTER COLUMN full_time_home_goals SET NOT NULL;
ALTER TABLE partido ALTER COLUMN full_time_away_goals SET NOT NULL;
ALTER TABLE partido ALTER COLUMN full_time_result SET NOT NULL;
ALTER TABLE partido ALTER COLUMN half_time_home_goals SET NOT NULL;
ALTER TABLE partido ALTER COLUMN half_time_away_goals SET NOT NULL;
ALTER TABLE partido ALTER COLUMN half_time_result SET NOT NULL;
ALTER TABLE partido ALTER COLUMN referee SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_shots SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_shots SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_shots_on_target SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_shots_on_target SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_fouls SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_fouls SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_corners SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_corners SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_yellow SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_yellow SET NOT NULL;
ALTER TABLE partido ALTER COLUMN home_red SET NOT NULL;
ALTER TABLE partido ALTER COLUMN away_red SET NOT NULL;
ALTER TABLE partido ALTER COLUMN display_order SET NOT NULL;
ALTER TABLE partido ALTER COLUMN league SET NOT NULL;
