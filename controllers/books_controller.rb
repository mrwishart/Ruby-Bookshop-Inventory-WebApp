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

post '/books' do
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


# SHOW

get '/books/:id' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/404'
  else
   erb (:"books/show")
  end
end

# EDIT

get '/books/:id/edit' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/404'
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
  new_book.add_genres(params['genre_ids'])
  redirect to '/books/' + new_book.id.to_s
end

# DELETE

post '/books/:id/delete' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/404'
  else
    @book.delete
    redirect to '/books'
  end
end
