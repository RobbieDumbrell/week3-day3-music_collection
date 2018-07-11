require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :title, :genre, :artist_id
  attr_writer :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;"
    values = [@title, @genre, @artist_id]
    artists = SqlRunner.run(sql, values)
    @id = artists[0]['id'].to_i
  end

  def self.list_all
    sql = "SELECT * FROM albums;"
    results = SqlRunner.run(sql)
    return albums = results.map{ |album_hash| Album.new(album_hash) }
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first # only one artist will ever come back.
    return Artist.new(artist_hash)
  end

end
