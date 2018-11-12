require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/genre')

# INDEX
get '/genre' do
  @genres = Genre.all()
  erb(:"genre/index")
end

# NEW

get '/genre/new' do
  erb(:"genre/new")
end

# CREATE

post '/genre' do
  Genre.new(params).save
  redirect to '/genre'
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

# EDIT

get '/genre/:id/edit' do
  @genre = Genre.find(params['id'])
  if @genre.nil?
    erb(:'404')
  else
    erb(:'genre/edit')
  end
end

# UPDATE

post '/genre/:id' do
  @genre = Genre.new(params)
  @genre.update
  redirect to '/genre/' + @genre.id.to_s
end
