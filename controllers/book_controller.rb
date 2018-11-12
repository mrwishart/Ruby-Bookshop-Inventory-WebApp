require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/book')

#
get '/book/:id' do
  @book = Book.find_by_id(params['id'])
  erb (:"book/show")
end

get '/book' do
  @books = Book.all()
  erb(:"book/index")
end
