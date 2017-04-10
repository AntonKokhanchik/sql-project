# 1.	Отобрать всех актеров, играющих в фильме "Гарри Поттер и философский камень"
select actor_name, actor_surname from actors natural join actors_films 
where film_id = (select film_id from films where film_name = "Гарри Поттер и философский камень");

select actor_name, actor_surname from actors natural join actors_films natural join films 
where film_name = "Гарри Поттер и философский камень";
# игнорирует Эмму Уотсон

# 2.	Отобрать все фильмы актера Джонни Деппа
select film_name from actors natural join actors_films natural join films 
where actor_name = "Джонни" and actor_surname = "Депп";

select film_name from films where film_id in 
	(select film_id from actors_films where actor_id = 
		(select actor_id from actors where actor_name = "Джонни" and actor_surname = "Депп"));

# 3.	Отобрать все фильмы, где режиссер Алехандро Иньярриту и продюсер Стив Голин
select film_name from films where director_id = 
	(select director_id from directors where director_name = "Крис" and director_surname = "Коламбус") 
and producer_id = 
	(select producer_id from producers where producer_name = "Дэвид" and producer_surname = "Хейман");
    
# 4.	Отобрать все фильмы, выпущенные раньше 1990 года
select film_name from films where release_year < 1990 order by release_year;

# 5.	Отобрать все фильмы, выпущенные режиссером __ до 2010 года
select film_name from films where release_year < 2010 and director_id = 
	(select director_id from directors 
    where director_name = "Гор" and director_surname = "Вербински");

# 6.	Отобрать все фильмы, фигурирующие в номинациях премии Оскар в 2000 году
select film_name from films where film_id in 
	(select film_id from rewardings_Oscar where rewarding_year = 2009);
# TODO: добавить фильмы с оскаром 2009

# 7.	Отобрать все фильмы с актером __, где режиссер __
select film_name from films where director_id = 
	(select director_id from directors where director_name = "Гор" and director_surname = "Вербински") 
and film_id = any (select film_id from actors_films where actor_id = 
	(select actor_id from actors where actor_name = "Джонни" and actor_surname = "Депп"));

# 8.	Отобрать все фильмы режиссера __, снятые в Англии
select film_name from films where country_id = 
	(select country_id from countries where country_name = "Великобритания") 
and director_id = 
	(select director_id from directors where director_name = "Крис" and director_surname = "Коламбус");
# TODO: добавитьбольше Поттеров с одним режиссёром

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


