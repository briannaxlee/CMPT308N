-------------------- DROPPING TABLES AND TYPES -------------------- 

DROP TABLE IF EXISTS Places CASCADE;
DROP TABLE IF EXISTS Classes CASCADE;
DROP TABLE IF EXISTS Organizations CASCADE;
DROP TABLE IF EXISTS Characters CASCADE;
DROP TABLE IF EXISTS PlayableCharacters CASCADE;
DROP TABLE IF EXISTS NonplayableCharacters CASCADE;
DROP TABLE IF EXISTS AntagonistCharacters CASCADE;
DROP TABLE IF EXISTS BackstoryCharacters CASCADE;
DROP TYPE locations CASCADE;
DROP TYPE needed CASCADE;
DROP TYPE levelOfClasses CASCADE;
DROP TYPE genderIdentity CASCADE;
DROP TYPE raceIdentity CASCADE;
DROP TYPE groups CASCADE;
DROP VIEW OrganizationPlace CASCADE;
DROP VIEW CharacterOrganizationClass CASCADE;
DROP FUNCTION locateCharacter CASCADE;
DROP FUNCTION allAvailableClasses CASCADE;
DROP FUNCTION downloadableClass CASCADE;
DROP ROLE admin;
DROP ROLE authorityFigures;
DROP ROLE players;

-------------------- CREATING TABLES -------------------- 

-- Places --
create type locations as enum('Continent', 'Nation', 'Ancient Civilization','School');
CREATE TABLE Places (
   placeID			    int not null,
   placeName		    text,
   placeType		    locations,
 primary key(placeID)
);

-- Classes --
create type needed as enum('Yes', 'No');
create type levelOfClasses as enum('Unique', 'Beginner', 'Intermediate', 'Advanced', 'Special', 'Master', 'Non-Playable', 'Monster', 'None', 'DLC');
CREATE TABLE Classes (
   classID					        int not null,
   className		            text,
   classLevel    			      levelOfClasses,
   levelAvailable    		    int,
   certificationExamNeeded  needed,
 primary key(classID)
);

-- Organizations --
create type groups as enum('House', 'Religious Group', 'Nation', 'School', 'Antagonist Group', 'Ancient Civilization');
CREATE TABLE Organizations (
   organizationID			    int not null,
   organizationName		  	text,
   placeID				        int,
   organizationType			  groups,
 primary key(organizationID),
 foreign key(placeID) references Places(placeID)
);

-- Characters --
create type genderIdentity as enum('Male', 'Female');
create type raceIdentity as enum('Human', 'Earth Dragon', 'Light Dragon', 'Sky Dragon', 'Water Dragon', 'Wind Dragon', 'Goddess');
CREATE TABLE Characters (
   characterID			      int not null,
   characterName		      text,
   organizationID		      int,
   classID		            int,
   gender			            genderIdentity,
   race		                raceIdentity,
   birthdate          	  date,
   preTimeskipAge     	  int,
   postTimeskipAge    	  int,
 primary key(characterID),
 foreign key(organizationID) references Organizations(organizationID),
 foreign key(classID) references Classes(classID)
);

-- Playable Characters --
CREATE TABLE PlayableCharacters (
   playableID     	  int not null,
   characterID		    int,
   organizationID	    int,
 primary key(playableID),
 foreign key(characterID) references Characters(characterID),
 foreign key(organizationID) references Organizations(organizationID)
);

-- Non-Playable Characters --
CREATE TABLE NonplayableCharacters (
   nonplayableID    	int not null,
   characterID		 	  int,
   organizationID	  	int,
 primary key(nonplayableID),
 foreign key(characterID) references Characters(characterID),
 foreign key(organizationID) references Organizations(organizationID)
);

-- Antagonist Characters --
CREATE TABLE AntagonistCharacters (
   antagonistID       int not null,
   characterID		    int,
   organizationID	    int,
 primary key(antagonistID),
 foreign key(characterID) references Characters(characterID),
 foreign key(organizationID) references Organizations(organizationID)
);

-- Backstory Characters --
CREATE TABLE BackstoryCharacters (
   backstoryID        int not null,
   characterID		    int,
   organizationID	    int,
 primary key(backstoryID),
 foreign key(characterID) references Characters(characterID),
 foreign key(organizationID) references Organizations(organizationID)
);

-------------------- INSERTING DATA -------------------- 

-- Places --
INSERT INTO Places (placeID, placeName, placeType)
VALUES
 (001, 'Foldan',                    'Continent'),
 (002, 'Holy Kingdom of Faerghus',  'Nation'),
 (003, 'Leicester Alliance',        'Nation'),
 (004, 'Adrestian Empire',          'Nation'),
 (005, 'Agartha',                   'Ancient Civilization'),
 (006, 'Nabatea',                   'Ancient Civilization'),
 (007, 'Garreg Mach Monastery',     'School')
