/* question two*/
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Directors CASCADE;
DROP TABLE IF EXISTS Actors CASCADE;
DROP TABLE IF EXISTS Movies CASCADE;
DROP TABLE IF EXISTS DirectorRoles;
DROP TABLE IF EXISTS ActorRoles;

-- People --
CREATE TABLE People (
   pid			int not null,
   name			text,
   address		text,
   spouse		text,
 primary key(pid)
);

-- Directors --
CREATE TABLE Directors (
   directorId					int not null,
   filmSchoolAttended			text,
   directorGuildAnniversaryDate	date,
   favoriteLensMaker			text,
 primary key(directorId),
 foreign key(directorId) references People(pid)
);

-- Actors --
CREATE TABLE Actors (
   actorId						int not null,
   actorBirthDate				date,
   actorHairColor				text,
   actorEyeColor				text,
   actorHeight					int,
   actorWeight					int,
   favoriteColor				text,
   screenActorAnniversaryDate	date,
 primary key(actorId),
 foreign key(actorId) references People(pid)
);

create type rating as enum('G', 'PG', 'PG-13', 'R');
CREATE TABLE Movies (
   movieId				int not null,
   movieName			text,
   MPAA					rating,
   yearReleased			int,
   domesticSales		decimal(6,2),
   foreignSales			decimal(6,2),
   dvdBlueRaySales		decimal(6,2),
 primary key(movieId)
);

-- Director Roles --
CREATE TABLE DirectorRoles (
   directorRoleId   int not null,
   directorId		int,
   movieId			int,
 primary key(directorRoleId),
 foreign key(directorId) references Directors(directorId),
 foreign key(movieId) references Movies(movieId)
);

-- Actor Roles --
CREATE TABLE ActorRoles (
   actorRoleId	int not null,
   actorId		int,
   movieId		int,
 primary key(actorRoleId),
 foreign key(actorId) references Actors(actorId),
 foreign key(movieId) references Movies(movieId)
);


/* question four */
select name
from People
where pid in (select directorId
            from Directors
            where directorId in (select directorId
                                from DirectorRoles
                                where movieId in (select movieId
                                                from ActorRoles
                                                where actorId in (select actorId
                                                                from Actors
                                                                where actorId in (select pid
                                                                                from People
                                                                                where name = "Roger Moore")))));