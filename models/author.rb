require_relative('../db/sql_runner')

class Author

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @first_name = params['first_name']
    @last_name = params['last_name']
  end

  # Class functions

  def self.delete_all
    sql = "DELETE FROM authors"
    SqlRunner.run(sql)
  end

  def self.find_by_id(input_id)
    sql = "SELECT * FROM authors WHERE id = $1"
    values = [input_id]
    result = SqlRunner.run(sql, values)
    return Author.new(result.first)
  end

  # Instance functions

  def save
    sql = "INSERT INTO authors (first_name, last_name) VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE authors SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM authors where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