;

-- Classes --
INSERT INTO Classes (classID, className, classLevel, levelAvailable, certificationExamNeeded)
VALUES
 (001, 'Commoner',          'Unique',           '0',        'No'),
 (002, 'Noble',             'Unique',           '0',        'No'),
 (003, 'Dancer',            'Unique',           '0',        'No'),
 (004, 'Myrmidon',          'Beginner',         '5',        'Yes'),
 (005, 'Soldier',           'Beginner',         '5',        'Yes'),
 (006, 'Fighter',           'Beginner',         '5',        'Yes'),
 (007, 'Monk',              'Beginner',         '5',        'Yes'),
 (008, 'Mage',              'Intermediate',     '10',       'Yes'),
 (009, 'Priest',            'Intermediate',     '10',       'Yes'),
 (010, 'Lord',              'Intermediate',     '10',       'Yes'),
 (011, 'Swordmaster',       'Advanced',         '20',       'Yes'),
 (012, 'Fortress Knight',   'Advanced',         '20',       'Yes'),
 (013, 'Paladin',           'Advanced',         '20',       'Yes'),
 (014, 'Wyvern Rider',      'Advanced',         '20',       'Yes'),
 (015, 'Warrior',           'Advanced',         '20',       'Yes'),
 (016, 'Assassin',          'Advanced',         '20',       'Yes'),
 (017, 'Trickster',         'Special',          '20',       'Yes'),
 (018, 'War Monk',          'Special',          '20',       'Yes'),
 (019, 'Valkyrie',          'Special',          '20',       'Yes'),
 (020, 'Dark Knight',       'Master',           '30',       'Yes'),
 (021, 'Holy Knight',       'Master',           '30',       'Yes'),
 (022, 'Wyvern Lord',       'Master',           '30',       'Yes'),
 (023, 'Gremory',           'Master',           '30',       'Yes'),
 (024, 'Archbishop',        'Non-Playable',     '0',        'No'),
 (025, 'Lord of the Lake',  'Monster',          '0',        'No'),
 (026, 'Lord of the Desert','Monster',          '0',        'No'),
 (027, 'Emperor',           'None',             '0',        'No'),
 (028, 'Prime Minister',    'None',             '0',        'No'),
 (029, 'Goddess',           'None',             '0',        'No')
;

-- Organizations --
INSERT INTO Organizations (organizationID, organizationName, placeID, organizationType)
VALUES
 (001, 'Black Eagles',                      004, 'House'),
 (002, 'Blue Lions',                        002, 'House'),
 (003, 'Golden Deer',                       003, 'House'),
 (004, 'Holy Kingdom of Faerghus',          002, 'Nation'),
 (005, 'Adrestian Empire',                  004, 'Nation'),
 (006, 'Leicester Alliance',                003, 'Nation'),
 (007, 'Garreg Mach Monastery',             007, 'School'),
 (008, 'Church of Seiros',                  007, 'Religious Group'),
 (009, 'Those Who Slither in the Dark',     005, 'Antagonist Group'),
 (010, 'Children of the Goddess',           006, 'Ancient Civilization')
;

