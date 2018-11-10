require_relative('../db/sql_runner')

class Book

  attr_accessor :description, :edition, :year_published
  attr_writer :title
  attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @description = params['description']
    @edition = params['edition'].to_i
    @year_published = params['year_published'].to_i
  end

  # Class functions

  def self.all
    sql = "SELECT * FROM books ORDER BY title"
    results = SqlRunner.run(sql)
    return results.map {|book| Book.new(book)}
  end

  def self.delete_all
    sql = "DELETE FROM books"
    SqlRunner.run(sql)
  end

  # Instance functions

  def save
    sql = "INSERT INTO books (title, description, edition, year_published) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@title.downcase, @description, @edition, @year_published]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  # Reader function

  def title
    return @title.downcase.capitalize
  end

end
