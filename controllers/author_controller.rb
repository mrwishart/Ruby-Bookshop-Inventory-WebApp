require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/author')

#
get '/author' do
  @authors = Author.all()
  erb(:"author/index")
end
