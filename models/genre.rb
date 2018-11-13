require_relative('../db/sql_runner')
require_relative('./book')

class Genre

  attr_writer :title
  attr_reader :id

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
  end

  # Class functions

  def self.all
    sql = "SELECT * FROM genres ORDER BY title"
    results = SqlRunner.run(sql)
    return results.map {|genre| Genre.new(genre)}
  end

  def self.delete_all
    sql = "DELETE FROM genres"
    SqlRunner.run(sql)
  end

  def self.find_by_id(input_id)
    sql = "SELECT * FROM genres WHERE id = $1"
    values = [input_id]
    result = SqlRunner.run(sql, values)
    return nil if result.count == 0
    return Genre.new(result.first)
  end

  # Instance functions

  def save
    sql = "INSERT INTO genres (title) VALUES ($1) RETURNING id"
    values = [@title.downcase]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE genres SET title = $1 WHERE id = $2"
    values = [@title.downcase, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM genres where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # Books function

  def books
    sql = "SELECT books.*
    FROM books
    INNER JOIN bookgenres
    ON bookgenres.book_id = books.id
    WHERE bookgenres.genre_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|book| Book.new(book)}
  end

  # Reader function

  def title
    return @title.downcase.capitalize
  end

  def ==(other)
    self.id == other.id
  end

end
