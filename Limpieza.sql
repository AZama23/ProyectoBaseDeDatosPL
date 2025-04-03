create table partido_backup as table partido;

update partido
set
  season = lower(trim(replace(replace(season, '.', ''), ',', ''))),
  home_team = trim(replace(replace(home_team, '.', ''), ',', '')),
  away_team = trim(replace(replace(away_team, '.', ''), ',', '')),
  full_time_result = lower(trim(replace(replace(full_time_result, '.', ''), ',', ''))),
  half_time_result = lower(trim(replace(replace(half_time_result, '.', ''), ',', ''))),
  referee = lower(trim(replace(replace(referee, '.', ''), ',', ''))),
  league = lower(trim(replace(replace(league, '.', ''), ',', '')));

-- manchester united
update partido set home_team = 'Manchester United' where home_team in ('Man Utd', 'manchester utd');
update partido set away_team = 'Manchester United' where away_team in ('Man Utd', 'manchester utd');

-- manchester city
update partido set home_team = 'Manchester City' where home_team in ('Man City', 'manchester c');
update partido set away_team = 'Manchester City' where away_team in ('Man City', 'manchester c');

-- ipswich
update partido set home_team = 'Ipswich' where home_team = 'Ipswich Town';
update partido set away_team = 'Ipswich' where home_team = 'Ipswich Town';

-- brighton
update partido set home_team = 'Brighton' where home_team = 'Brighton & Hove Albion';
update partido set away_team = 'Brighton' where home_team = 'Brighton & Hove Albion';

-- árbitros
update partido set referee = 'martin dean' where referee = 'm dean';
update partido set referee = 'martin atkinson' where referee = 'm atkinson';
update partido set referee = 'andre marriner' where referee = 'a marriner';
update partido set referee = 'anthony taylor' where referee = 'a taylor';
update partido set referee = 'michael oliver' where referee = 'm oliver';
update partido set referee = 'neil swarbrick' where referee = 'n swarbrick';
update partido set referee = 'jonathan moss' where referee = 'j moss';
update partido set referee = 'craig pawson' where referee = 'c pawson';
update partido set referee = 'lee mason' where referee = 'l mason';
update partido set referee = 'roger east' where referee = 'r east';
update partido set referee = 'kevin friend' where referee = 'k friend';
update partido set referee = 'simon hooper' where referee = 's hooper';
update partido set referee = 'peter bankes' where referee = 'p bankes';
