require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id, :name
  attr_writer :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id;"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.list_all
    sql = "SELECT * FROM artists;"
    results = SqlRunner.run(sql)
    return artists = results.map{ |artist_hash| Artist.new(artist_hash) }
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map { |albums_hash| Album.new(albums_hash) }
  end

end
