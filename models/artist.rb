require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id, :name
  attr_writer :name

  # options will be a hash
  def initialize(options)
    @id = options['id'].to_i if options['id'] # if exists
    @name = options['name']
  end

  def save() # save to db. Called on artist object.
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id;" # returns id of new row.
    values = [@name]
    result = SqlRunner.run(sql, values) # returns array of hash with the new id created for the artist entry.
    @id = result[0]['id'].to_i # puts new id into the object.
  end

  def self.list_all() # calls on Artist class.
    sql = "SELECT * FROM artists;"
    results = SqlRunner.run(sql) # array of hashes.
    return artists = results.map{ |artist_hash| Artist.new(artist_hash) } # maps into array of Artist objects.
  end

  def albums() # returns albums related to an artist id. Called on an artist object.
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id] # id of artist called on.
    albums = SqlRunner.run(sql, values) # array of hashes.
    return albums.map { |albums_hash| Album.new(albums_hash) } # maps into array of Album objects.
  end

  def update() # updates db after re-setting a variable. Called on an artist object.
    sql = "UPDATE artists SET name = $1 WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete() # deletes from db. Called on artist object.
    sql = "DELETE FROM artists WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # retrieves an artist row from the db and puts into an artist object, given id.
  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [id] # id given.
    result = SqlRunner.run(sql, values) # array of hashes with one hash.
    artist_hash = result.first # returns hash.
    return Artist.new(artist_hash) # puts into an artist object.
  end

end
