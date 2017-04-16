drop table if exists actors_films;
drop table if exists rewardings_oscar;
drop table if exists reviews;
drop table if exists films;
drop table if exists actors;
drop table if exists genres;
drop table if exists directors;
drop table if exists producers;
drop table if exists screenwriters;
drop table if exists countries;

create table if not exists countries(
	country_id tinyint unsigned primary key auto_increment,
    country_name varchar(20) not null
)CHARACTER SET=UTF8;

create table if not exists actors(
	actor_id int unsigned primary key,
    actor_name varchar(30) not null,
    actor_surname varchar(20) not null,
    birth_year int(4) not null,
    country_id tinyint unsigned not null,
    foreign key (country_id) references countries(country_id)
)CHARSET=UTF8;

create table if not exists genres(
	genre_id tinyint unsigned primary key,
    genre_name varchar(20) not null,
    description varchar(255)
)CHARSET=UTF8;

create table if not exists directors(
	director_id int unsigned primary key,
    director_name varchar(30) not null,
    director_surname varchar(20) not null,
    birth_year int(4) not null,
    country_id tinyint unsigned not null,
    foreign key (country_id) references countries(country_id)
)CHARSET=UTF8;

create table if not exists producers(
	producer_id int unsigned primary key,
    producer_name varchar(30) not null,
    producer_surname varchar(20) not null,
    birth_year int(4) not null,
    country_id tinyint unsigned not null,
    foreign key (country_id) references countries(country_id)
)CHARSET=UTF8;

create table if not exists screenwriters(
	screenwriter_id int unsigned primary key,
    screenwriter_name varchar(30) not null,
    screenwriter_surname varchar(20) not null,
    birth_year int(4) not null,
    country_id tinyint unsigned not null,
    foreign key (country_id) references countries(country_id)
)CHARSET=UTF8;

create table if not exists films(
	film_id int unsigned primary key,
    film_name varchar(50) not null,
    release_year int(4) not null,
    rating float,
	director_id int unsigned not null,
	producer_id int unsigned,
	screenwriter_id int unsigned,
    country_id tinyint unsigned,
    genre_id tinyint unsigned not null,
    foreign key (director_id) references directors (director_id),
    foreign key (producer_id) references producers (producer_id),
    foreign key (screenwriter_id) references screenwriters (screenwriter_id),
    foreign key (country_id) references countries (country_id),
    foreign key (genre_id) references genres (genre_id)
)CHARSET=UTF8;

create table if not exists reviews(
	review_id int unsigned primary key auto_increment,
    review_name varchar(50) not null,
    author_name varchar(30) not null,
    film_id int unsigned not null,
	author_mark tinyint,
    review_text text not null,
    foreign key (film_id) references films (film_id)
)CHARSET=UTF8;

create table if not exists actors_films(
	actor_id int unsigned,
    film_id int unsigned,
    character_name varchar(40),
    foreign key (film_id) references films (film_id),
	foreign key (actor_id) references actors (actor_id),
    primary key (actor_id, film_id)
)CHARSET=UTF8;

create table if not exists rewardings_Oscar(
	rewarding_year int(4),
    actor_id int unsigned not null,
    film_id int unsigned not null,
    nomination varchar(50),
    foreign key (actor_id) references actors (actor_id),
    foreign key (film_id) references films (film_id),
    primary key (rewarding_year, nomination)
)CHARSET=UTF8;
