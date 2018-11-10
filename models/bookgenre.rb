class BookGenre

attr_accessor :book_id, :genre_id
attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @book_id = params['book_id']
    @genre_id = params['genre_id']
  end

end
