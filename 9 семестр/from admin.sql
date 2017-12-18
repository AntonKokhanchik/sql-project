use films;

grant select, update, insert on films.actors to moderator;
grant select, update, insert on films.actors_films to moderator;
grant select, update, insert on films.films to moderator;
grant select, update, insert on films.rewardings_Oscar to moderator;
grant select, update, insert on films.directors to moderator;
grant select, update, insert on films.screenwriters to moderator;
grant select, update, insert on films.producers to moderator;

grant select, update, insert, grant option on films.reviews to editor;

grant select on films.* to customer;