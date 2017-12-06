# 1. Отобрать все фильмы, выпущенные позже 2007 года
create view newFilms as 
	select * from films where release_year > 2007 order by release_year with local check option;
select * from newFilms;

# 2. Отобрать все фильмы, фигурирующие в номинациях премии Оскар
create view OscarFilms as 
	select film_name from films where film_id in (select film_id from rewardings_Oscar);
select * from OscarFilms;

# 3. Отобрать все фильмы, снятые в Англии
create view englishFilms as 
	select film_name from films where country_id = (select country_id from countries where country_name = "Великобритания") with local check option;
select * from englishFilms;

# 4. Отобрать количество фильмов, снятых на территории США в период 1980-2017 год
create view americanFilms as 
	select count(film_id) from films where (release_year between 1995 and 2000) and country_id in 
	(select country_id from countries where country_name = "США") ;
select * from americanFilms;

# 5. Отобрать всех сценаристов, продюсеров и режиссеров "оскороносных" фильмов 
create view OscarPersons as 
	select concat(director_name, " ", director_surname, ", режиссер") as разработчик from directors where director_id in 
		(select director_id from films where film_id in 
			(select film_id from rewardings_Oscar)) 
	union select concat(producer_name, " ", producer_surname, ", продюсер") from producers where producer_id in 
		(select producer_id from films where film_id in 
			(select film_id from rewardings_Oscar)) 
	union select concat(screenwriter_name, " ", screenwriter_surname, ", сценарист") from screenwriters where screenwriter_id in 
		(select screenwriter_id from films where film_id in 
			(select film_id from rewardings_Oscar));
select * from OscarPersons;

# 6. Вывести Топ-7 фильмов
create view TopFilms as 
	select film_name, rating from films order by rating desc limit 7;
select * from TopFilms;

# 7. Вывести авторов статей, которые всегда ставят оценки ниже рейтинга фильма
create view badUsers as 
	select distinct author_name from reviews as t1 where not exists(
		select author_mark from reviews as t3 where author_mark > (
			select rating from films as t2 where t3.film_id = t2.film_id
		) and t1.author_name = t3.author_name
	);
select * from badUsers;

# 8. Вывести всех актеров, которые являются ещё и режиссерами или продюсерами (возможно в других фильмах)
create view universalPersons as 
	select concat(actor_name, " ", actor_surname, ", режиссёр") as актёр from actors as t1 where 
		if(exists(select * from directors as t2 where concat(actor_name, " ", actor_surname) = concat(director_name, " ", director_surname)), true,false)
	union select concat(actor_name, " ", actor_surname, ", продюсер") as актёр from actors as t1 where 
		if(exists(select * from producers as t2 where concat(actor_name, " ", actor_surname) = concat(producer_name, " ", producer_surname)), true,false);
select * from universalPersons;

# 9. Вывести для каждого актера из списка его фильмов тот, у которого наибольший рейтинг
create view bestFilm as 
	select concat(actor_name, " ", actor_surname) as актёр, film_name, max(rating), character_name 
		from actors inner join actors_films as t1 on(actors.actor_id = t1.actor_id) 
		inner join films on(t1.film_id = films.film_id) group by t1.actor_id;  
select * from bestFilm;

# 10. Посчитать средний рейтинг фильмов США, снятых после 2000 года
create view ratingAmericanFilms as
	select avg(rating) as средний_рейтинг from films where release_year > 2000 and exists(select * from countries where country_name = "США" and countries.country_id = films.country_id);
select * from ratingAmericanFilms;

# 11. Вывести всех актеров в порядке убывания успешности (имеется в виду количество полученных наград)
create view successfulness as
	select concat(actor_name, " ", actor_surname) as актёр, (select count(nomination) from rewardings_oscar where actor_id = t1.actor_id) as наград 
	from actors t1 order by наград desc;
select * from successfulness;

# 12. Вывести все награды, полученные лучшим актером 
create view bestActor as
	select nomination, rewarding_year, (select film_name from films as t2 where t1.film_id = t2.film_id) from rewardings_oscar as t1 where actor_id in 
		(select actor_id from actors where concat(actor_name, " ", actor_surname) = 
			(select актёр from successfulness limit 1)
		);
select * from bestActor;

# 13. Вывести всех актеров с количеством фильмов, в которых они снимались
create view filmsActor as
	select concat(actor_name, " ", actor_surname) as актёр, count(film_id) as количество_фильмов from actors natural join actors_films group by actor_id;
select * from filmsActor;

# 14. Вывести режиссеров в порядке убывания количества наград, полученных актерами за съемки в их фильмах
create view badDirectors as
	select	concat(director_name, " ", director_surname) as режиссер, 
		(select count(nomination) from rewardings_oscar as t1 where 
			exists(select * from films as t2 where t1.film_id = t2.film_id and t3.director_id = t2.director_id)) as количество_наград
		from directors as t3 order by количество_наград desc;
select * from badDirectors;
