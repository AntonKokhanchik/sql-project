# 1. Создать триггер, который при вставке актера в таблицу Актёры проверяет наличие указанной страны, и если та не указана, ставит страну 9 (Неизвестно)
delimiter //
create trigger insert_check before insert on actors
for each row
begin
	if new.country_id is null then
		set new.country_id = (select country_id from countries where country_name = 'Неизвестно');
	end if;
end //
delimiter ;
insert into actors value (1, "Джонни", "Пробный", 2017, null);

# 2. Создать триггер для вставки в таблицу Страны, который бы переводил первую букву названия страны в верхний регистр
delimiter //
create trigger upper before insert on countries
for each row
begin
	set new.country_name = CONCAT(upper(left(new.country_name,1)), substr(new.country_name,2));
end //
delimiter ;
insert into countries value (14, "исландия");
drop trigger upper;

# 3. Создать триггер, который при удалении страны из таблицы Страны заменеят все вхождения этой страны в других таблицах на страну 9 (Неизвестно)
delimiter //
create trigger befor_delete_country before delete on countries
for each row
begin
	update actors set country_id = 9 where country_id = old.country_id;
    update films set country_id = 9 where country_id = old.country_id;
    update directors set country_id = 9 where country_id = old.country_id;
    update producers set country_id = 9 where country_id = old.country_id;
    update screenwriters set country_id = 9 where country_id = old.country_id;
end //
delimiter ;
delete from countries where country_name = "Новая Зеландия";

# 4. Создать триггер для каскадного удаления фильма
delimiter //
create trigger before_delete_film before delete on films
for each row
begin
	delete from reviews where film_id = old.film_id;
    delete from actors_films where film_id = old.film_id;
end //
delimiter ;
delete from films where film_name = "Дети шпионов 4D";

# 5. Создать триггер для вставки в таблицу Награждения, который проверряет, входит ли номинация в допустимое множество
drop table nominations;
create table nominations (
	nomination varchar(50)
)CHARACTER SET = UTF8;

insert into nominations values
("Лучшая женская роль"),
("Лучшая женская роль второго плана"),
("Лучшая мужская роль"),
("Лучшая мужская роль второго плана");

delimiter //
create trigger after_insert_reward after insert on rewardings_oscar
for each row
begin
	if new.nomination not in (select nomination from nominations) then
		delete from rewardings_oscar where nomination = new.nomination;
	end if;
end //
delimiter ;
drop trigger after_insert_reward;
insert into rewardings_oscar value
(2017, 1491, 301, "Лучшая мужская роль"),
(2017, 4810, 81924, "Лучшая кошачья мята");

show triggers;

# 6. Создать триггер, который заполняет таблицу Аудит при изменении таблицы Фильмы
create table AuditFilms (
	date_operation datetime,
    name_operation varchar(20),
    attribute varchar (20),
    old_data text,
    new_data text
)CHARACTER SET = UTF8;  

delimiter //
create trigger after_update_films after update on films
for each row
begin
	if new.film_id != old.film_id then
		insert into auditfilms value (now(), "update", "film_id", old.film_id, new.film_id);
	end if;
	if new.film_name != old.film_name then
		insert into auditfilms value (now(), "update", "film_name", old.film_name, new.film_name);
	end if;
	if new.release_year != old.release_year then
		insert into auditfilms value (now(), "update", "release_year", old.release_year, new.release_year);
	end if;
	if new.rating != old.rating then
		insert into auditfilms value (now(), "update", "rating", old.rating, new.rating);
	end if;
	if new.director_id != old.director_id then
		insert into auditfilms value (now(), "update", "director_id", old.director_id, new.director_id);
	end if;
	if new.producer_id != old.producer_id then
		insert into auditfilms value (now(), "update", "producer_id", old.producer_id, new.producer_id);
	end if;
	if new.screenwriter_id != old.screenwriter_id then
		insert into auditfilms value (now(), "update", "screenwriter_id", old.screenwriter_id, new.screenwriter_id);
	end if;
	if new.country_id != old.country_id then
		insert into auditfilms value (now(), "update", "country_id", old.country_id, new.country_id);
	end if;
	if new.genre_id != old.genre_id then
		insert into auditfilms value (now(), "update", "genre_id", old.genre_id, new.genre_id);
	end if;
end//
delimiter ;
update films set film_name = "Буль-буль. ААААА! ПОМОГИТЕ!" where film_id = 2213;

# 7. Создать триггер, который проверяет рецензии на наличие нецензурных слов 
#    (для примера используется слово "редиска") и заменяет их (его) на "нехороший человек"
delimiter //
create trigger before_insert_reviews before insert on reviews
for each row
begin
	if new.review_text like "%редиска%" then
		set new.review_text = replace(new.review_text, "редиска", "нехороший человек");
	end if;
end//
delimiter ;
drop trigger before_insert_reviews;
insert into reviews value (9, "la-la", "anonimus", 2213, 9, "Ок, только режисер - редиска, убил Джека. Редиска. Точно");
insert into reviews value (10, "la-la", "anonimus", 2213, 9, "А редиска-то может и не редиска....");

# 8. Создать триггер, который проверяет, есть ли у вставляемой рецензии название. Если нет, дает название "без названия"
delimiter //
create trigger before_insert_reviews before insert on reviews
for each row
begin
	if new.review_name = " " or new.review_name is null then
		set new.review_name = "без названия";
	end if;
end//
delimiter ;
drop trigger before_insert_reviews;
insert into reviews (review_name, author_name, film_id, author_mark, review_text) 
value (null, "anonimus", 2213, 9, "А редиска-то может и не редиска....");

