require_relative('../db/sql_runner')
require_relative('./genre')

class Book

  attr_accessor :description, :edition, :year_published
  attr_writer :title
  attr_reader :id, :rrp

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @description = params['description']
    @rrp = params['rrp'].to_f
    @edition = params['edition']
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

  def self.find_by_id(input_id)
    sql = "SELECT * FROM books WHERE id = $1"
    values = [input_id]
    result = SqlRunner.run(sql, values)
    return Book.new(result.first)
  end

  # Instance functions

  def save
    sql = "INSERT INTO books (title, description, rrp, edition, year_published) VALUES ($1, $2, $3, $4, $5) RETURNING id"
    values = [@title.downcase, @description, @rrp, @edition, @year_published]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE books SET (title, description, rrp, edition, year_published) = ($1, $2, $3, $4, $5) WHERE id = $6"
    values = [@title.downcase, @description, @rrp, @edition, @year_published, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM books WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def genres
    sql = "SELECT genres.* from genres INNER JOIN bookgenres ON bookgenres.genre_id = genres.id WHERE bookgenres.book_id = $1 ORDER BY genres.title"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|genre| Genre.new(genre)}
  end

  # Reader function

  def title
    return capitalize_title(@title)
  end

  def capitalize_title(title)
    # Split string into array
    title_array = title.downcase.split
    # Capitalize each word
    title_array.each{|word| word.capitalize!}
    # Return completed string
    return title_array.join(" ")
  end

end
