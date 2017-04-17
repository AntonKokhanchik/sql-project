# TODO: 30.2+
#данные: 
#	больше "провальных" фильмов Джонни Деппа
#	больше наград для Мэрил Стрип
#	больше рецензий о ВКВК
#	больше фильмов, сценаристом которых является Тед Эллиот
#	больше актеров из Германии, игравших в фильмах, снятых в США
#
# 1.	Отобрать всех актеров, играющих в фильме "Гарри Поттер и философский камень"
select actor_name, actor_surname from actors natural join actors_films 
where film_id = (select film_id from films where film_name = "Гарри Поттер и философский камень");

select actor_name, actor_surname from actors inner join actors_films on(actors.actor_id = actors_films.actor_id) inner join films on(actors_films.film_id = films.film_id)
where film_name = "Гарри Поттер и философский камень";

# 2.	Отобрать все фильмы актера Джонни Деппа
select film_name from actors natural join actors_films natural join films 
where actor_name = "Джонни" and actor_surname = "Депп";

select film_name from films where film_id in 
	(select film_id from actors_films where actor_id = 
		(select actor_id from actors where actor_name = "Джонни" and actor_surname = "Депп"));

# 3.	Отобрать все фильмы, где режиссер Крис Коламбус и продюсер Дэвид Хейман
select film_name from films where director_id = 
	(select director_id from directors where director_name = "Крис" and director_surname = "Коламбус") 
and producer_id = 
	(select producer_id from producers where producer_name = "Дэвид" and producer_surname = "Хейман");
    
# 4.	Отобрать все фильмы, выпущенные раньше 1990 года
select film_name from films where release_year < 1990 order by release_year;

# 5.	Отобрать все фильмы, выпущенные режиссером Гор Вербински до 2010 года
select film_name from films where release_year < 2010 and director_id = 
	(select director_id from directors 
    where director_name = "Гор" and director_surname = "Вербински");

# 6.	Отобрать все фильмы, фигурирующие в номинациях премии Оскар в 2009 году
select film_name from films where film_id in 
	(select film_id from rewardings_Oscar where rewarding_year = 2009);

# 7.	Отобрать все фильмы с актером Джонни Депп, где режиссер Гор Вербински
select film_name from films where director_id = 
	(select director_id from directors where director_name = "Гор" and director_surname = "Вербински") 
and film_id = any (select film_id from actors_films where actor_id = 
	(select actor_id from actors where actor_name = "Джонни" and actor_surname = "Депп"));

# 8.	Отобрать все фильмы режиссера Крис Коламбус, снятые в Англии
select film_name from films where country_id = 
	(select country_id from countries where country_name = "Великобритания") 
and director_id = 
	(select director_id from directors where director_name = "Крис" and director_surname = "Коламбус");

# 9.	Отобрать количество фильмов, снятых на территории США в период 1980-2017 год
select count(film_id) from films where (release_year between 1995 and 2000) and country_id in 
	(select country_id from countries where country_name = "США");

# 10.	 Отобрать все рецензии о фильме Властелин колец: Возвращение Короля
select * from reviews 
where film_id = (select film_id from films where film_name = "Властелин колец: Возвращение Короля");

# 11.	 Отобрать все фильмы жанра Фентези от режиссера Горa Вербински в период 2002-2010
select film_name from films where genre_id = 
	(select genre_id from genres where genre_name = "Фентези") 
and director_id = 
	(select director_id from directors where director_name = "Гор"
    and director_surname = "Вербински") 
and release_year between 2002 and 2010;

# 12. Отобрать всех актеров, получивших Оскар в 2009 году 
select actor_name, actor_surname from actors where actor_id in (select actor_id from rewardings_Oscar where rewarding_year = 2009);

# 13. Выбрать всех актеров, игравших в фильмах, сценаристом которых является Тед Эллиот
select actor_name, actor_surname from actors where actor_id in 
	(select actor_id from actors_films where film_id in 
		(select film_id from films where screenwriter_id = 
			(select screenwriter_id from screenwriters where screenwriter_name = "Тед" and screenwriter_surname = "Эллиот")));

# 14. Отобрать всех сценаристов, продюсеров и режиссеров "оскороносных" фильмов 
select concat(director_name, " ", director_surname, ", режиссер") as разработчик from directors where director_id in 
	(select director_id from films where film_id in 
		(select film_id from rewardings_Oscar)) 
union select concat(producer_name, " ", producer_surname, ", продюсер") from producers where producer_id in 
	(select producer_id from films where film_id in 
		(select film_id from rewardings_Oscar)) 
union select concat(screenwriter_name, " ", screenwriter_surname, ", сценарист") from screenwriters where screenwriter_id in 
	(select screenwriter_id from films where film_id in 
		(select film_id from rewardings_Oscar));

# 15. Показать режиссера и сценариста первого фильма, обеспечившего победу в номинации "Лучшая мужская роль" 
select concat(director_name, " ", director_surname) as режиссер, concat(screenwriter_name, " ", screenwriter_surname) as сценарист from directors, screenwriters where director_id = 
	(select director_id from films where film_id = 
		(select film_id from rewardings_Oscar where nomination = "Лучшая мужская роль" order by rewarding_year limit 1)) and screenwriter_id = 
			(select screenwriter_id from films where film_id = 
				(select film_id from rewardings_Oscar where nomination = "Лучшая мужская роль" order by rewarding_year limit 1));
  
  
