require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/book')

#
get '/books/:id' do
  @book = Book.find_by_id(params['id'])
  erb (:"books/show")
end

get '/books' do
  @books = Book.all()
  erb(:"books/index")
end