-- Characters --
INSERT INTO Characters (characterID, characterName, organizationID, classID, gender, race, birthdate, preTimeskipAge, postTimeskipAge)
VALUES
 (001, 'Byleth',        008, 011,    'Female',   'Human',           '1159-11-16',   21,      26),
 (002, 'Edalgard',      001, 012,    'Female',   'Human',           '1162-06-22',   18,      24),
 (003, 'Hubert',        001, 002,    'Male',     'Human',           '1159-04-17',   21,      26),
 (004, 'Ferdinand',     001, 002,    'Male',     'Human',           '1162-04-30',   18,      24),
 (005, 'Dimitri',       002, 013,    'Male',     'Human',           '1159-12-20',   18,      24),
 (006, 'Felix',         002, 002,    'Male',     'Human',           '1162-02-20',   18,      23),
 (007, 'Mercedes',      002, 001,    'Female',   'Human',           '1157-05-27',   23,      29),
 (008, 'Claude',        003, 014,    'Male',     'Human',           '1162-07-24',   18,      24),
 (009, 'Lysithea',      003, 008,    'Female',   'Human',           '1164-02-28',   16,      21),
 (010, 'Hilda',         003, 015,    'Female',   'Human',           '1161-02-03',   19,      24),
 (011, 'Seteh',         008, 014,    'Male',     'Earth Dragon',    '0086-12-27',   1000,    1000),
 (012, 'Flayn',         008, 009,    'Female',   'Light Dragon',    '0086-07-12',   1000,    1000),
 (013, 'Monica',        005, 016,    'Female',   'Human',           '1162-10-01',   18,		   24),
 (014, 'Ionius IX',     005, 027,    'Male',     'Human',           '1135-01-02',   45,      51),
 (015, 'Jeralt',        007, 013,    'Male',     'Human',           '1066-12-01',   120,     120),
 (016, 'Arundel',       005, 020,    'Male',     'Human',           '1138-08-12',   43,      48),
 (017, 'Metodey',       005, 016,    'Male',     'Human',           '1162-09-01',   18,      24),
 (018, 'Lonato',        004, 006,    'Male',     'Human',           '1128-09-21',   53,      58),
 (019, 'Rodrigue',      004, 021,    'Male',     'Human',           '1137-03-23',   42,      49),
 (020, 'Judith',        006, 010,    'Female',   'Human',           '1158-10-03',   22,      28),
 (021, 'Nader',         006, 022,    'Male',     'Human',           '1137-09-18',   42,      49),
 (022, 'Rhea',          007, 024,    'Female',   'Sky Dragon',      '0001-01-11',   1222,    1222),
 (023, 'Thales',        009, 020,    'Male',     'Human',           '1122-02-01',   58,      64),
 (024, 'Solon',         009, 002,    'Male',     'Human',           '1108-05-07',   72,      78),
 (025, 'Cornelia',      009, 023,    'Female',   'Human',           '1156-06-15',   24,      30),
 (026, 'Indech',        010, 025,    'Male',     'Water Dragon',    '0086-03-02',   1000,    1000),
 (027, 'Macuil',        010, 026,    'Male',     'Wind Dragon',     '0086-05-31',   1000,    1000),
 (028, 'Derick',        005, 028,    'Male',     'Human',           '1058-04-01',   45,      50),
 (029, 'Christophe',    004, 011,    'Male',     'Human',           '1152-09-15',   27,      33),
 (030, 'Claudia',       006, 002,    'Female',   'Human',           '1100-07-01',   27,      33),
 (031, 'Sothis',        008, 029,    'Female',   'Goddess',         '0001-04-23',   1250,    1250),
 (032, 'Alan',          004, 021,    'Male',     'Human',           '1147-01-01',   33,      38)
;

-- Playable Characters --
INSERT INTO PlayableCharacters (playableID, characterID, organizationID)
VALUES
 (001, 001, 007),
 (002, 002, 001),
 (003, 003, 001),
 (004, 004, 001),
 (005, 005, 002),
 (006, 006, 002),
 (007, 007, 002),
 (008, 008, 003),
 (009, 009, 003),
 (010, 010, 003),
 (011, 011, 008),
 (012, 012, 008)
;

-- Nonplayable Characters --
INSERT INTO NonplayableCharacters (nonplayableID, characterID, organizationID)
VALUES
 (001, 013, 005),
 (002, 014, 005),
 (003, 015, 007),
 (004, 031, 008),
 (005, 032, 004)
;

-- Nonplayable Characters --
INSERT INTO AntagonistCharacters (antagonistID, characterID, organizationID)
VALUES
 (001, 016, 005),
 (002, 017, 005),
 (003, 018, 006),
 (004, 019, 006),
 (005, 020, 006),
 (006, 021, 006),
 (007, 022, 008),
 (008, 023, 009),
 (009, 024, 009),
 (010, 025, 009),
 (011, 026, 010),
 (012, 027, 010)
;

-- Backstory Characters --
INSERT INTO BackstoryCharacters (backstoryID, characterID, organizationID)
VALUES
 (001, 028, 05),
 (002, 029, 004),
 (003, 030, 006),
 (004, 031, 008)
;

-------------------- DISPLAYING TABLES -------------------- 

-- Places --
select *
from Places;

-- Classes --
select *
from Classes;

-- Organizations --
select *
from Organizations;

-- Characters --
select *
from Characters;

-- Playable Characters --
select *
from PlayableCharacters;

-- Non-Playable Characters --
select *
from NonplayableCharacters;

-- Antagonist Characters --
select *
from AntagonistCharacters;

-- Backstory Characters --
select *
from BackstoryCharacters;

-------------------- CREATING VIEW TABLES -------------------- 

-- Organization Place --
CREATE OR REPLACE VIEW OrganizationPlace as
select o.organizationID, o.organizationName, p.placeName
from Organizations o full outer join Places p on o.placeID = p.placeID;

