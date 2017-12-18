create user admin identified by 'admin';
create user moderator identified by 'moderator';
create user editor identified by 'editor';
create user author identified by 'author';
create user customer identified by 'customer';

select user from mysql.user;

grant all on films.* to admin;
grant grant option on films.* to admin;

select Db, User, Grantor, Table_name, Table_priv from mysql.tables_priv where Db != 'sys';