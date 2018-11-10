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

  def save
    sql = "INSERT INTO genres (title) VALUES ($1) RETURNING id"
    values = [@title.downcase]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  # Reader function

  def title
    return @title.downcase.capitalize
  end

end
