require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/book')

#
get '/book' do
  @books = Book.all()
  erb(:"book/index")
end
