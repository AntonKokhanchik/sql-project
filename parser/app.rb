require 'sequel'
require 'mysql2'
require 'hash_dot'
require 'nokogiri'
require 'open-uri'
require 'yaml'

@config = YAML.load_file('config.yml').to_dot

DB = Sequel.connect(
  adapter: 'mysql2',
  host: @config.db_host,
  database: @config.db_name,
  user: @config.db_user,
  password: @config.db_password
)

@countries = DB[:countries]
@actors = DB[:actors]
@genres = DB[:genres]
@directors = DB[:directors]
@producers = DB[:producers]
@screenwriters = DB[:screenwriters]
@films = DB[:films]
@actors_films = DB[:actors_films]
@rewardings_Oscar = DB[:rewardings_Oscar]

@name_index = 4 # индекс id в ссыдке
@genre_inex = 5
@link = 'https://www.kinopoisk.ru'

def nameParser(href, db_name)
  sleep rand(10..30)
  page = Nokogiri::HTML(open(href))
  id = href.split('/')[@name_index]

  name = page.css('#headerPeople h1').text.split(' ')[0]
  puts name
  surname = page.css('#headerPeople h1').text.split(' ')[1]

  year =
    if page.css('#infoTable .info tr:nth-child(2) .type').text == 'дата рождения'
      if page.css('#infoTable .info tr:nth-child(2) a:nth-child(2)') != nil
        page.css('#infoTable .info tr:nth-child(2) a:nth-child(2)').text
      else
        '0'
      end
    elsif page.css('#infoTable .info tr:nth-child(3) .type').text == 'дата рождения'
      if page.css('#infoTable .info tr:nth-child(3) a:nth-child(2)') != nil
        page.css('#infoTable .info tr:nth-child(3) a:nth-child(2)').text
      else
        '0'
      end
    else
      '0'
    end
  year = 0 unless year =~ /\A\d+\Z/

  temp =
    if page.css('#infoTable .info tr:nth-child(3) .type').text == 'место рождения'
      if page.css('#infoTable .info tr:nth-child(3) span a:nth-child(3)')[0] != nil
        page.css('#infoTable .info tr:nth-child(3) span a:nth-child(3)')[0].text
      elsif page.css('#infoTable .info tr:nth-child(3) span a:nth-child(2)')[0] != nil
        page.css('#infoTable .info tr:nth-child(3) span a:nth-child(2)')[0].text
      else
        'неизвестно'
      end
    elsif page.css('#infoTable .info tr:nth-child(4) .type').text == 'место рождения'
      if page.css('#infoTable .info tr:nth-child(4) span a:nth-child(3)')[0] != nil
        page.css('#infoTable .info tr:nth-child(4) span a:nth-child(3)')[0].text
      elsif page.css('#infoTable .info tr:nth-child(4) span a:nth-child(2)')[0] != nil
        page.css('#infoTable .info tr:nth-child(4) span a:nth-child(2)')[0].text
      else
        'неизвестно'
      end
    else
      'неизвестно'
    end
  if @countries[country_name: temp].nil?
    DB.transaction do
      @countries.insert(country_name: temp)
    end
  end
  country = @countries.where(country_name: temp).first[:country_id]

  DB.transaction do
    case db_name
    when 'directors'
      @directors.insert(
        director_id: id,
        director_name: name,
        director_surname: surname,
        birth_year: year,
        country_id: country
      )
    when 'producers'
      @producers.insert(
        producer_id: id,
        producer_name: name,
        producer_surname: surname,
        birth_year: year,
        country_id: country
      )
    when 'screenwriters'
      @screenwriters.insert(
        screenwriter_id: id,
        screenwriter_name: name,
        screenwriter_surname: surname,
        birth_year: year,
        country_id: country
      )
    when 'actors'
      @actors.insert(
        actor_id: id,
        actor_name: name,
        actor_surname: surname,
        birth_year: year,
        country_id: country
      )
    end
  end
end

def actorsParser(href, id)
  page = Nokogiri::HTML(open(href))

  5.times do |i|
    temp = @link + page.css('#block_left > div > div.dub > div.actorInfo > div.info > div.name > a')[i + 1]['href']
    actor = temp.split('/')[@name_index]
    role = page.css('#block_left > div > div.dub > div.actorInfo > div.info > div.role')[i + 1].text
    puts role

    nameParser(temp, 'actors') if @actors[actor_id: actor].nil?
    DB.transaction do
      @actors_films.insert(
        film_id: id,
        actor_id: actor,
        character_name: role
      )
    end
  end
end

1.times do |i|
  id = 6542 + i

  page_link = @link + "/film/#{id}"
  page = Nokogiri::HTML(open(page_link))

  name = page.css('#headerFilm h1').text
  puts name
  year = page.css('#infoTable .info tr:nth-child(1) a').text
  puts year
  rating = page.css('#block_rating div div a .rating_ball').text
  rating = 0 unless rating =~ /\A\d+\Z/
  puts rating
  temp = @link + page.css('#infoTable .info tr:nth-child(4) a')[0]['href']
  director = temp.split('/')[@name_index]
  nameParser(temp, 'directors') if @directors[director_id: director].nil?
  puts director

  temp = @link + page.css('#infoTable .info tr:nth-child(6) a:first-child')[0]['href']
  producer = temp.split('/')[@name_index]
  nameParser(temp, 'producers') if @producers[producer_id: producer].nil?
  puts producer

  temp = @link + page.css('#infoTable .info tr:nth-child(5) a:first-child')[0]['href']
  screenwriter = temp.split('/')[@name_index]
  if @screenwriters[screenwriter_id: screenwriter].nil?
    nameParser(temp, 'screenwriters')
  end
  puts screenwriter

  temp = page.css('#infoTable .info tr:nth-child(2) a:first-child')[0].text
  if @countries[country_name: temp].nil?
    DB.transaction do
      @countries.insert(country_name: temp)
    end
  end
  country = @countries.where(country_name: temp).first[:country_id]
  puts country

  temp = page.css('#infoTable .info tr:nth-child(11) a:first-child')[0]
  genre = (@link + temp['href']).split('/')[@genre_inex]
  if @genres[genre_id: genre].nil?
    DB.transaction do
      @genres.insert(
        genre_id: genre,
        genre_name: temp.text
      )
    end
  end
  puts genre

  DB.transaction do
    @films.insert(
      film_id: id,
      film_name: name,
      release_year: year,
      rating: rating,
      director_id: director,
      producer_id: producer,
      screenwriter_id: screenwriter,
      country_id: country,
      genre_id: genre
    )
  end

  sleep(rand(30..60))
  actorsParser(page_link + '/cast', id)

  sleep(rand((30..60)))
end
