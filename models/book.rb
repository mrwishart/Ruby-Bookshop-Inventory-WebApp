require_relative('../db/sql_runner')
require_relative('./genre')
require_relative('./author')
require_relative('./bookgenre')
require_relative('./bookauthor')
require_relative('./wholesaler')

class Book

  attr_accessor :description, :edition, :year_published, :quantity, :wholesale_id, :rrp
  attr_writer :title
  attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @edition = params['edition']
    @year_published = params['year_published'].to_i
    @rrp = params['rrp'].to_f.round(2)
    @quantity = params['quantity'].to_i
    @description = params['description']
    @wholesale_id = params['wholesale_id']
    @self_published_split = 50.00
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
    sql = "INSERT INTO books (title, description, rrp, edition, year_published, quantity, wholesale_id) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id"
    values = [@title.downcase, @description, @rrp, @edition, @year_published, @quantity, @wholesale_id]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE books SET (title, description, rrp, edition, year_published, quantity, wholesale_id) = ($1, $2, $3, $4, $5, $7, $8) WHERE id = $6"
    values = [@title.downcase, @description, @rrp, @edition, @year_published, @id, @quantity, @wholesale_id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM books WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # Genre methods

  def genres
    sql = "SELECT genres.* from genres INNER JOIN bookgenres ON bookgenres.genre_id = genres.id WHERE bookgenres.book_id = $1 ORDER BY genres.title"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|genre| Genre.new(genre)}
  end

# Method designed to aid the add-genre screen

  def other_genres
    sql = "SELECT genres.*
    FROM genres
    WHERE genres.id NOT IN (
    SELECT genre_id
    FROM bookgenres
    WHERE $1 = bookgenres.book_id)"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|genre| Genre.new(genre)}
  end

  def add_genre(genre)
    # If book already has genre, return
    return nil if genres().include?(genre)
    #Create new BookGenre object
    bg = BookGenre.new({"book_id" => @id, "genre_id" => genre.id})
    #Save to db
    bg.save

    return bg
  end

  # Author functions

  def authors
    sql = "SELECT authors.* from authors INNER JOIN bookauthors ON bookauthors.author_id = authors.id WHERE bookauthors.book_id = $1 ORDER BY authors.last_name"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|author| Author.new(author)}
  end

  def other_authors
    sql = "SELECT authors.*
    FROM authors
    WHERE authors.id NOT IN (
    SELECT author_id
    FROM bookauthors
    WHERE $1 = bookauthors.book_id)"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|author| Author.new(author)}
  end

  def add_author(author)
    # If book already has author, return
    return nil if authors().include?(author)
    #Create  new BookAuthor object
    ba = BookAuthor.new({"book_id" => @id, "author_id" => author.id})
    #Save to db
    ba.save

    return ba
  end

  # Wholesaler functions

  def wholesaler
    # If book is self-published, return nil
    return nil if @wholesale_id.nil?

    sql = "SELECT wholesalers.*
    FROM wholesalers
    WHERE id = $1"
    values = [@wholesale_id]
    result = SqlRunner.run(sql, values)
    return Wholesaler.new(result[0])
  end

  def discount
    book_wholesale = wholesaler()
    # If there is no wholesale, return standard split
    return @self_published_split if book_wholesale.nil?
    #Otherwise, return wholesaler's discount
    return book_wholesale.discount_offered.round(2)
  end

  def profit
    return (@rrp*(discount()/100)).round(2)
  end

  def value_owed
    return (@rrp - profit).round(2)
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
