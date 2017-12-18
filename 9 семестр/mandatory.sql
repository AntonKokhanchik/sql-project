alter table films add access tinyint(2);
update films set access = 1 where country_id = 1;
update films set access = 2 where country_id != 1;

drop user  admin, customer;
create user admin, customer;

grant select on films to customer;
grant all on films to admin;

create view for_admin as
	select * from films where access <= 2 with local check option;
create view for_user as
	select * from films where access <= 1 with local check option;


delimiter //
create procedure see_films (user_name varchar(50))
begin
	if user_name = 'admin' then
		select * from for_admin;
	end if;
	if user_name = 'customer' then
		select * from for_user;
	end if;

end //
delimiter ;

call see_films('customer');
call see_films('admin');