require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/book')
require_relative('../models/wholesaler')
require_relative('../models/author')
require_relative('../models/genre')
require_relative('../models/bookauthor')

# INDEX

get '/books' do
  @books = Book.all()
  erb(:"books/index")
end

# NEW

get '/books/new' do
  @wholesalers = Wholesaler.all()
  @authors = Author.all()
  @genres = Genre.all()
  erb(:"books/new")
end

# CREATE

post '/books/create' do
  # If self-published, delete wholesale_id tag to avoid error
  params.delete('wholesale_id') if params['wholesale_id'] == '0'
  # Avoid user not entering book title and being unable to edit
  params['title'] = "No Title" if params['title'] == ""
  new_book = Book.new(params)
  new_book.save
  new_book.add_authors(params['author_ids'])
  new_book.add_genres(params['genre_ids'])
  redirect to '/books'
end

# SEARCH

post '/books' do
  # If title field is empty, return all books
  if params['search_title'] == "" || params['search_title'].nil?
    @books = Book.all()
  else
    # Otherwise, find books by the string
    @books = Book.find_by_string(params['search_title'])
  end

  # If author field isn't empty, remove books that don't fit author input
  if params['search_author'] != "" && !params['search_author'].nil?
    @books = Book.search_authors(@books, params['search_author'])
  end

  erb(:"books/index")
end


# SHOW

get '/books/:id' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/not_found'
  else
   erb (:"books/show")
  end
end

# EDIT

get '/books/:id/edit' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/not_found'
  else
    @authors = Author.all()
    @genres = Genre.all()
    @wholesalers = Wholesaler.all()
    erb (:"books/edit")
  end
end

# UPDATE

post '/books/:id' do
  # If self-published, delete wholesale_id tag to avoid error
  params.delete('wholesale_id') if params['wholesale_id'] == '0'
  # Avoid user not entering book title and being unable to edit
  params['title'] = "No Title" if params['title'] == ""
  new_book = Book.new(params)
  new_book.update
  new_book.update_authors(params['author_ids'])
  new_book.update_genres(params['genre_ids'])
  redirect to '/books/' + new_book.id.to_s
end

# DELETE

post '/books/:id/delete' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/not_found'
  else
    @book.delete
    redirect to '/books'
  end
end
