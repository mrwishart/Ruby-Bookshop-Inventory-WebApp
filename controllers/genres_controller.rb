require('sinatra')
require('sinatra/contrib/all') if development?
# also_reload('./models/*')

require_relative('../models/genre')

# INDEX
get '/genres' do
  @genres = Genre.all()
  erb(:"genres/index")
end

# NEW

get '/genres/new' do
  erb(:"genres/new")
end

# CREATE

post '/genres' do
  params['title'] = "Blank" if params['title'].empty?
  Genre.new(params).save
  redirect to '/genres'
end

# SHOW
get '/genres/:id' do
  @genre = Genre.find_by_id(params['id'])
  if @genre.nil?
    erb(:'not_found')
  else
  erb(:"genres/show")
  end
end

# EDIT

get '/genres/:id/edit' do
  @genre = Genre.find_by_id(params['id'])
  if @genre.nil?
    erb(:'not_found')
  else
    erb(:'genres/edit')
  end
end

# UPDATE

post '/genres/:id' do
  params['title'] = "Blank" if params['title'].empty?
  @genre = Genre.new(params)
  @genre.update
  redirect to '/genres/' + @genre.id.to_s
end

# DELETE

post '/genres/:id/delete' do
  @genre = Genre.find_by_id(params['id'])
  if @genre.nil?
    redirect to '/not_found'
  else
    @genre.delete
    redirect to '/genres'
  end
end