select concat(director_name, " ", director_surname) as режиссер, concat(screenwriter_name, " ", screenwriter_surname) as сценарист from directors, screenwriters, rewardings_Oscar where 
director_id = (select director_id from films where film_id = rewardings_Oscar.film_id) 
    and screenwriter_id = (select screenwriter_id from films where film_id = rewardings_Oscar.film_id)
		group by film_id having rewardings_Oscar.film_id = 
			(select film_id from rewardings_Oscar where nomination = "Лучшая мужская роль" order by rewarding_year limit 1);

# 16. Отобрать первые 2 фильмов, снятых на территории США, за участие в которых были получены Оскары 
select film_name from films where film_id in 
	(select film_id from rewardings_Oscar) and country_id = 
		(select country_id from countries where country_name = "США") order by release_year limit 2;

# 17. Вывести страну, на территории которой снято больше всего фильмов 
select country_name, max((select count(film_id) as count_films from films as t2 where t2.country_id = t1.country_id )) from countries as t1;

# 18. Вывести "провальные" фильмы актера Джонни Деппа (фильмы, рейтинг которых ниже среднего)
select film_name from films where film_id in 
	(select film_id from actors_films where actor_id = 
		(select actor_id from actors where actor_name = "Джонни" and actor_surname = "Депп")) group by rating 
	having rating < (select avg(rating) from films);

# 19. Показать режиссера, продюсера и название первого фильма, обеспечившего победу в номинации "Лучшая женская роль" актрисе Мэрил	Стрип
select concat(director_name, " ", director_surname) as режиссер, concat(producer_name, " ", producer_surname) as продюсер, film_name
from directors, producers, (select * from films where exists(select film_id from rewardings_Oscar where rewardings_Oscar.film_id = films.film_id)) as t2 
	where directors.director_id = t2.director_id and producers.producer_id = t2.producer_id and exists(select actor_id from actors as t1 where actor_name = "Мэрил" and actor_surname = "Стрип" and
		exists(select film_id from rewardings_Oscar where nomination = "Лучшая женская роль" and rewardings_Oscar.actor_id=t1.actor_id and rewardings_Oscar.film_id = t2.film_id group by rewarding_year limit 1));

# 20. Вывести все награды, полученные актером Мэрил	Стрип
select nomination, rewarding_year, film_name from rewardings_Oscar as t1 natural join films where 
	exists(select * from actors_films where actors_films.film_id = t1.film_id and 
		exists(select * from actors where concat(actor_name, " ", actor_surname) = "Мэрил Стрип" and actors.actor_id = actors_films.actor_id));

# 21. Вывести всех актеров в порядке возрастания успешности (имеется в виду количество полученных наград)
select concat(actor_name, " ", actor_surname) as актёр, count((select actor_id from rewardings_Oscar where rewardings_Oscar.actor_id = t1.actor_id)) as количество_наград 
	from actors as t1 group by actor_id order by количество_наград;
    
# 22. Вывести 5 наиболее востребованных актеров за 2000-2005 годы (тех, кто снимался в большем количестве фильмов)
select concat(actor_name, " ", actor_surname) as актёр, count(film_id) as количество_фильмов from actors natural join actors_films group by actor_id order by количество_фильмов desc limit 5;

# 23. Вывести список фильмов, снятых на территории Великобритании, имеющих рейтинг больше 8
select film_name from films where rating > 8 and exists(select * from countries where country_name = "Великобритания" and countries.country_id = films.country_id);

# 24. Вывести Топ-7 фильмов
select film_name, rating from films order by rating desc limit 7;

# 25. Посчитать средний рейтинг фильмов США, снятых после 2000 года
select avg(rating) from films where release_year > 2000 and exists(select * from countries where country_name = "США" and countries.country_id = films.country_id);

# 26. Вывести все фильмы (название, год, страна), рейтинг которых ниже среднего
select film_name, release_year, rating, country_name from films natural join countries where rating < (select avg(rating) from films);

# 27. Вывести всех актеров из Германии, игравших в фильмах, снятых в США
select concat(actor_name, " ", actor_surname) as актёр from actors natural join countries where country_name = "Германия" and 
	exists(select actor_id from actors_films where film_id in (select film_id from films natural join countries where country_name = "США") and actors_films.actor_id = actors.actor_id);

# 28. Отобрать всех актеров, младше 30 лет
select concat(actor_name, " ", actor_surname) as актёр, (year(now())-birth_year) as возраст from actors having возраст < 30;

# 29. Отобрать всех актеров, игравших в фильмах с рейтингом, который выше среднего
select concat(actor_name, " ", actor_surname) from actors as t1 where
	exists(select * from actors_films as t2 where t1.actor_id = t2.actor_id and
		exists(select * from films as t3 where t2.film_id = t3.film_id and rating > (select avg(rating) from films)));
        
# 30. Вывести все жанры в порядке убывания их популярности у режиссеров (по частоте использования)
select genre_name as жанр, (select count(genre_id) from films as t1 group by genre_id having t1.genre_id = t2.genre_id) as частота from genres as t2 group by genre_id order by частота desc;
