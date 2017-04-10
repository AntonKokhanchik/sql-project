insert into countries (country_name) values
("США"),
("Новая Зеландия"),
("Великобритания"),
("Австралия"),
("Франция"),
("Канада"),
("Мексика"),
("Ирландия"),
("Неизвестно"),
("Уганда"),
("Германия"),
("Ливан"),
("Нигерия");

insert into  directors 
(director_id, director_name, director_surname, birth_year, country_id) values
(32383, "Питер", "Джексон", 1961, 2),
(41477, "Кристофер", "Нолан", 1970, 3),
(24817, "Крис", "Коламбус", 1958, 1),
(27977, "Джеймс", "Кэмерон", 1954, 6),
(563585, "Алехандро", "Иньярриту", 1963, 7),
(8442, "Уэс", "Крэйвен", 1939, 1),
(30870, "Гор", "Вербински", 1964, 1),
(29361, "Скотт", "Хикс", 1953, 10),
(30966, "Роберт", "Родригес", 1968, 1),
(23330, "Лана", "Вачовски", 1965, 1),
(22260, "Стивен", "Спилберг", 1946, 1),
(1190481, "Филлида", "Ллойд", 1957, 3),
(10346, "Стивен", "Долдри", 1961, 3);

insert into producers 
(producer_id, producer_name, producer_surname, birth_year, country_id) values
(32383, "Питер", "Джексон", 1961, 2),
(41477, "Кристофер", "Нолан", 1970, 3),
(23449, "Дэвид", "Хейман", 1961, 3),
(27977, "Джеймс", "Кэмерон", 1954, 6),
(6784, "Стив", "Голин", 1955 , 1),
(3023, "Роберт", "Шей", 1939, 1),
(10207, "Джерри", "Брукхаймер", 1943, 1),
(90143, "Джейн", "Скотт", 1945, 3),
(30966, "Роберт", "Родригес", 1968, 1),
(1790, "Джоэл", "Силвер", 1952, 1),
(20397, "Фрэнк", "Маршалл", 1946, 1),
(15755, "Дэмиэн", "Джонс", 1964, 3),
(65747, "Донна", "Джильотти", 1995, 9);

insert into screenwriters 
(screenwriter_id, screenwriter_name, screenwriter_surname, birth_year, country_id) values
(32385, "Фрэнсис", "Уолш", 1959, 2),
(41477, "Кристофер", "Нолан", 1970, 3),
(10093, "Стивен", "Кловз", 1960, 1),
(27977, "Джеймс", "Кэмерон", 1954, 6),
(734897, "Марк", "Смит", 0, 9),
(8442, "Уэс", "Крэйвен", 1939, 1),
(30871, "Тед", "Эллиот", 1961, 1),
(90096, "Ян", "Сарди", 0, 4),
(30966, "Роберт", "Родригес", 1968, 1),
(23329, "Лилли", "Вачовски", 1967, 1),
(26537, "Лоуренс", "Кэздан", 1949, 1),
(1190793, "Эби", "Морган", 1968, 3),
(36297, "Дэвид", "Хэа", 1947,3);

insert into genres (genre_id, genre_name) values
(5, "фентези"),
(2, "Фантастика"),
(8, "Драма"),
(4, "Триллер"),
(1, "Ужасы"),
(10, "Приключения"),
(22, "Биография");

insert into films (film_id, film_name, release_year, rating, director_id, producer_id, screenwriter_id, country_id, genre_id) values
(3498, "Властелин колец: Возвращение Короля", 2003, 8.611, 32383, 32383, 32385, 1, 5),
(111543, "Темный рыцарь", 2008, 8.502, 41477, 41477, 41477, 1, 2),
(689, "Гарри Поттер и философский камень", 2001, 8.193, 24817, 23449, 10093, 3, 5),
(2213, "Титаник", 1997, 8.371, 27977, 27977, 27977, 1, 8),
(522941, "Выживший", 2015, 7.814, 563585, 6784, 734897, 1, 4),
(5198, "Кошмар на улице Вязов", 1984, 7.703, 8442, 3023, 8442, 1, 1),
(4374, "Пираты Карибского моря:Проклятие Черной жемчужины", 2003, 8.342, 30870, 10207, 30871, 1, 5),
(16686, "Блеск", 1996, 7.870, 29361, 90143, 90096, 4, 8),
(477764, "Дети шпионов 4D", 2011, 3.695, 30966, 30966, 30966, 1, 2),
(301, "Матрица", 1999, 8.492, 23330, 1790, 23329, 1, 2),
(339, "Индиана Джонс: В поисках утраченного ковчега", 1981, 8.007, 22260, 20397, 26537, 1, 10),
(463647, "Железная леди", 2011, 7.013, 1190481, 15755, 1190793, 3, 22),
(63991, "Пираты Карибского моря: Сундук мертвеца", 2006, 8.098, 30870, 10207, 30871, 1, 5),
(688, "Гарри Поттер и Тайная комната", 2002, 8.030, 24817, 23449, 10093, 3, 5),
(325439, "Чтец", 2008, 7.935, 10346, 65747, 36297, 1, 8);

