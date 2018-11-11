require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/genre')

#
get '/genre' do
  @genres = Genre.all()
  erb(:"genre/index")
end
