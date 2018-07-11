class Artist

  attr_reader :id, :name
  attr_writer :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

end