insert into actors (actor_id, actor_name, actor_surname, birth_year, country_id) values
(20287, "Элайджа", "Вуд", 1981, 1),
(10779, "Вигго", "Мортенсен", 1958, 1),
(28426, "Шон", "Эстин", 1971, 1),
(21495, "Кристиан", "Бэйл", 1974, 3),
(1183, "Хит", "Леджер", 1979, 4),
(6752, "Аарон", "Экхарт", 1968, 1),
(40778, "Дэниэл", "Рэдклифф", 1989, 3),
(40780, "Руперт", "Гринт", 1988, 3),
(40779, "Эмма", "Уотсон", 1990, 5),
(37859, "Леонардо", "ДиКаприо", 1974, 1),
(16653, "Роберт", "Инглунд", 1947, 1),
(21709, "Кейт", "Уинслет", 1975, 3),
(45019, "Билли", "Зейн", 1966, 1),
(39984, "Том", "Харди", 1977 , 3),
(671252, "Донал", "Глисон", 1983, 8),
(94877, "Хэзер", "Лэнгенкэмп", 1964, 1),
(6245, "Джонни", "Депп", 1963, 1),
(24683, "Джеффри", "Раш", 1951, 4),
(30875, "Орландо", "Блум", 1977, 3),
(7227, "Ноа", "Тейлор", 1969, 3),
(8012, "Армин", "Мюллер-Шталь", 1930, 11),
(21931, "Джессика", "Альба", 1981, 1),
(9278, "Дэнни", "Трехо", 1944, 1),
(1967244, "Роуэн", "Бланчард", 2001, 1),
(7836, "Киану", "Ривз", 1964, 12),
(9838, "Лоренс", "Фишбёрн", 1961, 1),
(6226, "Кэрри-Энн", "Мосс", 1967, 6),
(1491, "Хьюго", "Уивинг", 1960, 13),
(5679, "Харрисон", "Форд", 1942, 1),
(2674, "Карен", "Аллен", 1951, 1),
(141431, "Рональд", "Лейси", 1935, 3),
(23100, "Мэрил", "Стрип", 1949, 1),
(38704, "Джим", "Бродбент", 1949, 3),
(147467, "Сьюзэн", "Браун", 1946, 3),
(24302, "Кира", "Найтли", 1985, 3),
(22670, "Рэйф", "Файнс", 1962, 3),
(459452, "Давид", "Кросс", 1990, 11);


insert into actors_films (actor_id, film_id, character_name) values
(20287, 3498, "Frodo"),
(10779, 3498, "Aragorn"),
(28426, 3498, "Sam"),
(30875, 3498, "Legolas"),
(21495, 111543, "Bruce Wayne"),
(1183, 111543, "Joker"),
(6752, 111543, "Harvey Dent"),
(40778, 689, "Harry Potter"),
(40780, 689, "Ron Weasley"),
(40779, 689, "Hermione Granger"),
(37859, 2213, "Jack Dawson"),
(21709, 2213, "Rose DeWitt Bukater"),
(45019, 2213, "Cal Hockley"),
(37859, 522941, "Hugh Glass"),
(39984, 522941, "John Fitzgerald"),
(671252, 522941, "Captain Andrew Henry"),
(16653, 5198, "Fred Krueger"),
(94877, 5198, "Nancy Thompson"),
(6245, 5198, "Glen Lantz"),
(6245, 4374, "Jack Sparrow"),
(24683, 4374, "Barbossa"),
(30875, 4374, "Will Turner"),
(24683, 16686, "David Helfgott - Adult"),
(7227, 16686, "David Helfgott - Adolescent"),
(8012, 16686, "Peter"),
(21931, 477764, "Marissa Wilson"),
(9278, 477764, "Uncle Machete"),
(1967244, 477764, "Rebecca Wilson"),
(7836, 301, "Neo"),
(9838, 301, "Morpheus"),
(6226, 301, "Trinity"),
(1491, 301, "Agent Smith"),
(5679, 339, "Indy"),
(2674, 339, "Marion Ravenwood"),
(141431, 339, "Major Arnold Toht"),
(23100, 463647, "Margaret Thatcher"),
(38704, 463647, "Denis Thatcher"),
(147467, 463647, "June"),
(6245, 63991, "Jack Sparrow"),
(30875, 63991, "Will Turner"),
(24302, 63991, "Elizabeth Swann"),
(40778, 688, "Harry Potter"),
(40780, 688, "Ron Weasley"),
(40779, 688, "Hermione Granger"),
(22670, 325439, "Michael Berg"),
(21709, 325439, "Hanna Schmitz"),
(459452, 325439, "Young Michael Berg");


insert into rewardings_Oscar (rewarding_year, actor_id, film_id, nomination) values
(2009, 1183, 111543, "Лучшая мужская роль второго плана"),
(2016, 37859, 522941, "Лучшая мужская роль"),
(1997, 24683, 16686, "Лучшая мужская роль"),
(2012, 23100, 463647, "Лучшая женская роль"),
(2009, 21709, 325439, "Лучшая женская роль");