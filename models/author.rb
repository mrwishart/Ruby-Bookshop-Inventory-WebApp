require_relative('../db/sql_runner')
require_relative('./book')

class Author

  attr_writer :first_name, :last_name
  attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @first_name = params['first_name']
    @last_name = params['last_name']
  end

  # Class functions

  def self.all
    sql = "SELECT * FROM authors ORDER BY last_name"
    results = SqlRunner.run(sql)
    return results.map {|author| Author.new(author)}
  end

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

  def self.find_by_name(name)
    sql = "SELECT * FROM authors WHERE first_name = $1 OR last_name = $1 ORDER BY last_name"
    values = [name.downcase]
    results = SqlRunner.run(sql, values)
    return results.map {|author| Author.new(author)}
  end

  # Instance functions (note: all info going to db downcased to ease searchs)

  def save
    sql = "INSERT INTO authors (first_name, last_name) VALUES ($1, $2) RETURNING id"
    values = [@first_name.downcase, @last_name.downcase]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE authors SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name.downcase, @last_name.downcase, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM authors where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def ==(other)
    self.id == other.id
  end

  # Books function

  def books
    sql = "SELECT books.*
    FROM books
    INNER JOIN bookauthors
    ON bookauthors.book_id = books.id
    WHERE bookauthors.author_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|book| Book.new(book)}
  end

  # Reader functions - Added for prettier output to user.

  def first_name
    return @first_name.downcase.capitalize
  end

  def last_name
    return @last_name.downcase.capitalize
  end

  def pretty_name
    return first_name() + ' ' + last_name()
  end

end
