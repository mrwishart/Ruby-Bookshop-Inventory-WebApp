require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/genre')

# INDEX
get '/genre' do
  @genres = Genre.all()
  erb(:"genre/index")
end

# SHOW
get '/genre/:id' do
  @genre = Genre.find(params['id'])
  if @genre.nil?
    erb(:'404')
  else
  erb(:"genre/show")
  end
end