-- Character Organization Class --
CREATE OR REPLACE VIEW CharacterOrganizationClass as
select ch.characterID, ch.characterName, o.OrganizationName, c.className
from Characters ch full outer join Organizations o on ch.organizationID = o.organizationID
	full outer join Classes c on ch.classID = c.classID;

-------------------- DISPLAYING VIEW TABLES -------------------- 

-- Organization Place --
select *
from OrganizationPlace
order by organizationID ASC;

-- Character Organization Class --
select *
from CharacterOrganizationClass
order by characterID ASC;

-------------------- REPORTS AND INTERESTING QUERIES -------------------- 

-- Returns Characers Over the Age of 1000 --
select characterID, characterName, gender, race, preTimeskipAge, postTimeskipAge
from Characters
where preTimeskipAge >= 1000 and postTimeskipAge >= 1000;

-- Returns Characters in Black Eagle House --
select ch.characterID, ch.characterName, o.organizationName, c.className, ch.gender, ch.race, ch.preTimeskipAge, ch.postTimeskipAge
from Characters ch left join Organizations o on (ch.organizationID = o.organizationID)
					left join Classes c on (ch.classId = c.classID)
where ch.organizationID = '001';

-- Returns Characters in Blue Lions House --
select ch.characterID, ch.characterName, o.organizationName, c.className, ch.gender, ch.race, ch.preTimeskipAge, ch.postTimeskipAge
from Characters ch left join Organizations o on (ch.organizationID = o.organizationID)
					left join Classes c on (ch.classId = c.classID)
where ch.organizationID = '002';

-- Returns Characters in Golden Deer House --
select ch.characterID, ch.characterName, o.organizationName, c.className, ch.gender, ch.race, ch.preTimeskipAge, ch.postTimeskipAge
from Characters ch left join Organizations o on (ch.organizationID = o.organizationID)
					left join Classes c on (ch.classId = c.classID)
where ch.organizationID = '003';

-------------------- STORED PROCEDURES -------------------- 

-- Locate Character --
create or replace function locateCharacter(text)
returns table(name text, organization text) as $$
declare
  findCharacter text := $1;
begin
  return query
  select ch.characterName, o.organizationName
  from Characters ch inner join Organizations o on (ch.organizationID = o.organizationID)
  where ch.characterName = findCharacter;
end;
$$ language plpgsql;

-- All Available Classes --
create or replace function allAvailableClasses(int)
returns table(level int, class text, levelType levelOfClasses, test needed) as $$
declare
  availableLevel int := $1;
begin
  return query
  select c.levelAvailable, c.className, c.classLevel, c.certificationExamNeeded
  from Classes c
  where c.levelAvailable = availableLevel
  group by c.levelAvailable, c.className, c.classLevel, c.certificationExamNeeded
  order by c.levelAvailable;
end;
$$ language plpgsql

-- Downloadable Class --
create or replace function downloadableClass()
returns trigger as $$
begin
  if (new.classLevel = 'DLC') then
  delete from Classes where classLevel = new.classLevel;
  end if;

  return NEW;
  end;
  $$ language plpgsql
  
-------------------- TRIGGER -------------------- 

-- Downloadable Class --
create trigger downloadableClass
after insert on Classes
for each row
execute procedure downloadableClass();

-------------------- INSERTING DATA INTO TRIGGER -------------------- 

-- Classes --
INSERT INTO Classes
VALUES (030, 'Death Knight', 'DLC', '0', 'No')

-------------------- DISPLAYING DATA FROM TRIGGER -------------------- 

-- Classes --
select *
from Classes;

-------------------- DISPLAYING STORED PROCEDURES -------------------- 

-- Locate Character --
select locateCharacter('Claude');
select locateCharacter('Dimitri');
select locateCharacter('Edalgard');
select locateCharacter('Alan');

-- All Available Classes --
select allAvailableClasses(0);
select allAvailableClasses(10);
select allAvailableClasses(20);
select allAvailableClasses(30);

-------------------- SECURITY -------------------- 

-- Admin --
create role admin;
grant all on all tables in schema public to admin;

-- Authority Figures --
create role authorityFigures;
revoke all on all tables in schema public from authorityFigures;
grant select on all tables in schema public to authorityFigures;
grant insert on Characters, PlayableCharacters, NonplayableCharacters,
  AntagonistCharacters, BackstoryCharacters
to authorityFigures;
grant update on Characters, PlayableCharacters, NonplayableCharacters,
  AntagonistCharacters, BackstoryCharacters
to authorityFigures;

-- Players --
create role players;
revoke all on all tables in schema public from players;
grant select on Characters, PlayableCharacters, NonplayableCharacters,
  AntagonistCharacters, BackstoryCharacters
to players;