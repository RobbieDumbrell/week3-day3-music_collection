require('pg') # requires pg (postgres)

class SqlRunner
  def self.run(sql, values = []) # sql code, and values to be put in, default values is empty array.
    begin
      db = PG.connect({ dbname: 'music_collection', host: 'localhost' }) # connect to database.
      db.prepare("query", sql) # prepare query with defined sql code.
      result = db.exec_prepared("query", values) # return PG::Result as a variable result.
    ensure
      db.close() if db != nil # close database connection if it managed to open.
    end
    return result
  end
end
