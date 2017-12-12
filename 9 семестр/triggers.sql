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

# 2. Создать триггер для вставки в таблицу Страны, который бы переводил первую букву названия страны в везрний регистр
delimiter //
create trigger upper before insert on countries
for each row
begin
	set new.country_name = CONCAT(upper(left(new.country_name,1)), substr(new.country_name,2));
end //
delimiter ;
insert into countries value (14, "исландия");
drop trigger upper;