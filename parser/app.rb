name_index = 4 # индекс id в ссыдке
genre_inex = 5
country_index = 5
s = [1000, 2000, 5000, 2500]
50.times do |i|
  id = 1000 + i

  page_link = "https://www.kinopoisk.ru/film/#{id}"
  page = Nokogiri::HTML(open(page_link))

  name = page.css("#headerFilm h1").text
  year = page.css("#infoTable .info tr[0] a").text
  rating = page.css(".rating_stars .block2 .rating_ball").text

  temp = page.css("#infoTable .info tr[3] a:first").href
  director =
  if directors[director_id: temp.split('/')[name_index]] != nil then
    temp.split('/')[name_index]
  end
  nameParser(temp, "directors")

  temp = page.css("#infoTable .info tr[4] a:first").href
  producer =
  if producers[producer_id: temp.split('/')[name_index]] != nil then
    temp.split('/')[name_index]
  end
  nameParser(temp, "producers")

  temp = page.css("#infoTable .info tr[4] a:first").href
  screenwriter =
  if screenwriters[screenwriter_id: temp.split('/')[name_index]] != nil then
    temp.split('/')[name_index]
  end
  nameParser(temp, "screenwriters")

  temp = page.css("#infoTable .info tr[2] a:first")
  country =
  if countries[country_id: temp.href.split('/')[country_index]] != nil then
    temp.href.split('/')[country_index]
  end
  DB.transaction do
    countries.insert(
      :country_id => temp.href.split('/')[country_index]
      :country_name => temp.text
    )
  end

  temp = page.css("#infoTable .info tr[10] a:first")
  genre =
  if genres[genre_id: temp.href.split('/')[genre_inex]] != nil then
    temp.href.split('/')[genre_inex]
  else
    DB.transaction do
      genres.insert(
      :genre_id => temp.href.split('/')[genre_inex]
      :genre_name => temp.text
      )
    end
  end

  actorsParser(page_link+"/cast")

  sleep(s[rand(s.length)])
end


def nameParser href, db_name
  page = Nokogiri::HTML(open(href))
  id = href.split('/')[name_index]
  name = page.css("#headerPeople h1").text.split(' ')[0]
  surname = page.css("#headerPeople h1").text.split(' ')[1]
  year = page.css("#infoTable .info tr[1] a[1]").text

  temp = page.css("#infoTable .info tr[2] a[2]")xt
  country =
  if countries[country_id: temp.href.split('/')[country_index]] != nil then
    temp.href.split('/')[country_index]
  end
  DB.transaction do
    countries.insert(
      :country_id => temp.href.split('/')[country_index]
      :country_name => temp.text
    )
  end

  DB.transaction do
    case db_name
    when "directors"
      directors.insert(
      :director_id => id
      :director_name => name
      :director_surname => surname
      :birth_year => year
      :country_id => country
      )
    when "producers"
      producers.insert(
      :producer_id => id
      :producer_name => name
      :producer_surname => surname
      :birth_year => year
      :country_id => country
      )
    when "screenwriters"
      screenwriters.insert(
      :screenwriter_id => id
      :screenwriter_name => name
      :screenwriter_surname => surname
      :birth_year => year
      :country_id => country
      )
    when "actors"
      actors.insert(
      :actor_id => id
      :actor_name => name
      :actor_surname => surname
      :birth_year => year
      :country_id => country
      )
    end
  end
end


def actorsParser
  #TODO: 
end
