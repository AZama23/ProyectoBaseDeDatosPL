create table partido_backup as table partido;

update partido
set
  season = lower(trim(replace(replace(season, '.', ''), ',', ''))),
  home_team = lower(trim(replace(replace(home_team, '.', ''), ',', ''))),
  away_team = lower(trim(replace(replace(away_team, '.', ''), ',', ''))),
  full_time_result = lower(trim(replace(replace(full_time_result, '.', ''), ',', ''))),
  half_time_result = lower(trim(replace(replace(half_time_result, '.', ''), ',', ''))),
  referee = lower(trim(replace(replace(referee, '.', ''), ',', ''))),
  league = lower(trim(replace(replace(league, '.', ''), ',', '')));

-- manchester united
update partido set home_team = 'manchester united' where home_team in ('man utd', 'manchester utd');
update partido set away_team = 'manchester united' where away_team in ('man utd', 'manchester utd');

-- manchester city
update partido set home_team = 'manchester city' where home_team in ('man city', 'manchester c');
update partido set away_team = 'manchester city' where away_team in ('man city', 'manchester c');

-- tottenham hotspur
update partido set home_team = 'tottenham hotspur' where home_team = 'tottenham';
update partido set away_team = 'tottenham hotspur' where away_team = 'tottenham';

-- wolverhampton wanderers
update partido set home_team = 'wolverhampton wanderers' where home_team = 'wolves';
update partido set away_team = 'wolverhampton wanderers' where away_team = 'wolves';

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
