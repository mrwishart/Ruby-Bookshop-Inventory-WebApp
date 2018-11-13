class BookAuthor

attr_accessor :book_id, :author_id
attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @book_id = params['book_id']
    @author_id = params['author_id']
  end

  # Class functions

  def self.all
    sql = "SELECT * FROM bookauthors"
    results = SqlRunner.run(sql)
    return results.map {|bookauthor| BookAuthor.new(bookauthor)}
  end

  def self.delete_all
    sql = "DELETE FROM bookauthors"
    SqlRunner.run(sql)
  end

  def self.find(input_id)
    sql = "SELECT * FROM bookauthors WHERE id = $1"
    values = [input_id]
    result = SqlRunner.run(sql, values)
    return BookAuthor.new(result.first)
  end

  def self.clear_books_authors(book)
    sql = "DELETE FROM bookauthors WHERE book_id = $1"
    values = [book.id]
    result = SqlRunner.run(sql, values)
  end

  # Instance functions

  def save
    sql = "INSERT INTO bookauthors (book_id, author_id) VALUES ($1, $2) RETURNING id"
    values = [@book_id, @author_id]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE bookauthors SET (book_id, author_id) = ($1, $2) WHERE id = $3"
    values = [@book_id, @author_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM bookauthors where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
