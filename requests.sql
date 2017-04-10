# TODO: 10, 11, 15+
# 1.	Отобрать всех актеров, играющих в фильме "Гарри Поттер и философский камень"
select actor_name, actor_surname from actors natural join actors_films 
where film_id = (select film_id from films where film_name = "Гарри Поттер и философский камень");

select actor_name, actor_surname from actors inner join actors_films on(actors.actor_id = actors_films.actor_id) inner join films on(actors_films.film_id = films.film_id)
where film_name = "Гарри Поттер и философский камень";

#select actor_name, actor_surname from actors natural join actors_films natural join films 
#where film_name = "Гарри Поттер и философский камень";


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

# 10.	 Отобрать все рецензии о фильме __ от автора __
select review_author, review_name, review_text from reviews 
where author_name = "" and film_id = 
	(select film_id from films where film_name = "");
# не проверено TODO: добавить рецензии

# 11.	 Отобрать все фильмы жанра __ от режиссера __ в период __
select film_name from films where genre_id = 
	(select genre_id from genres where genre_name = "") 
and director_id = 
	(select director_id from directors where director_name = "" 
    and director_surname = "") 
and release_year between  and ;

# 12. Отобрать всех актеров, получивших Оскар в 2009 году 
select actor_name, actor_surname from actors where actor_id in (select actor_id from rewardings_Oscar where rewarding_year = 2009);

# 13. Выбрать всех актеров, игравших в фильмах, сценаристом которых является __ 
select actor_name, actor_surname from actors where actor_id in 
	(select actor_id from actors_films where film_id in 
		(select film_id from films where screenwriter_id = 
			(select screenwriter_id from screenwriters where screenwriter_name = "" and screenwriter_surname = "")));

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

# 16. Отобрать первые 10 фильмов, снятых на территории Новой Зеландии, за участие в которых были получены Оскары select film_name from films where film_id in (select film_id from rewardings_Oscar) and country_id = (select country_id from countries where country_name = “Новая Зеландия”);

# 17. Вывести страну, на территории которой снято больше всего фильмов select country_name, (select count(film_id) from films as t2 where t2.country_id = t1.country_id ) as count from countries as t1;

