require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/book')
require_relative('../models/wholesaler')

# INDEX

get '/books' do
  @books = Book.all()
  erb(:"books/index")
end

# NEW

get '/books/new' do
  @wholesalers = Wholesaler.all()
  erb(:"books/new")
end

# CREATE

post '/books' do
  Book.new(params).save
  redirect to '/books'
end


# SHOW

get '/books/:id' do
  @book = Book.find_by_id(params['id'])
  erb (:"books/show")
end
