# 1. Отобрать всех актеров, играющих в заданном фильме N
create procedure actorFromFilm (film varchar(50))
	select actor_name, actor_surname from actors natural join actors_films 
	where film_id = (select film_id from films where film_name = film);
call actorFromFilm("Индиана Джонс: В поисках утраченного ковчега");

# 2. Отобрать все фильмы заданного актера
create procedure actorFilms (actor varchar(55))
	select film_name from actors natural join actors_films natural join films 
	where (actor_name = substring_index(actor, " ", 1) or actor_name = substring_index(actor, " ", -1)) and
		  (actor_surname = substring_index(actor, " ", -1) or actor_surname = substring_index(actor, " ", 1));
call actorFilms("Джонни Депп");
call actorFilms("Депп Джонни");
drop procedure actorFilms;

# 3. Отобрать количество фильмов, выпущенные с Т1 по Т2 годы
delimiter //
create function numberFilmsInTimeInterval (t1 int(4), t2 int(4))
returns int
begin
	declare num int;
	select count(*) into num from films where release_year between t1 and t2;
    return num;
end//
delimiter ;
select numberFilmsInTimeInterval(1990, 2000);

# 4. Отобрать все фильмы, фигурирующие в номинациях премии Оскар в заданном году
create procedure OscarReward (y int(4))
	select film_name from films where film_id in (select film_id from rewardings_Oscar where rewarding_year = y);
call OscarReward(2009);

# 5. Отобрать все рецензии о заданном фильме
create procedure ReviewsAboutFilm (film varchar(50))
	select * from reviews where film_id = (select film_id from films where film_name = film);
call ReviewsAboutFilm("Властелин колец: Возвращение Короля");

# 6. Отобрать все фильмы заданного жанра от заданного режиссера
create procedure statisticOfGenreForDirector (genre varchar(20), director varchar(55))
	select film_name from films where genre_id = (select genre_id from genres where genre_name = genre) 
	and director_id = (select director_id from directors where 
						(director_name = substring_index(director, " ", 1) and director_surname = substring_index(director, " ", -1)) or
                        (director_name = substring_index(director, " ", -1) and director_surname = substring_index(director, " ", 1)));
call statisticOfGenreForDirector("Фентези", "Гор Вербински");

# 7. Отобрать всех актеров, получивших Оскар в заданном году 
create procedure Oscar (y int(4))
	select actor_name, actor_surname from actors where actor_id in (select actor_id from rewardings_Oscar where rewarding_year = y);
call Oscar(2009);

# 8. Вывести страну, на территории которой снято больше всего фильмов
delimiter //
create function mostPopularCountry()
returns varchar(20)
begin
	declare country varchar(20);
	select country_name into country from countries as t1 group by country_id limit 1;
    return country;
end //
delimiter ;
select mostPopularCountry();

# 9. Вывести количество наград, полученные заданным актером
delimiter //
create function rewardingsOfActor (actor varchar(55))
returns int
begin
	declare num int;
	select count(*) as количество into num from rewardings_Oscar as t1 natural join films where 
		exists(select * from actors_films where actors_films.film_id = t1.film_id and 
			exists(select * from actors where concat(actor_name, " ", actor_surname) = actor and actors.actor_id = actors_films.actor_id));
	return num;
end//
delimiter ;
select rewardingsOfActor("Мэрил Стрип");

# 10. Вывести самый популярный жанр
delimiter //
create function mostPopularGenre()
returns varchar(20)
begin
	declare genre varchar(20);
	select genre_name as жанр into genre from genres natural join films group by genre_id order by count(genre_id) desc limit 1;
    return genre;
end //
delimiter ;
select mostPopularGenre();
    
# 11. Выбрать все фильмы, в которых играли N1 и N2
create procedure duet(actor1 varchar(55), actor2 varchar(55))
	select film_name from films as t1 where exists(
		select * from actors_films as t2 where exists(select * from actors as t3 where concat(actor_name, " ", actor_surname) = actor1 and t3.actor_id = t2.actor_id)
			and t2.film_id = t1.film_id and film_id in 
            (select film_id from actors_films as t4 where exists(select * from actors as t5 where concat(actor_name, " ", actor_surname) = actor2 and t5.actor_id = t4.actor_id) 
		group by film_id)
	);
call duet("Джонни Депп", "Орландо Блум");

# 12. Вывести для заданного актера из списка его фильмов тот, у которого наибольший рейтинг
create procedure bestFilmOfActor (actor varchar(55), out film varchar(50))
	select film_name into film from actors inner join actors_films as t1 on(actors.actor_id = t1.actor_id) 
		inner join films on(t1.film_id = films.film_id) where concat(actor_name, " ", actor_surname) = actor group by t1.actor_id;
call bestFilmOfActor("Хит Леджер", @film);
select @film;

# 13. Вывести количество "провальных" фильмов заданного актера (фильмы, рейтинг которых ниже среднего)
create procedure countBadFilmsOfActor (actor varchar(55), out count_films int)
	select count(film_name) into count_films from films where film_id in 
		(select film_id from actors_films where actor_id = 
			(select actor_id from actors where actor_name = substring_index(actor, " ", 1) and actor_surname = substring_index(actor, " ", -1))) group by rating 
		having rating < (select avg(rating) from films);
call countBadFilmsOfActor("Джонни Депп", @count_films);
select @count_films;

# 14. Вывести количество самых востребованных актеров (количество фильмов, в которых они снимались больше среднего)
create procedure countOfMostPopularActors (out num int)
	select count(*) into num from (select * from actors natural join actors_films as t1 group by actor_id 
		having count(film_id) > (select avg(n) from (select count(film_id) as n from actors_films group by actor_id) as t)) as t2;
call countOfMostPopularActors(@num);
select @num;