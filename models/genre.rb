require_relative('../db/sql_runner')

class Genre

  attr_writer :title
  attr_reader :id

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
  end

  # Class functions

  # Instance functions

  # Reader function

  def title
    return @title.downcase.capitalize
  end

end
