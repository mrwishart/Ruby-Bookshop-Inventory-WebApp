class BookGenre

attr_accessor :book_id, :genre_id
attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @book_id = params['book_id']
    @genre_id = params['genre_id']
  end

  # Class functions

  def self.all
    sql = "SELECT * FROM bookgenres"
    results = SqlRunner.run(sql)
    return results.map {|bookgenre| BookGenre.new(bookgenre)}
  end

  def self.delete_all
    sql = "DELETE FROM bookgenres"
    SqlRunner.run(sql)
  end

  def self.find(input_id)
    sql = "SELECT * FROM bookgenres WHERE id = $1"
    values = [input_id]
    result = SqlRunner.run(sql, values)
    return BookGenre.new(result.first)
  end

  # Instance functions

  def save
    sql = "INSERT INTO bookgenres (book_id, genre_id) VALUES ($1, $2) RETURNING id"
    values = [@book_id, @genre_id]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

end
