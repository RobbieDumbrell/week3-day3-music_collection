require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :title, :genre, :artist_id
  attr_writer :title, :genre

  # options will be a hash
  def initialize(options)
    @id = options['id'].to_i if options['id'] # if exists.
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save() # save to db. Called on album object.
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;" # returns id of new row.
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values) # returns array of hash with the new id created for the artist entry.
    @id = result[0]['id'].to_i # puts new id into the object.
  end

  def self.list_all() # calls on Album class.
    sql = "SELECT * FROM albums;"
    results = SqlRunner.run(sql) # array of hashes.
    return albums = results.map{ |album_hash| Album.new(album_hash) } # maps into array of Artist objects.
  end

  def artist() # returns artist related to an album's artist_id. Called on an artist object.
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first # only one artist will ever come back.
    return Artist.new(artist_hash) # creates artist as an Artist object.
  end

  def update() # updates db after re-setting a variable. Called on an album object.
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4;"
    values = [@title, @genre, artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete() # deletes from db. Called on album object.
    sql = "DELETE FROM albums WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # retrieves an album row from the db and puts into an album object, given id.
  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    values = [id] # id given.
    result = SqlRunner.run(sql, values) # array of hashes with one hash.
    album_hash = result.first # returns hash.
    return Album.new(album_hash) # puts into an album object.
  end

end
